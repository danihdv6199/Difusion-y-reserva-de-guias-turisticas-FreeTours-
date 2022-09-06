import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freetour_tfg/features/models.dart';
import 'package:http/http.dart' as http;

class ToursServices extends ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<Tour> tours = [];
  ToursServices() {
    getTours();
  }

  Future getTours() async {
    await firestore.collection("tours").get().then((event) {
      for (var doc in event.docs) {
        final tem = doc.data();
        final tour = Tour.fromJson(tem);
        tours.add(tour);
      }
      notifyListeners();
    });
  }

  Future<List<Tour>> getTourbyCity(city, uid) async {
    final query = firestore
        .collection("tours")
        .where("city", isEqualTo: city)
        .withConverter(
            fromFirestore: Tour.fromFirestore,
            toFirestore: (Tour tour, _) => tour.toFirestore());

    final snap = await query.get();
    List<Tour> toursbycity = [];
    if (snap.docs.isEmpty) {
      return toursbycity;
    } else {
      for (var tour in snap.docs) {
        toursbycity.add(tour.data());
      }
      return toursbycity;
    }
  }

  Future<List<Tour>> getTourbyUser(String uid) async {
    final query = firestore
        .collection("tours")
        .where("usercreate", isEqualTo: uid)
        .withConverter(
            fromFirestore: Tour.fromFirestore,
            toFirestore: (Tour tour, _) => tour.toFirestore());

    final snap = await query.get();
    List<Tour> toursbycity = [];
    if (snap.docs.isEmpty) {
      return toursbycity;
    } else {
      for (var tour in snap.docs) {
        toursbycity.add(tour.data());
      }
      return toursbycity;
    }
  }

  Future getTour(tourid) async {
    final query = firestore.collection("tours").doc(tourid).withConverter(
        fromFirestore: Tour.fromFirestore,
        toFirestore: (Tour tour, _) => tour.toFirestore());

    final snap = await query.get();
    final Tour? tour = snap.data();

    return tour;
  }

  Future editTours(String tourid, Map<String, dynamic> data) async {
    await firestore.collection('tours').doc(tourid).update(data);
  }

  Future addTours(Map<String, dynamic> data) async {
    await firestore.collection('tours').add(data);
  }

  Future<String?> addTourImagen(path) async {
    final image = File(path);

    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/dtgak4p66/image/upload?upload_preset=kdk4rdix');

    final imageUploadRequest = http.MultipartRequest('POST', url);
    final file = await http.MultipartFile.fromPath('file', image.path);
    imageUploadRequest.files.add(file);
    final streamResponse = await imageUploadRequest.send();
    final response = await http.Response.fromStream(streamResponse);

    if (response.statusCode != 200 && response.statusCode != 201) {
      return null;
    }
    final decodeData = json.decode(response.body);
    return decodeData['secure_url'];
  }
}
