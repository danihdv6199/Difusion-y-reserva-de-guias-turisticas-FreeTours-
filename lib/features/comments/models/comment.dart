import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  Comment(
      {this.commentid,
      this.title,
      this.comment,
      this.userid,
      this.tourid,
      this.tourimg,
      this.tourTitle,
      this.reservationid,
      this.rating});

  String? commentid;
  String? title;
  String? comment;
  String? userid;
  String? tourid;
  String? tourimg;
  String? tourTitle;
  String? reservationid;
  double? rating;

  factory Comment.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();

    return Comment(
      commentid: snapshot.id,
      comment: data?['comment'],
      title: data?['title'],
      userid: data?['userid'],
      tourid: data?['tourid'],
      tourimg: data?['tourimg'],
      tourTitle: data?['tourTitle'],
      reservationid: data?['reservationid'],
      rating: data?['rating'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (commentid != null) "commentid": commentid,
      if (comment != null) "comment": comment,
      if (title != null) "title": title,
      if (userid != null) "userid": userid,
      if (tourid != null) "tourid": tourid,
      if (tourimg != null) "tourimg": tourimg,
      if (tourTitle != null) "tourTitle": tourTitle,
      if (reservationid != null) "reservationid": reservationid,
      if (rating != null) "rating": rating,
    };
  }
}
