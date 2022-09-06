import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freetour_tfg/features/models.dart';

class AuthService extends ChangeNotifier {
  final _instance = FirebaseAuth.instance;

  Future<String?> createUser(
      String email, String password, String rol, String name) async {
    try {
      await _instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore(email, rol, name)});
    } on FirebaseException catch (e) {
      return "Error: $e";
    }
    return null;
  }

  ///Insertar datos del usuario

  postDetailsToFirestore(String email, String rool, String name) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    User? user = _instance.currentUser;
    UserModel userModel = UserModel();
    userModel.email = email;
    userModel.userk = user!.uid;
    userModel.rol = rool;
    userModel.name = name;

//añadir cartiems map
    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap())
        .catchError((e) {
      Exception("error");
    });
    return null;
  }

  Future editProfile(String email, String rool, String name, userid) async {
    FirebaseFirestore instance = FirebaseFirestore.instance;
    instance
        .collection('users')
        .doc(userid)
        .update({"email": email, "wrool": rool, "name": name});
    User? user = _instance.currentUser;
    user!.updateEmail(email);
    notifyListeners();
  }

  Future<String?> login(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        //loginForm.isLoading = false;

        return ('Usuario no encontrado');
      } else if (e.code == 'wrong-password') {
        //loginForm.isLoading = false;
        return ('Contraseña incorrecta');
      }
      return ('Error en el login');
    }
  }

  Future passwordReset(String email) async {
    //print('aunt: $email');
    try {
      await _instance.sendPasswordResetEmail(email: email);

      return 'Se envió su contraseña por correo';
    } on FirebaseAuthException catch (e) {
      //print('Erro: ${e.code}');
      if (e.code == 'user-not-found') {
        return 'Valide su email';
      }
    }
  }

  Future logout() async {
    await _instance.signOut();
  }

  Future deleteAcount(email, password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      final user = _instance.currentUser;
      await user!.delete();
      await firestore.collection('users').doc(user.uid).delete();
      return 'success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return ('Usuario no encontrado');
      } else if (e.code == 'wrong-password') {
        return ('Contraseña incorrecta');
      }
      return ('Error en el login');
    }
  }
}
