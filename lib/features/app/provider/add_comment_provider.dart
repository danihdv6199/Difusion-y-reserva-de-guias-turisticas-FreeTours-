import 'package:flutter/material.dart';

class AddCommentsProvider extends ChangeNotifier {
  GlobalKey<FormState> addcomment = GlobalKey<FormState>();

  double rating = 0.0;
  String title = '';
  String comment = '';
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  isvalidRating(value) {
    if (value > 0.0) {
      return null;
    } else {
      return 'Debe seleccionar una calificación para la guia';
    }
  }

  isvalidTitle(value) {
    if (value != null && value != '') {
      return null;
    } else {
      return 'Ingrese un titulo';
    }
  }

  isvalidComment(value) {
    if (value != null && value != '') {
      return null;
    } else {
      return 'Ingrese un comentario';
    }
  }

  bool isValid() {
    return addcomment.currentState?.validate() ?? false;
  }
}
