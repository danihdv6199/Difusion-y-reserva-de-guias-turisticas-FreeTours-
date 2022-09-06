import 'package:flutter/material.dart';

class NewTourProvider extends ChangeNotifier {
  GlobalKey<FormState> newGuide = GlobalKey();
  GlobalKey<FormState> editGuide = GlobalKey();

  String title = '';
  String urlimage = '';
  String location = '';
  String description = '';
  String imgurl = '';
  String city = '';
  String hour = '';
  DateTime? date;
  String idiom = '';
  String time = '';
  String people = '0';
  String price = '0.0';
  bool audiology = false;
  bool access = false;
  bool confirmation = false;
  bool rest = false;
  bool groupr = false;
  bool pets = false;
  bool kids = false;
  bool car = false;
  bool creditCar = false;

  isValidTitle(value) {
    if (value.isNotEmpty) {
      return null;
    } else {
      return 'Ingrese el título';
    }
  }

  isValidDescription(value) {
    if (value.isNotEmpty) {
      return null;
    } else {
      return 'Ingrese el Descripción';
    }
  }

  isValidPerson(value) {
    if (value.isNotEmpty) {
      return null;
    } else {
      return 'Ingrese el numero de personas';
    }
  }

  isValidLocation(value) {
    if (value.isNotEmpty) {
      return null;
    } else {
      return 'Ingrese las coordenadas';
    }
  }

  isValidPrice(value) {
    if (value.isNotEmpty) {
      return null;
    } else {
      return 'Ingrese el precio';
    }
  }

  isValidIdiom(value) {
    if (value.isNotEmpty) {
      return null;
    } else {
      return 'Ingrese el idioma';
    }
  }

  isValidTime(value) {
    if (value.isNotEmpty) {
      return null;
    } else {
      return 'Ingrese la duración en minutos';
    }
  }

  isValidHour(value) {
    if (value.isNotEmpty) {
      return null;
    } else {
      return 'Ingrese la hora';
    }
  }

  isValidDate(value) {
    if (value != null) {
      return null;
    } else {
      return 'Ingrese una fecha';
    }
  }

  bool isValidForm() {
    return newGuide.currentState?.validate() ?? false;
  }

  bool isValidGuide() {
    return editGuide.currentState?.validate() ?? false;
  }
}
