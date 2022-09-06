import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:image_picker/image_picker.dart';

import 'package:freetour_tfg/features/providers.dart';
import 'package:freetour_tfg/features/services.dart';
import 'package:freetour_tfg/features/widgets.dart';
import 'package:freetour_tfg/features/app/notifications/notifications.dart';
import 'package:freetour_tfg/features/app/ui/theme/extension.dart';

class NewTourScreen extends StatefulWidget {
  const NewTourScreen({Key? key}) : super(key: key);

  @override
  State<NewTourScreen> createState() => _NewTourScreenState();
}

class _NewTourScreenState extends State<NewTourScreen> {
  bool _confirmation = false;
  bool _rest = false;
  bool _groupr = false;
  bool _pets = false;
  bool _kids = false;
  bool _car = false;
  bool _creditCar = false;
  bool _audiology = false;
  bool _accessible = false;

  String _currentItemSelected = "Sevilla";
  String city = "Sevilla";

  @override
  Widget build(BuildContext context) {
    final format = DateFormat("yyyy-MM-dd");
    final cityService = Provider.of<CitiesService>(context);
    final tourP = Provider.of<NewTourProvider>(context);
    final cities = cityService.citiesName;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Nueva Guia'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Form(
                key: tourP.newGuide,
                child: Column(
                  children: [
                    const SizedBox(height: 15),
                    DropdownButton<String>(
                      elevation: 0,
                      borderRadius: BorderRadius.circular(10),
                      dropdownColor:
                          context.colors.background.withOpacity(0.95),
                      isDense: true,
                      isExpanded: false,
                      iconEnabledColor: context.colors.primary,
                      items: cities.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(
                            dropDownStringItem,
                            style: context.bodyMedium,
                          ),
                        );
                      }).toList(),
                      onChanged: (newValueSelected) {
                        setState(() {
                          _currentItemSelected = newValueSelected!;
                          tourP.city = _currentItemSelected;
                        });
                      },
                      value: _currentItemSelected,
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            hintStyle: context.bodySmall,
                            hintText: 'Título de la guía'),
                        onChanged: (value) => tourP.title = value,
                        validator: (value) => tourP.isValidTitle(value),
                        style: context.bodyMedium),
                    const SizedBox(height: 15),
                    TextFormField(
                        minLines: 6,
                        maxLines: 7,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            hintStyle: context.bodySmall,
                            hintText: 'Descripción'),
                        validator: (value) => tourP.isValidDescription(value),
                        onChanged: (value) => tourP.description = value,
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
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            hintText: 'Ubicación 40.416488, -3.703774',
                            hintStyle: context.bodySmall),
                        validator: (value) => tourP.isValidLocation(value),
                        onChanged: (value) => tourP.location = value,
                        style: context.bodyMedium),
                    const SizedBox(height: 15),
                    TextFormField(
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            hintText: 'Número de personas',
                            hintStyle: context.bodySmall),
                        validator: (value) => tourP.isValidPerson(value),
                        onChanged: (value) => tourP.people = value,
                        style: context.bodyMedium),
                    const SizedBox(height: 15),
                    TextFormField(
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        validator: (value) => tourP.isValidPrice(value),
                        onChanged: (value) => tourP.price = value,
                        decoration: InputDecoration(
                            hintText: 'Precio por persona',
                            hintStyle: context.bodySmall),
                        style: context.bodyMedium),
                    const SizedBox(height: 15),
                    TextFormField(
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        validator: (value) => tourP.isValidIdiom(value),
                        onChanged: (value) => tourP.idiom = value,
                        decoration: InputDecoration(
                            hintText: 'Idioma', hintStyle: context.bodySmall),
                        style: context.bodyMedium),
                    const SizedBox(height: 15),
                    TextFormField(
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        validator: (value) => tourP.isValidTime(value),
                        onChanged: (value) => tourP.time = value,
                        decoration: InputDecoration(
                            hintText: 'Duración en minutos',
                            hintStyle: context.bodySmall),
                        style: context.bodyMedium),
                    const SizedBox(height: 15),
                    TextFormField(
                        keyboardType: TextInputType.datetime,
                        textInputAction: TextInputAction.next,
                        validator: (value) => tourP.isValidHour(value),
                        onChanged: (value) => tourP.hour = value,
                        decoration: InputDecoration(
                            hintText: 'Hora 10:20',
                            hintStyle: context.bodySmall),
                        style: context.bodyMedium),
                    const SizedBox(height: 15),
                    DateTimeField(
                      format: format,
                      onShowPicker: (context, currentValue) {
                        return showDatePicker(
                            context: context,
                            firstDate: DateTime(1900),
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: DateTime(2100));
                      },
                      decoration: InputDecoration(
                          hintText: 'Fecha', hintStyle: context.bodySmall),
                      style: context.bodyMedium,
                      onChanged: (value) => tourP.date = value!,
                      validator: ((value) => tourP.isValidDate(value)),
                    ),
                    FormFeacturesRows(
                        itemName: 'Audiología Disponible',
                        icon: Icons.headphones,
                        onChanged: (value) {
                          setState(() {
                            _audiology = value!;
                            tourP.audiology = value;
                          });
                        },
                        value: _audiology),
                    FormFeacturesRows(
                        itemName: 'Acceso para minusválidos',
                        icon: Icons.accessible_outlined,
                        onChanged: (value) {
                          setState(() {
                            _accessible = value!;
                            tourP.access = value;
                          });
                        },
                        value: _accessible),
                    FormFeacturesRows(
                        itemName: 'Pago con tarjeta',
                        icon: Icons.credit_card_outlined,
                        onChanged: (value) {
                          setState(() {
                            _creditCar = value!;
                            tourP.creditCar = value;
                          });
                        },
                        value: _creditCar),
                    FormFeacturesRows(
                        itemName: 'Confirmación inmediata',
                        icon: Icons.bolt_outlined,
                        onChanged: (value) {
                          setState(() {
                            _confirmation = value!;
                            tourP.confirmation = value;
                          });
                        },
                        value: _confirmation),
                    FormFeacturesRows(
                        itemName: 'Recogida en domicilio',
                        icon: Icons.directions_car_outlined,
                        onChanged: (value) {
                          setState(() {
                            _car = value!;
                            tourP.car = value;
                          });
                        },
                        value: _car),
                    FormFeacturesRows(
                        itemName: 'Descansos',
                        icon: Icons.local_cafe_outlined,
                        onChanged: (value) {
                          setState(() {
                            _rest = value!;
                            tourP.rest = value;
                          });
                        },
                        value: _rest),
                    FormFeacturesRows(
                        itemName: 'Grupo reducidos',
                        icon: Icons.people_outlined,
                        onChanged: (value) {
                          setState(() {
                            _groupr = value!;
                            tourP.groupr = value;
                          });
                        },
                        value: _groupr),
                    FormFeacturesRows(
                        itemName: 'Apto para niños',
                        icon: Icons.child_friendly_outlined,
                        onChanged: (value) {
                          setState(() {
                            _kids = value!;
                            tourP.kids = value;
                          });
                        },
                        value: _kids),
                    FormFeacturesRows(
                        itemName: 'Permite mascotas',
                        icon: Icons.pets_outlined,
                        onChanged: (value) {
                          setState(() {
                            _pets = value!;
                            tourP.pets = value;
                          });
                        },
                        value: _pets),
                    const SizedBox(height: 15),
                    ElevatedButton(
                        onPressed: () => addTour(context, tourP),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [Text('Crear nueva guía')]))
                  ],
                ),
              ),
            )));
  }

  addTour(context, NewTourProvider provider) async {
    FocusScope.of(context).unfocus();
    final service = Provider.of<ToursServices>(context, listen: false);
    final user =
        Provider.of<UsersRols>(context, listen: false).loggedInUser.userk;
    if (provider.isValidForm()) {
      final lat =
          provider.location.substring(0, provider.location.indexOf(','));
      final log =
          provider.location.substring(provider.location.indexOf(',') + 2);
      final data = <String, dynamic>{
        "title": provider.title,
        "description": provider.description,
        "urlimage": provider.urlimage,
        "idiom": provider.idiom,
        "city": provider.city,
        "date": provider.date,
        "audiology": provider.audiology,
        "access": provider.access,
        "car": provider.car,
        "confirmation": provider.confirmation,
        "creditCar": provider.creditCar,
        "groupr": provider.groupr,
        "kids": provider.kids,
        "pets": provider.pets,
        "rest": provider.rest,
        "hour": provider.hour,
        "people": int.parse(provider.people),
        "reservations": int.parse('0'),
        "time": int.parse(provider.time),
        "likes": int.parse('0'),
        "comments": int.parse('0'),
        "price": double.parse(provider.price),
        "average": double.parse('0.0'),
        "location": GeoPoint(double.parse(lat), double.parse(log)),
        'usercreate': user
      };

      await service.addTours(data);
      NotificationProvider.successAlert('Se Agregó la nueva guía');
    } else {}
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
