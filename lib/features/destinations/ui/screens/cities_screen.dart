import 'package:flutter/material.dart';

import 'package:freetour_tfg/features/services.dart';
import 'package:freetour_tfg/features/widgets.dart';

import 'package:provider/provider.dart';
import 'package:freetour_tfg/features/app/ui/theme/extension.dart';

class CitiesScreen extends StatelessWidget {
  const CitiesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [CitiesList()],
        ),
      ),
    );
  }
}

class CitiesList extends StatelessWidget {
  const CitiesList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<CitiesService>(context);
    final cities = service.cities;

    final size = MediaQuery.of(context).size;
    return SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
      final city = cities[index];
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
                  image: NetworkImage(city.imgurl!),
                  placeholder: const AssetImage('assets/loading.gif'),
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextChip(
                  color: context.colors.secondary,
                  style: context.titleSmall,
                  text: city.name!,
                )),
          ]),
          onTap: () =>
              Navigator.pushNamed(context, 'selectedCity', arguments: city),
        ),
      );
    }, childCount: cities.length));
  }
}
