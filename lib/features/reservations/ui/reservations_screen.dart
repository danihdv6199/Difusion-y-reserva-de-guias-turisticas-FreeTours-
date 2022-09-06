import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:freetour_tfg/features/app/ui/theme/extension.dart';
import 'package:freetour_tfg/features/models.dart';
import 'package:freetour_tfg/features/providers.dart';
import 'package:freetour_tfg/features/services.dart';
import 'package:freetour_tfg/features/widgets.dart';

class ReservationsScreen extends StatefulWidget {
  const ReservationsScreen({Key? key}) : super(key: key);

  @override
  State<ReservationsScreen> createState() => _ReservationsScreenState();
}

class _ReservationsScreenState extends State<ReservationsScreen> {
  @override
  Widget build(BuildContext context) {
    final userid =
        Provider.of<UsersRols>(context, listen: false).loggedInUser.userk;
    final service = Provider.of<ReservationsService>(context);
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            title: const Icon(Icons.visibility_outlined)),
        body: FutureBuilder(
            future: service.getReservations(userid),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              } else {
                final reservations = snapshot.data as List<Reservation>;

                if (reservations.isEmpty) {
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
                      Text('Aún no has hecho una reserva',
                          style: context.bodyMedium),
                    ],
                  ));
                } else {
                  return Stack(
                    children: [
                      ListView.builder(
                        padding:
                            const EdgeInsets.only(top: 50, right: 15, left: 15),
                        itemCount: reservations.length,
                        itemBuilder: (BuildContext context, int index) {
                          final res = reservations[index];
                          return Dismissible(
                              key: Key(res.idReservation!),
                              background: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.red))),
                              child: GeneralContainer(
                                child: ListTile(
                                  isThreeLine: true,
                                  title: Text(
                                    res.title!,
                                    style: context.bodyLarge,
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Personas: ${res.reservations}  Costo: ${res.tourprice} €',
                                        style: context.bodySmall,
                                      ),
                                      Text('Total: ${res.totalprice} €',
                                          style: context.bodyMedium),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          LikeButton(
                                              tourid: res.tourid!,
                                              userid: userid!,
                                              service: service,
                                              res: res),
                                          CommentButton(res: res)
                                        ],
                                      ),
                                    ],
                                  ),
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.network(
                                      res.imgurl!,
                                      width: 55,
                                      height: 55,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  onTap: () {},
                                ),
                              ),
                              direction: DismissDirection.endToStart,
                              onDismissed: (DismissDirection direction) {
                                setState(() {
                                  showDialog(
                                      context: context,
                                      builder: (_) {
                                        return ReservationDelete(
                                            res: res, service: service);
                                      });
                                  reservations.removeAt(index).idReservation;
                                });
                              });
                        },
                      ),
                      Container(
                        color: context.colors.background,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.local_activity_outlined,
                              color: context.colors.primary,
                            ),
                            const SizedBox(width: 15),
                            Text('Mis Reservas', style: context.titleLarge),
                          ],
                        ),
                      )
                    ],
                  );
                }
              }
            }));
  }
}

class LikeButton extends StatefulWidget {
  const LikeButton({
    Key? key,
    required this.tourid,
    required this.userid,
    required this.service,
    required this.res,
  }) : super(key: key);

  final String tourid;
  final String userid;
  final ReservationsService service;
  final Reservation res;
  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  bool _like = false;
  @override
  Widget build(BuildContext context) {
    final tourService = Provider.of<ToursServices>(context);
    return FutureBuilder(
        future: tourService.getTour(widget.tourid),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Container();
          } else {
            final tour = snapshot.data as Tour;

            _like = widget.res.like!;
            return Row(
              children: [
                Text(tour.likes.toString(), style: context.bodyMedium),
                IconButton(
                    tooltip: 'Dar me gusta',
                    icon: _like
                        ? Icon(Icons.thumb_up_alt,
                            color: context.colors.primary)
                        : Icon(Icons.thumb_up_off_alt,
                            color: context.colors.primary),
                    onPressed: _like
                        ? () {
                            removelike(tour.id, widget.userid, tour.likes!,
                                widget.service, widget.res.idReservation!);
                            setState(() {
                              _like = false;
                            });
                          }
                        : () {
                            addLike(tour.id, widget.userid, tour.likes!,
                                widget.service, widget.res.idReservation!);
                            setState(() {
                              _like = true;
                            });
                          })
              ],
            );
          }
        });
  }
}

class CommentButton extends StatefulWidget {
  const CommentButton({
    Key? key,
    required this.res,
  }) : super(key: key);

  final Reservation res;
  @override
  State<CommentButton> createState() => _CommentButtonState();
}

class _CommentButtonState extends State<CommentButton> {
  bool _comment = false;
  @override
  Widget build(BuildContext context) {
    final tourService = Provider.of<ToursServices>(context);
    return FutureBuilder(
        future: tourService.getTour(widget.res.tourid),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Container();
          } else {
            final tour = snapshot.data as Tour;

            _comment = widget.res.comment!;
            return Row(
              children: [
                Text(tour.comments.toString(), style: context.bodyMedium),
                IconButton(
                  tooltip: 'Agregar Comentario',
                  icon: _comment
                      ? Icon(Icons.chat, color: context.colors.primary)
                      : Icon(Icons.chat_outlined,
                          color: context.colors.primary),
                  onPressed: _comment
                      ? null
                      : () => Navigator.pushNamed(context, 'addcomment',
                          arguments: widget.res),
                )
              ],
            );
          }
        });
  }
}

addLike(String? tourid, String userid, int tourlikes,
    ReservationsService service, String resid) {
  service.addLike(tourid!, tourlikes, userid, resid);
}

removelike(String? tourid, String userid, int tourlikes,
    ReservationsService service, String resid) {
  service.removeLike(tourid!, tourlikes, userid, resid);
}

class ReservationDelete extends StatelessWidget {
  const ReservationDelete({
    Key? key,
    required this.res,
    required this.service,
  }) : super(key: key);

  final Reservation res;
  final ReservationsService service;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Borrar Reserva',
        style: context.bodyMedium,
      ),
      content: Text(
          'Si presiona "Borrar" se borrá la reserva de forma permanente',
          style: context.bodyMedium),
      actions: [
        ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel')),
        ElevatedButton(
            onPressed: () {
              service.deleteReservation(res);
              Navigator.pop(context);
            },
            child: const Text(
              'Borrar Reserva',
            ))
      ],
    );
  }
}
