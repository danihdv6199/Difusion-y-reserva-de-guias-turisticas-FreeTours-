import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:freetour_tfg/features/models.dart';

class FavoritesServices extends ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<Favorite>> getFavorites(String userid) async {
    final query = firestore
        .collection("favorites")
        .where('userid', isEqualTo: userid)
        .withConverter(
            fromFirestore: Favorite.fromFirestore,
            toFirestore: (Favorite favorite, _) => favorite.toFirestore());
    final snap = await query.get();
    List<Favorite> favorites = [];
    if (snap.docs.isEmpty) {
      notifyListeners();

      return favorites;
    } else {
      for (var favorite in snap.docs) {
        favorites.add(favorite.data());
      }
      notifyListeners();
      return favorites;
    }
  }

  Future getFavoritesByUser(String? userid, String tourid) async {
    final query = firestore
        .collection('favorites')
        .where("tourid", isEqualTo: tourid)
        .where("userid", isEqualTo: userid)
        .withConverter(
            fromFirestore: Favorite.fromFirestore,
            toFirestore: (Favorite favorite, _) => favorite.toFirestore());
    final snap = await query.get();
    List<Favorite> favorites = [];
    if (snap.docs.isEmpty) {
      notifyListeners();

      return favorites;
    } else {
      for (var favorite in snap.docs) {
        favorites.add(favorite.data());
      }
      notifyListeners();
      return favorites;
    }
  }

  Future addFavorite(
      String userid, String tourid, String imgurl, String title) async {
    final data = {
      "userid": userid,
      "tourid": tourid,
      "imgurl": imgurl,
      "title": title
    };
    firestore.collection('favorites').add(data);
    notifyListeners();
  }

  Future deleteFavorites(String idfav) async {
    firestore.collection("favorites").doc(idfav).delete();
    notifyListeners();
  }

  Future deleteAll(userid) async {
    final favorites = await getFavorites(userid);
    for (var favorite in favorites) {
      firestore.collection("favorites").doc(favorite.id).delete();
    }
    notifyListeners();
  }
}
