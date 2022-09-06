import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

List<Tour> tourFromJson(String str) =>
    List<Tour>.from(json.decode(str).map((x) => Tour.fromJson(x)));

class Tour {
  Tour(
      {this.id,
      this.usercreate,
      this.audiology,
      this.access,
      this.title,
      this.description,
      this.imgurl,
      this.location,
      this.city,
      this.date,
      this.idiom,
      this.confirmation,
      this.rest,
      this.groupr,
      this.pets,
      this.kids,
      this.car,
      this.creditCar,
      this.time,
      this.people,
      this.reservations,
      this.price,
      this.likes,
      this.comments,
      this.average,
      this.hour});

  String? id;
  String? usercreate;
  String? title;
  String? description;
  String? imgurl;
  String? idiom;
  String? city;
  String? hour;
  Timestamp? date;
  bool? audiology;
  bool? access;
  bool? car;
  bool? confirmation;
  bool? creditCar;
  bool? groupr;
  bool? kids;
  bool? pets;
  bool? rest;
  int? people;
  int? reservations;
  int? time;
  int? likes;
  int? comments;
  double? price;
  double? average;
  GeoPoint? location;

  factory Tour.fromJson(Map<String, dynamic> json) => Tour(
        id: json["id"],
        likes: json["likes"],
        comments: json["comments"],
        title: json["title"],
        description: json["description"],
        location: json["location"],
        audiology: json["audiology"],
        access: json["access"],
        imgurl: json["urlimage"],
        city: json["city"],
        date: json["date"],
        idiom: json["idiom"],
        confirmation: json["confirmation"],
        rest: json["rest"],
        groupr: json["groupr"],
        pets: json["pets"],
        kids: json["kids"],
        car: json["car"],
        creditCar: json["creditCar"],
        time: json["time"],
        people: json["people"],
        reservations: json["reservations"],
        price: json["price"],
        average: json["average"],
        hour: json["hour"],
      );

  factory Tour.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();

    return Tour(
      id: snapshot.id,
      title: data?["title"],
      usercreate: data?["usercreate"],
      description: data?["description"],
      location: data?["location"],
      audiology: data?["audiology"],
      access: data?["access"],
      imgurl: data?["urlimage"],
      city: data?["city"],
      date: data?["date"],
      idiom: data?["idiom"],
      confirmation: data?["confirmation"],
      rest: data?["rest"],
      groupr: data?["groupr"],
      pets: data?["pets"],
      kids: data?["kids"],
      car: data?["car"],
      creditCar: data?["creditCar"],
      time: data?["time"],
      people: data?["people"],
      reservations: data?["reservations"],
      price: data?["price"],
      likes: data?["likes"],
      comments: data?["comments"],
      average: data?["average"],
      hour: data?["hour"],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (title != null) "title": title,
      if (usercreate != null) "usercreate": usercreate,
      if (description != null) "description": description,
      if (location != null) "location": location,
      if (audiology != null) "audiology": audiology,
      if (access != null) "access": access,
      if (imgurl != null) "imgurl": imgurl,
      if (city != null) "city": city,
      if (date != null) "date": date,
      if (idiom != null) "idiom": idiom,
      if (confirmation != null) "confirmation": confirmation,
      if (rest != null) "rest": rest,
      if (groupr != null) "groupr": groupr,
      if (pets != null) "pets": pets,
      if (kids != null) "kids": kids,
      if (car != null) "car": car,
      if (creditCar != null) "creditCar": creditCar,
      if (time != null) "time": time,
      if (people != null) "people": people,
      if (reservations != null) "reservations": reservations,
      if (price != null) "price": price,
      if (likes != null) "likes": likes,
      if (comments != null) "comments": comments,
      if (average != null) "average": average,
      if (hour != null) "hour": hour,
    };
  }
}
