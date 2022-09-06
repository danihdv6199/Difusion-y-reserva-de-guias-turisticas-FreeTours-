import 'package:flutter/material.dart';
import 'package:freetour_tfg/features/models.dart';
import 'package:freetour_tfg/features/widgets.dart';
import 'package:freetour_tfg/features/app/ui/theme/extension.dart';

class ToursList extends StatelessWidget {
  const ToursList({
    Key? key,
    required this.tours,
    required this.size,
  }) : super(key: key);

  final List<Tour> tours;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
      final tour = tours[index];

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: GestureDetector(
          child: Stack(children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: size.width * 0.9,
                height: 200,
                child: FadeInImage(
                  fit: BoxFit.fitWidth,
                  image: NetworkImage(tour.imgurl!),
                  placeholder: const AssetImage('assets/loading.gif'),
                ),
              ),
            ),
            Positioned(
                left: 10,
                bottom: 10,
                child: TextChip(
                  color: context.colors.tertiary,
                  style: context.titleSmall,
                  text: tour.title!,
                )),
          ]),
          onTap: () =>
              Navigator.pushNamed(context, 'detailsGuide', arguments: tour),
        ),
      );
    }, childCount: tours.length));
  }
}
