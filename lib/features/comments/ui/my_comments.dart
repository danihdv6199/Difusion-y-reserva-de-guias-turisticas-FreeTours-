import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:freetour_tfg/features/app/ui/theme/extension.dart';
import 'package:freetour_tfg/features/models.dart';
import 'package:freetour_tfg/features/providers.dart';
import 'package:freetour_tfg/features/services.dart';
import 'package:provider/provider.dart';

class MyCommentsScreen extends StatefulWidget {
  const MyCommentsScreen({Key? key}) : super(key: key);

  @override
  State<MyCommentsScreen> createState() => _MyCommentsScreenState();
}

class _MyCommentsScreenState extends State<MyCommentsScreen> {
  @override
  Widget build(BuildContext context) {
    final service = Provider.of<CommentServices>(context);
    final userservice = Provider.of<UsersRols>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Mis Comentarios'),
        ),
        body: FutureBuilder(
            future: service.getCommetsByUser(userservice.loggedInUser.userk),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              } else {
                final coms = snapshot.data as List<Comment>;

                if (coms.isEmpty) {
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
                      Text('Aún no hay comentarios para esta guía',
                          style: context.bodyMedium),
                    ],
                  ));
                } else {
                  return ListView.builder(
                    itemCount: coms.length,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    itemBuilder: (BuildContext context, int i) {
                      final com = coms[i];
                      return Dismissible(
                        key: Key(coms[i].commentid!),
                        background: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.red))),
                        direction: DismissDirection.endToStart,
                        onDismissed: (DismissDirection direction) {
                          setState(() {
                            showDialog(
                                context: context,
                                builder: (_) {
                                  return CommentDelete(
                                      com: com, service: service);
                                });
                            coms.removeAt(i).commentid;
                          });
                        },
                        child: Card(
                            elevation: 15,
                            child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Row(children: [
                                      Text(
                                        com.title!,
                                        style: context.bodyLarge,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const Expanded(child: SizedBox()),
                                      Text(
                                        com.rating.toString(),
                                        style: context.bodyLarge,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      RatingBar.builder(
                                        ignoreGestures: true,
                                        initialRating: com.rating!,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemPadding: const EdgeInsets.symmetric(
                                            horizontal: 1.0),
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        itemSize: 20,
                                        onRatingUpdate: (rating) {},
                                      ),
                                    ]),
                                    const Divider(),
                                    const SizedBox(height: 10),
                                    SizedBox(
                                      width: double.infinity,
                                      child: Text(com.comment!,
                                          textAlign: TextAlign.justify,
                                          style: context.bodyMedium),
                                    ),
                                  ],
                                ))),
                      );
                    },
                  );
                }
              }
            }));
  }
}

class CommentDelete extends StatelessWidget {
  const CommentDelete({
    Key? key,
    required this.com,
    required this.service,
  }) : super(key: key);

  final Comment com;
  final CommentServices service;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Borrar Comentario',
        style: context.bodyMedium,
      ),
      content: Text(
          'Si presiona "Borrar" se borrá el comentario de forma permanente',
          style: context.bodyMedium),
      actions: [
        ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel')),
        ElevatedButton(
            onPressed: () {
              service.deleteComment(
                  com.commentid!, com.tourid!, com.reservationid!);
              Navigator.pop(context);
            },
            child: const Text(
              'Borrar Comentario',
            ))
      ],
    );
  }
}
