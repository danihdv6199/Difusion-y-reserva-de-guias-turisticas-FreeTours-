import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freetour_tfg/features/models.dart';

class CommentServices extends ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final db = FirebaseFirestore.instance.collection("comments");

  Future getCommetsByUser(userid) async {
    final query = db.where("userid", isEqualTo: userid).withConverter(
        fromFirestore: Comment.fromFirestore,
        toFirestore: (Comment comment, _) => comment.toFirestore());

    final snap = await query.get();
    List<Comment> comments = [];
    if (snap.docs.isEmpty) {
      return comments;
    } else {
      for (var comment in snap.docs) {
        comments.add(comment.data());
        notifyListeners();
      }
      return comments;
    }
  }

  Future getCommentsbyTour(tourid) async {
    final query = db.where('tourid', isEqualTo: tourid).withConverter(
        fromFirestore: Comment.fromFirestore,
        toFirestore: (Comment comment, _) => comment.toFirestore());

    final snap = await query.get();
    List<Comment> comments = [];
    if (snap.docs.isEmpty) {
      return comments;
    } else {
      for (var comment in snap.docs) {
        comments.add(comment.data());
        notifyListeners();
      }
      return comments;
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

  Future addComment(data, String tourid, String resid) async {
    final Tour tour = await getTour(tourid);
    await firestore
        .collection('tours')
        .doc(tourid)
        .update({"comments": tour.comments! + 1});
    await db.add(data);
    firestore.collection('reservations').doc(resid).update({"comment": true});
    final comments = await getCommentsbyTour(tourid) as List<Comment>;
    double ratingTotal = 0.0;
    for (var comment in comments) {
      ratingTotal = ratingTotal + comment.rating!;
    }
    double average = ratingTotal / comments.length;
    firestore.collection('tours').doc(tourid).update({'average': average});
  }

  Future editComment() async {}

  Future deleteComment(String commentid, String tourid, String resid) async {
    final Tour tour = await getTour(tourid);
    await firestore
        .collection('tours')
        .doc(tourid)
        .update({"comments": tour.comments! - 1});
    await db.doc(commentid).delete();
    final comments = await getCommentsbyTour(tourid) as List<Comment>;
    double ratingTotal = 0.0;
    for (var comment in comments) {
      ratingTotal = ratingTotal + comment.rating!;
    }
    double average = ratingTotal / comments.length;
    if (comments.length > 1) {
      firestore.collection('tours').doc(tourid).update({'average': average});
    } else {
      firestore
          .collection('reservations')
          .doc(resid)
          .update({"comment": false});
      firestore.collection('tours').doc(tourid).update({'average': average});
    }
  }
}
