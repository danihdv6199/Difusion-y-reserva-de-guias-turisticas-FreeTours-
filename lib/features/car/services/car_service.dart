import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freetour_tfg/features/models.dart';

class CarService extends ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future getCarItems(userid) async {
    final query = firestore
        .collection("car")
        .where("userid", isEqualTo: userid)
        .withConverter(
            fromFirestore: Car.fromFirestore,
            toFirestore: (Car car, _) => car.toFirestore());

    final snap = await query.get();
    List<Car> caritems = [];
    if (snap.docs.isEmpty) {
      return caritems;
    } else {
      for (var item in snap.docs) {
        caritems.add(item.data());
        notifyListeners();
      }
      return caritems;
    }
  }

  Future addCarItems(Map<String, dynamic> data) async {
    await firestore.collection('car').add(data).whenComplete(() {});
  }

  Future deleteCarItem(itemid) async {
    firestore.collection("car").doc(itemid).delete();
  }

  Future deleteCarItems(userid) async {
    final items = await getCarItems(userid);
    for (var item in items) {
      firestore.collection("car").doc(item.itemid).delete();
    }
  }
}
