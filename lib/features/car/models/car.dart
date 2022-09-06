import 'package:cloud_firestore/cloud_firestore.dart';

class Car {
  Car(
      {this.reservations,
      this.tourPrice,
      this.tourPriceTotal,
      this.tourTitle,
      this.tourid,
      this.tourimg,
      this.tourpeople,
      this.userid,
      this.itemid});

  String? itemid;
  String? userid;
  String? tourid;
  String? tourimg;
  String? tourTitle;
  double? tourPrice;
  double? tourPriceTotal;
  int? tourpeople;
  int? reservations;

  factory Car.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();

    return Car(
      itemid: snapshot.id,
      reservations: data?["reservations"],
      tourPrice: data?["tourPrice"],
      tourPriceTotal: data?["tourPriceTotal"],
      tourTitle: data?["tourTitle"],
      tourid: data?["tourid"],
      tourimg: data?["tourimg"],
      tourpeople: data?["tourpeople"],
      userid: data?["userid"],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (reservations != null) "reservations": reservations,
      if (tourPrice != null) "tourPrice": tourPrice,
      if (tourPriceTotal != null) "tourPriceTotal": tourPriceTotal,
      if (tourTitle != null) "tourTitle": tourTitle,
      if (tourid != null) "tourid": tourid,
      if (tourimg != null) "tourimg": tourimg,
      if (tourpeople != null) "tourpeople": tourpeople,
      if (userid != null) "userid": userid,
    };
  }
}
