import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

List<City> cityFromJson(String str) =>
    List<City>.from(json.decode(str).map((x) => City.fromJson(x)));

String cityToJson(List<City> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class City {
  City({required this.name, required this.imgurl, required this.id});

  String? name;
  String? imgurl;
  String? id;

  factory City.fromJson(Map<String, dynamic> json) =>
      City(name: json["name"], imgurl: json["imgurl"], id: json["id"]);

  factory City.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return City(
        imgurl: data?['imgurl'], name: data?['imgurl'], id: snapshot.id);
  }

  Map<String, dynamic> toJson() => {"name": name, "imgurl": imgurl};

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (imgurl != null) "imgurl": imgurl,
      if (id != null) "id": id
    };
  }
}
