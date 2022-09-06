import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:freetour_tfg/features/app/ui/theme/extension.dart';
import 'package:freetour_tfg/features/models.dart';
import 'package:freetour_tfg/features/providers.dart';
import 'package:freetour_tfg/features/services.dart';
import 'package:freetour_tfg/features/widgets.dart';

class GuidesScreen extends StatelessWidget {
  const GuidesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userservice = Provider.of<UsersRols>(context, listen: false);
    final tourservice = Provider.of<ToursServices>(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Guias'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: tourservice.getTourbyUser(userservice.loggedInUser.userk!),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final tours = snapshot.data as List<Tour>;
          if (tours.isEmpty) {
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
                Text('Aún no agregas una guía', style: context.bodyMedium),
              ],
            ));
          } else {
            return ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: tours.length,
              itemBuilder: (BuildContext context, int index) {
                final tour = tours[index];

                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                      Positioned(
                          right: 10,
                          top: 10,
                          child: TextChip(
                            color: context.colors.tertiary,
                            style: context.titleSmall,
                            text: 'Editar',
                          )),
                      Positioned(
                          left: 10,
                          top: 10,
                          child: TextChip(
                            color: context.colors.secondary,
                            style: context.titleSmall,
                            text: 'Reserva: ${tour.reservations}',
                          )),
                    ]),
                    onTap: () => Navigator.pushNamed(context, 'editguide',
                        arguments: tour),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
