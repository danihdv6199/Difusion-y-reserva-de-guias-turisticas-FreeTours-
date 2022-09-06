import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:freetour_tfg/features/app/notifications/notifications.dart';
import 'package:freetour_tfg/features/app/ui/theme/extension.dart';
import 'package:freetour_tfg/features/models.dart';
import 'package:freetour_tfg/features/providers.dart';
import 'package:freetour_tfg/features/services.dart';
import 'package:freetour_tfg/features/widgets.dart';
import 'package:image_picker/image_picker.dart';

class EditTourScreen extends StatefulWidget {
  const EditTourScreen({Key? key}) : super(key: key);

  @override
  State<EditTourScreen> createState() => _EditTourScreenState();
}

class _EditTourScreenState extends State<EditTourScreen> {
  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Tour;

    final tourP = Provider.of<NewTourProvider>(context);
    DateTime date =
        DateTime.fromMicrosecondsSinceEpoch(arg.date!.microsecondsSinceEpoch);
    final format = DateFormat("yyyy-MM-dd");
    Map<String, dynamic> data = {
      "audiology": arg.audiology,
      "access": arg.access,
      "car": arg.car,
      "confirmation": arg.confirmation,
      "creditCar": arg.creditCar,
      "groupr": arg.groupr,
      "kids": arg.kids,
      "pets": arg.pets,
      "rest": arg.rest,
      "hour": arg.hour,
    };
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Editar Guia'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Form(
                key: tourP.editGuide,
                child: Column(
                  children: [
                    const SizedBox(height: 15),
                    TextFormField(
                        initialValue: arg.title,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            hintStyle: context.bodySmall,
                            hintText: 'Título de la guía'),
                        onChanged: (value) {
                          tourP.title = value;
                          data.addAll({"title": value});
                        },
                        validator: (value) => tourP.isValidTitle(value),
                        style: context.bodyMedium),
                    const SizedBox(height: 15),
                    TextFormField(
                        initialValue: arg.description,
                        minLines: 6,
                        maxLines: 7,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            hintStyle: context.bodySmall,
                            hintText: 'Descripción'),
                        validator: (value) => tourP.isValidDescription(value),
                        onChanged: (value) {
                          tourP.description = value;
                          data.addAll({"description": value});
                        },
                        style: context.bodyMedium),
                    const SizedBox(height: 15),
                    ElevatedButton.icon(
                        onPressed: () => addImage(tourP),
                        icon: Icon(Icons.photo_camera,
                            color: context.colors.background),
                        label:
                            Text('Agregar imagen', style: context.titleSmall)),
                    const SizedBox(height: 15),
                    TextFormField(
                        initialValue:
                            '${arg.location!.latitude}, ${arg.location!.longitude}',
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            hintText: 'Ubicación 40.416488, -3.703774',
                            hintStyle: context.bodySmall),
                        validator: (value) => tourP.isValidPerson(value),
                        onChanged: (value) => tourP.location = value,
                        style: context.bodyMedium),
                    const SizedBox(height: 15),
                    TextFormField(
                        initialValue: arg.idiom,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        validator: (value) => tourP.isValidIdiom(value),
                        onChanged: (value) {
                          tourP.idiom = value;
                          data.addAll({"idiom": value});
                        },
                        decoration: InputDecoration(
                            hintText: 'Idioma', hintStyle: context.bodySmall),
                        style: context.bodyMedium),
                    const SizedBox(height: 15),
                    TextFormField(
                        initialValue: arg.time.toString(),
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        validator: (value) => tourP.isValidTime(value),
                        onChanged: (value) {
                          tourP.time = value;
                          data.addAll({"time": value});
                        },
                        decoration: InputDecoration(
                            hintText: 'Duración en minutos',
                            hintStyle: context.bodySmall),
                        style: context.bodyMedium),
                    const SizedBox(height: 15),
                    TextFormField(
                        initialValue: arg.hour,
                        keyboardType: TextInputType.datetime,
                        textInputAction: TextInputAction.next,
                        validator: (value) => tourP.isValidHour(value),
                        onChanged: (value) {
                          tourP.hour = value;
                          data.addAll({"hour": value});
                        },
                        decoration: InputDecoration(
                            hintText: 'Hora 10:20',
                            hintStyle: context.bodySmall),
                        style: context.bodyMedium),
                    const SizedBox(height: 15),
                    DateTimeField(
                        initialValue: date,
                        format: format,
                        onShowPicker: (context, currentValue) {
                          return showDatePicker(
                              context: context,
                              firstDate: DateTime(2022),
                              initialDate: currentValue ?? DateTime.now(),
                              lastDate: DateTime(2100));
                        },
                        onChanged: (value) {
                          tourP.date = value;
                          data.addAll({"date": value});
                        },
                        decoration: InputDecoration(
                            hintText: 'Fecha', hintStyle: context.bodySmall),
                        style: context.bodyMedium),
                    FormFeacturesRows(
                        itemName: 'Audiología Disponible',
                        icon: Icons.headphones,
                        onChanged: (value) {
                          setState(() {
                            arg.audiology = value!;
                            tourP.audiology = value;
                          });
                        },
                        value: arg.audiology!),
                    FormFeacturesRows(
                        itemName: 'Acceso para minusválidos',
                        icon: Icons.accessible_outlined,
                        onChanged: (value) {
                          setState(() {
                            arg.access = value!;
                            tourP.access = value;
                          });
                        },
                        value: arg.access!),
                    FormFeacturesRows(
                        itemName: 'Pago con tarjeta',
                        icon: Icons.credit_card_outlined,
                        onChanged: (value) {
                          setState(() {
                            arg.creditCar = value!;
                            tourP.creditCar = value;
                          });
                        },
                        value: arg.creditCar!),
                    FormFeacturesRows(
                        itemName: 'Confirmación inmediata',
                        icon: Icons.bolt_outlined,
                        onChanged: (value) {
                          setState(() {
                            arg.confirmation = value!;
                            tourP.confirmation = value;
                          });
                        },
                        value: arg.confirmation!),
                    FormFeacturesRows(
                        itemName: 'Recogida en domicilio',
                        icon: Icons.directions_car_outlined,
                        onChanged: (value) {
                          setState(() {
                            arg.car = value!;
                            tourP.car = value;
                          });
                        },
                        value: arg.car!),
                    FormFeacturesRows(
                        itemName: 'Descansos',
                        icon: Icons.local_cafe_outlined,
                        onChanged: (value) {
                          setState(() {
                            arg.rest = value!;
                            tourP.rest = value;
                          });
                        },
                        value: arg.rest!),
                    FormFeacturesRows(
                        itemName: 'Grupo reducidos',
                        icon: Icons.people_outlined,
                        onChanged: (value) {
                          setState(() {
                            arg.groupr = value!;
                            tourP.groupr = value;
                          });
                        },
                        value: arg.groupr!),
                    FormFeacturesRows(
                        itemName: 'Apto para niños',
                        icon: Icons.child_friendly_outlined,
                        onChanged: (value) {
                          setState(() {
                            arg.kids = value!;
                            tourP.kids = value;
                          });
                        },
                        value: arg.kids!),
                    FormFeacturesRows(
                        itemName: 'Permite mascotas',
                        icon: Icons.pets_outlined,
                        onChanged: (value) {
                          setState(() {
                            arg.pets = value!;
                            tourP.pets = value;
                          });
                        },
                        value: arg.pets!),
                    const SizedBox(height: 15),
                    ElevatedButton(
                        onPressed: () => addTour(context, tourP, arg.id!, data),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [Text('Editar guía')]))
                  ],
                ),
              ),
            )));
  }

  addTour(context, NewTourProvider provider, String tourid, data) async {
    final service = Provider.of<ToursServices>(context, listen: false);
    FocusScope.of(context).unfocus();

    if (provider.urlimage == "") {
      await service.editTours(tourid, data);
    } else {
      data.addAll({"urlimage": provider.urlimage});
      await service.editTours(tourid, data);
    }
    NotificationProvider.successAlert('Se editó la guía');
    Navigator.pop(context);
  }

  addImage(provider) async {
    final piker = ImagePicker();
    final XFile? image = await piker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    final service = Provider.of<ToursServices>(context, listen: false);
    final String? resp = await service.addTourImagen(image.path);
    if (resp != null) {
      provider.urlimage = resp;

      NotificationProvider.successAlert('Se agregó la foto correctamente');
    } else {
      NotificationProvider.errorAlert(
          'Se produjo un error intentelo más tarde');
    }
  }
}
