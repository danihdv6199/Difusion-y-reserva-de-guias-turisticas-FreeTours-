import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freetour_tfg/features/app/notifications/notifications.dart';
import 'package:freetour_tfg/features/providers.dart';
import 'package:freetour_tfg/features/services.dart';
import 'package:map_launcher/map_launcher.dart';

import 'package:freetour_tfg/features/app/ui/theme/extension.dart';
import 'package:freetour_tfg/features/models.dart';
import 'package:provider/provider.dart';

class ButtonsSection extends StatefulWidget {
  const ButtonsSection({
    Key? key,
    required this.tour,
  }) : super(key: key);
  final Tour tour;

  @override
  State<ButtonsSection> createState() => _ButtonsSectionState();
}

class _ButtonsSectionState extends State<ButtonsSection> {
  int _person = 0;
  double _total = 0.0;

  @override
  Widget build(BuildContext context) {
    final tour = widget.tour;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Divider(),
      ),
      Center(
        child: Container(
          width: 200,
          decoration: BoxDecoration(
              color: context.colors.outline,
              borderRadius: BorderRadius.circular(15)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: _person == 0
                      ? null
                      : () {
                          setState(() {
                            _person = _person - 1;
                            _total = _person * tour.price!;
                          });
                        },
                  icon: Icon(
                    Icons.remove_circle_outline_outlined,
                    color: context.colors.error,
                  )),
              Text('$_person Personas', style: context.titleSmall),
              IconButton(
                  onPressed: tour.people == _person
                      ? null
                      : () {
                          setState(() {
                            _person = _person + 1;
                            _total = _person * tour.price!;
                          });
                        },
                  icon: Icon(
                    Icons.add_circle_outline_outlined,
                    color: context.colors.surfaceTint,
                  )),
            ],
          ),
        ),
      ),
      const SizedBox(height: 15),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Precio por persona: ${tour.price} €',
              style: context.bodyMedium),
          Text('Total: $_total €', style: context.bodyMedium),
        ],
      ),
      const SizedBox(height: 15),
      Center(
        child: ElevatedButton(
            onPressed: _person == 0
                ? null
                : () => addTourToCar(_person, _total, tour, context),
            child: Text('Agregar a carrito', style: context.titleSmall)),
      ),
      const SizedBox(height: 15),
      Center(
        child: ElevatedButton(
            onPressed: () => checkAvailableAndShow(
                tour.location!, tour.title!, tour.description!),
            child: Text('Ubicación', style: context.titleSmall)),
      ),
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Divider(),
      ),
    ]);
  }

  addTourToCar(int reservations, double total, Tour tour, context) {
    final userservice = Provider.of<UsersRols>(context, listen: false);
    final carservice = Provider.of<CarService>(context, listen: false);
    final user = userservice.loggedInUser.userk;
    Map<String, dynamic> data = {
      "userid": user,
      "tourid": tour.id,
      "tourimg": tour.imgurl,
      "tourTitle": tour.title,
      "tourPrice": tour.price,
      "tourPriceTotal": total,
      "tourpeople": tour.people,
      "reservations": reservations
    };
    carservice.addCarItems(data);
    NotificationProvider.successAlert('Se agregó correctamente tu reserva');
  }

  checkAvailableAndShow(
      GeoPoint direction, String name, String description) async {
    double lat = direction.latitude;
    double lng = direction.longitude;
    bool isGoogleMaps =
        await MapLauncher.isMapAvailable(MapType.google) ?? false;

    if (isGoogleMaps) {
      await MapLauncher.showMarker(
        mapType: MapType.google,
        coords: Coords(lat, lng),
        title: name,
        description: description,
      );
    }
  }
}
