import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:freetour_tfg/features/app/ui/theme/extension.dart';
import 'package:freetour_tfg/features/models.dart';
import 'package:freetour_tfg/features/services.dart';
import 'package:freetour_tfg/features/widgets.dart';
import 'package:provider/provider.dart';

class ReviewSection extends StatelessWidget {
  const ReviewSection({Key? key, required this.tour}) : super(key: key);
  final Tour tour;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        children: [
          TextChip(
              color: context.colors.onSurfaceVariant,
              style: context.bodyMedium,
              text: 'Reseñas'),
          const Expanded(child: SizedBox()),
          Icon(
            Icons.thumb_up_alt,
            color: context.colors.primary,
          ),
          const SizedBox(width: 10),
          Text('${tour.likes} Me gusta', style: context.bodyMedium)
        ],
      ),
      const SizedBox(height: 15),
      Row(children: [
        RatingBar.builder(
          ignoreGestures: true,
          initialRating: tour.average!,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          itemSize: 25,
          onRatingUpdate: (rating) {},
        ),
        const SizedBox(width: 5),
        Text(tour.average.toString(), style: context.bodyLarge),
        const Expanded(child: SizedBox()),
        Text('(${tour.comments} Comentarios)', style: context.bodyMedium),
      ]),
      const SizedBox(height: 15),
      SizedBox(
          width: double.infinity, height: 500, child: Comentarios(tour: tour)),
    ]);
  }
}

class Comentarios extends StatelessWidget {
  const Comentarios({
    Key? key,
    required this.tour,
  }) : super(key: key);
  final Tour tour;

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<CommentServices>(context);
    return FutureBuilder(
        future: service.getCommentsbyTour(tour.id),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Container();
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
                padding: EdgeInsets.zero,
                itemBuilder: (BuildContext context, int i) {
                  final com = coms[i];
                  return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
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
                              ))));
                },
              );
            }
          }
        });
  }
}
