import 'package:flutter/material.dart';
import 'package:freetour_tfg/features/models.dart';
import 'package:intl/intl.dart';
import 'package:freetour_tfg/features/widgets.dart';
import 'package:freetour_tfg/features/app/ui/theme/extension.dart';

class InfoSection extends StatelessWidget {
  const InfoSection({
    Key? key,
    required this.tour,
  }) : super(key: key);

  final Tour tour;
  @override
  Widget build(BuildContext context) {
    DateTime date =
        DateTime.fromMicrosecondsSinceEpoch(tour.date!.microsecondsSinceEpoch);
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final fomatDate = formatter.format(date);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextChip(
          text: 'Características',
          color: context.colors.onSurfaceVariant,
          style: context.bodyMedium,
        ),
        const SizedBox(height: 15),
        StaticFeacturesRows(
            itemName: 'Audiología Disponible',
            icon: Icons.headphones,
            active: tour.audiology!),
        StaticFeacturesRows(
            itemName: 'Acceso para minusválidos',
            icon: Icons.accessible_outlined,
            active: tour.access!),
        StaticFeacturesRows(
            itemName: 'Pago con tarjeta',
            icon: Icons.credit_card_outlined,
            active: tour.creditCar!),
        StaticFeacturesRows(
            itemName: 'Confirmación inmediata',
            icon: Icons.bolt_outlined,
            active: tour.confirmation!),
        StaticFeacturesRows(
            itemName: 'Recogida en domicilio',
            icon: Icons.directions_car_outlined,
            active: tour.car!),
        StaticFeacturesRows(
            itemName: 'Descansos',
            icon: Icons.local_cafe_outlined,
            active: tour.rest!),
        StaticFeacturesRows(
            itemName: 'Grupo reducidos',
            icon: Icons.people_outlined,
            active: tour.groupr!),
        StaticFeacturesRows(
            itemName: 'Apto para niños',
            icon: Icons.child_friendly_outlined,
            active: tour.kids!),
        StaticFeacturesRows(
            itemName: 'Permite mascotas',
            icon: Icons.pets_outlined,
            active: tour.pets!),
        Row(
          children: [
            Icon(Icons.record_voice_over_outlined,
                color: context.colors.inverseSurface),
            const SizedBox(width: 15),
            Text(
              'Idioma: ${tour.idiom}',
              overflow: TextOverflow.ellipsis,
              style: context.bodyMedium,
            )
          ],
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            Icon(Icons.hourglass_top, color: context.colors.inverseSurface),
            const SizedBox(width: 15),
            Text(
              'Duración: ${tour.time} min',
              overflow: TextOverflow.ellipsis,
              style: context.bodyMedium,
            ),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            Icon(Icons.today, color: context.colors.inverseSurface),
            const SizedBox(width: 15),
            Text(
              'Fecha: $fomatDate',
              overflow: TextOverflow.ellipsis,
              style: context.bodyMedium,
            ),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            Icon(Icons.schedule_outlined, color: context.colors.inverseSurface),
            const SizedBox(width: 15),
            Text(
              'Hora: ${tour.hour} min',
              overflow: TextOverflow.ellipsis,
              style: context.bodyMedium,
            ),
          ],
        ),
        const SizedBox(height: 15),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Divider(),
        ),
        TextChip(
          text: 'Descripción',
          color: context.colors.onSurfaceVariant,
          style: context.bodyMedium,
        ),
        const SizedBox(height: 15),
        SizedBox(
          width: double.infinity,
          child: Text(
            tour.description!,
            textAlign: TextAlign.justify,
            style: context.bodyMedium,
          ),
        ),
      ],
    );
  }
}
