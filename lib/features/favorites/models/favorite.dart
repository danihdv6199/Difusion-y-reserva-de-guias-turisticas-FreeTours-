import 'package:cloud_firestore/cloud_firestore.dart';

class Favorite {
  Favorite({this.imgurl, this.userid, this.tourid, this.title, this.id});

  String? imgurl;
  String? title;
  String? userid;
  String? tourid;
  String? id;

  factory Favorite.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return Favorite(
      imgurl: data?['imgurl'],
      title: data?['title'],
      userid: data?['userid'],
      tourid: data?['tourid'],
      id: snapshot.id,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (imgurl != null) "imgurl": imgurl,
      if (title != null) "title": title,
      if (userid != null) "userid": userid,
      if (tourid != null) "idtour": tourid,
      if (id != null) "id": id,
    };
  }
}
