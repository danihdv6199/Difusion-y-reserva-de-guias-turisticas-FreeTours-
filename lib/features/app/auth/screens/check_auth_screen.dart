import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:freetour_tfg/features/providers.dart';
import 'package:freetour_tfg/features/screens.dart';

class CheckAuthScreen extends StatelessWidget {
  const CheckAuthScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.userChanges(),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              return FutureBuilder(
                  future: Provider.of<UsersRols>(context).getUser(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      final user = snapshot.data;
                      return HomeScreen(rol: user);
                    } else {
                      return const Center(child: Icon(Icons.visibility));
                    }
                  });
            } else {
              return const LoginScreen();
            }
          })),
    );
  }
}
