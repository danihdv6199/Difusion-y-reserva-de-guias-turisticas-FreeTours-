import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:freetour_tfg/features/destinations/models/city.dart';

class CitiesService extends ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<City> cities = [];
  List<String> citiesName = [];

  final StreamController<List<City>> _controller = StreamController.broadcast();
  Stream<List<City>> get suggestions => _controller.stream;

  CitiesService() {
    getCities();
  }

  Future getCities() async {
    await firestore.collection("cities").get().then((event) {
      for (var doc in event.docs) {
        final tem = doc.data();
        final city = City.fromJson(tem);
        cities.add(city);
        citiesName.add(city.name!);
      }
      notifyListeners();
    });
  }
}
