import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:freetour_tfg/features/app/ui/theme/extension.dart';
import 'package:freetour_tfg/features/models.dart';
import 'package:freetour_tfg/features/providers.dart';
import 'package:freetour_tfg/features/services.dart';
import 'package:freetour_tfg/features/widgets.dart';

class CarScreen extends StatelessWidget {
  const CarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userid =
        Provider.of<UsersRols>(context, listen: false).loggedInUser.userk;
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            title: const Icon(Icons.visibility_outlined)),
        body: CarList(userid: userid));
  }
}

class CarList extends StatefulWidget {
  const CarList({
    Key? key,
    required this.userid,
  }) : super(key: key);

  final String? userid;

  @override
  State<CarList> createState() => _CarListState();
}

class _CarListState extends State<CarList> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final carservice = Provider.of<CarService>(context);

    return FutureBuilder(
        future: carservice.getCarItems(widget.userid),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            final caritems = snapshot.data as List<Car>;

            if (caritems.isEmpty) {
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.upcoming,
                    size: 40,
                    color: context.colors.surfaceVariant,
                  ),
                  const SizedBox(height: 20),
                  Text('Aún no has agregado una guía al carrito.',
                      style: context.bodyMedium),
                ],
              ));
            } else {
              double total = 0.0;
              for (var item in caritems) {
                total = total + item.tourPriceTotal!;
              }

              return Stack(children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: ListView.builder(
                    itemCount: caritems.length,
                    itemBuilder: (BuildContext context, int index) {
                      final caritem = caritems[index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Dismissible(
                            key: Key(caritem.itemid!),
                            background: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.red)),
                            ),
                            child: GeneralContainer(
                              child: ListTile(
                                isThreeLine: true,
                                title: Text(
                                  caritem.tourTitle!,
                                  style: context.bodyLarge,
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Personas: ${caritem.reservations}  Costo: ${caritem.tourPrice} €',
                                      style: context.bodySmall,
                                    ),
                                    Text('Total: ${caritem.tourPriceTotal} €',
                                        style: context.bodyMedium),
                                  ],
                                ),
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.network(
                                    caritem.tourimg!,
                                    width: 55,
                                    height: 55,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                trailing: ElevatedButton(
                                    onPressed: () async {
                                      final validate = await validarReserva(
                                          caritem.tourid, caritem);
                                      if (validate) {
                                        setState(() {
                                          showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  ReservationAlert(
                                                    userid: widget.userid,
                                                    caritem: caritem,
                                                    carservice: carservice,
                                                  ));
                                        });
                                      } else {
                                        setState(() {
                                          showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  NoReservation(
                                                      caritem: caritem));
                                        });
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Text(
                                        'Reservar',
                                        style: context.titleSmall,
                                      ),
                                    )),
                                onTap: () {},
                              ),
                            ),
                            direction: DismissDirection.endToStart,
                            onDismissed: (DismissDirection direction) {
                              setState(() {
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return GuiaAlert(
                                          service: carservice,
                                          userid: widget.userid,
                                          carditem: caritem);
                                    });
                                caritems.removeAt(index).itemid;
                              });
                            }),
                      );
                    },
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: size.width,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    color: context.colors.onBackground.withOpacity(0.8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total: $total €',
                          style: context.headlineMedium,
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  color: context.colors.background,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Icon(
                        Icons.shopping_cart,
                        color: Colors.green,
                      ),
                      Text('Mi Carrito', style: context.titleLarge),
                      IconButton(
                          tooltip: 'Borrar todos',
                          onPressed: () {
                            setState(() {
                              showDialog(
                                  context: context,
                                  builder: (context) => DeleteAlert(
                                      userid: widget.userid,
                                      carItems: caritems,
                                      service: carservice));
                            });
                          },
                          icon:
                              Icon(Icons.delete, color: context.colors.surface))
                    ],
                  ),
                )
              ]);
            }
          }
        });
  }

  validarReserva(tourid, Car caritem) async {
    final service = Provider.of<ToursServices>(context, listen: false);
    final tour = await service.getTour(tourid) as Tour;
    if (caritem.reservations! > tour.people!) {
      return false;
    } else {
      return true;
    }
  }
}

class DeleteAlert extends StatelessWidget {
  const DeleteAlert(
      {Key? key,
      required this.carItems,
      required this.service,
      required this.userid})
      : super(key: key);

  final List<Car> carItems;
  final CarService service;
  final String? userid;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Borrar todos las guías',
        style: context.bodyMedium,
      ),
      content: Text(
          'Si presiona "Borrar Todo" se borran todas las guias del carrito forma permanente',
          style: context.bodyMedium),
      actions: [
        ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel')),
        ElevatedButton(
            onPressed: () {
              service.deleteCarItems(userid);
              Navigator.pop(context);
            },
            child: const Text(
              'Borrar Todo',
            ))
      ],
    );
  }
}

class GuiaAlert extends StatelessWidget {
  const GuiaAlert(
      {Key? key,
      required this.service,
      required this.userid,
      required this.carditem})
      : super(key: key);

  final Car carditem;
  final CarService service;
  final String? userid;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Borrar Guía',
        style: context.bodyMedium,
      ),
      content: Text(
          'Si presiona "Borrar" se borran la guia del carrito forma permanente',
          style: context.bodyMedium),
      actions: [
        ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel')),
        ElevatedButton(
            onPressed: () {
              service.deleteCarItem(carditem.itemid!);
              Navigator.pop(context);
            },
            child: const Text(
              'Borrar',
            ))
      ],
    );
  }
}

class ReservationAlert extends StatelessWidget {
  const ReservationAlert(
      {Key? key,
      required this.userid,
      required this.caritem,
      required this.carservice})
      : super(key: key);

  final Car caritem;

  final CarService carservice;
  final String? userid;

  @override
  Widget build(BuildContext context) {
    final resService = Provider.of<ReservationsService>(context, listen: false);
    Map<String, dynamic> data = {
      "userid": userid,
      "imgurl": caritem.tourimg,
      "title": caritem.tourTitle,
      "tourid": caritem.tourid,
      "reservations": caritem.reservations,
      "tourprice": caritem.tourPrice,
      "totalprice": caritem.tourPriceTotal,
      "tourpeople": caritem.tourpeople,
      "like": false,
      "comment": false,
    };
    return AlertDialog(
      title: Text(
        '¿Reservar ${caritem.tourTitle}?',
        style: context.bodyMedium,
      ),
      content: Text('¿Está seguro que desea reservar ${caritem.tourTitle}',
          style: context.bodyMedium),
      actions: [
        ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel')),
        ElevatedButton(
            onPressed: () {
              resService.addReservations(data);
              carservice.deleteCarItem(caritem.itemid);
              Navigator.pop(context);
            },
            child: const Text(
              'Reservar',
            ))
      ],
    );
  }
}

class NoReservation extends StatelessWidget {
  const NoReservation({
    Key? key,
    required this.caritem,
  }) : super(key: key);

  final Car caritem;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Lo sentimos',
        style: context.bodyMedium,
      ),
      content: Text(
          'No es posible reservar para ${caritem.reservations} personas.',
          style: context.bodyMedium),
      actions: [
        ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar')),
      ],
    );
  }
}
