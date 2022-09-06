import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:freetour_tfg/features/app/ui/theme/extension.dart';
import 'package:freetour_tfg/features/models.dart';
import 'package:freetour_tfg/features/providers.dart';
import 'package:freetour_tfg/features/services.dart';
import 'package:freetour_tfg/features/widgets.dart';

class ToursByCity extends StatelessWidget {
  const ToursByCity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final argument = ModalRoute.of(context)!.settings.arguments as City;
    final service = Provider.of<ToursServices>(context);
    final user = Provider.of<UsersRols>(context, listen: false);
    return FutureBuilder(
      future: service.getTourbyCity(argument.name, user.user!.uid),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final tours = snapshot.data as List<Tour>;

        return Scaffold(
          body: CustomScrollView(slivers: [
            ToursAppBar(argument: argument, size: size),
            tours.isEmpty
                ? NotTours(argument: argument)
                : ToursList(tours: tours, size: size)
          ]),
        );
      },
    );
  }
}

class NotTours extends StatelessWidget {
  const NotTours({
    Key? key,
    required this.argument,
  }) : super(key: key);

  final City argument;

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildListDelegate([
      const SizedBox(height: 200),
      Center(
          child: Column(
        children: [
          Icon(
            Icons.upcoming,
            size: 40,
            color: context.colors.surfaceVariant,
          ),
          const SizedBox(height: 20),
          Text(
            'Actualmente no hay guias en ${argument.name}',
            style: context.bodyMedium,
          ),
        ],
      ))
    ]));
  }
}
