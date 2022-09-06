import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freetour_tfg/features/models.dart';

class ReservationsService extends ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future getReservations(userid) async {
    final query = firestore
        .collection("reservations")
        .where("userid", isEqualTo: userid)
        .withConverter(
            fromFirestore: Reservation.fromFirestore,
            toFirestore: (Reservation reservation, _) =>
                reservation.toFirestore());

    final snap = await query.get();
    List<Reservation> res = [];
    if (snap.docs.isEmpty) {
      return res;
    } else {
      for (var item in snap.docs) {
        res.add(item.data());
        notifyListeners();
      }
      return res;
    }
  }

  Future addReservations(Map<String, dynamic> data) async {
    await firestore.collection('reservations').add(data).whenComplete(() {
      final reservations = data['reservations'];
      final total = data['tourpeople'];
      final people = {
        "people": total - reservations,
        "reservations": reservations
      };
      firestore.collection("tours").doc(data['tourid']).update(people);
    });
  }

  Future addLike(
      String tourid, int tourlikes, String userid, String resid) async {
    firestore.collection('tours').doc(tourid).update({"likes": tourlikes + 1});
    final data = {
      "tourid": tourid,
      "userid": userid,
    };
    firestore.collection('likes').add(data);
    firestore.collection('reservations').doc(resid).update({"like": true});
  }

  Future removeLike(
      String tourid, int tourlikes, String userid, String resid) async {
    firestore.collection('tours').doc(tourid).update({"likes": tourlikes - 1});
    final query = await firestore
        .collection('likes')
        .where('userid', isEqualTo: userid)
        .where('tourid', isEqualTo: tourid)
        .get();
    if (query.docs.isNotEmpty) {
      final likeid = query.docs.first.id;
      firestore.collection('likes').doc(likeid).delete();
    }
    firestore.collection('reservations').doc(resid).update({"like": false});
  }

  Future deleteReservation(Reservation res) async {
    await firestore.collection("reservations").doc(res.idReservation).delete();
    final query = firestore.collection('tours').doc(res.tourid).withConverter(
        fromFirestore: Tour.fromFirestore,
        toFirestore: (Tour tour, _) => tour.toFirestore());
    final snap = await query.get();

    if (snap.exists) {
      final people = snap.data()!.people;
      final now = {"people": res.reservations! + people!};
      await firestore.collection('tours').doc(res.tourid).update(now);
      notifyListeners();
    }
  }

  Future deleteReservations(userid) async {
    final reservations = await getReservations(userid);
    for (var reservation in reservations) {
      firestore
          .collection("reservations")
          .doc(reservation.idreservations)
          .delete();
    }
  }
}
