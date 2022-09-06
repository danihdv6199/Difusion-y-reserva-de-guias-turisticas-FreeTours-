import 'package:cloud_firestore/cloud_firestore.dart';

class Reservation {
  Reservation(
      {this.imgurl,
      this.userid,
      this.tourid,
      this.title,
      this.idReservation,
      this.like,
      this.reservations,
      this.totalprice,
      this.tourprice,
      this.comment,
      this.tourpeople});

  String? imgurl;
  String? title;
  String? userid;
  String? tourid;
  String? idReservation;
  int? reservations;
  int? tourpeople;
  bool? like;
  bool? comment;
  double? tourprice;
  double? totalprice;

  factory Reservation.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return Reservation(
      imgurl: data?['imgurl'],
      title: data?['title'],
      userid: data?['userid'],
      tourid: data?['tourid'],
      reservations: data?['reservations'],
      totalprice: data?['totalprice'],
      tourprice: data?['tourprice'],
      like: data?['like'],
      comment: data?['comment'],
      idReservation: snapshot.id,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (imgurl != null) "imgurl": imgurl,
      if (title != null) "title": title,
      if (userid != null) "userid": userid,
      if (tourid != null) "idtour": tourid,
      if (reservations != null) "reservations": reservations,
      if (totalprice != null) "totalprice": totalprice,
      if (tourprice != null) "tourprice": tourprice,
      if (like != null) "likes": like,
      if (comment != null) "comment": comment,
      if (idReservation != null) "idReservation": idReservation,
    };
  }
}
