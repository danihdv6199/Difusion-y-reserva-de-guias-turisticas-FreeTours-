import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:freetour_tfg/features/providers.dart';
import 'package:freetour_tfg/features/screens.dart';
import 'package:freetour_tfg/features/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key, this.rol}) : super(key: key);
  final String? rol;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _HomeScreenBody(rol: rol ?? ''),
        bottomNavigationBar: const CustomBottomNavigationBar());
  }
}

class _HomeScreenBody extends StatefulWidget {
  const _HomeScreenBody({Key? key, required this.rol}) : super(key: key);

  final String rol;
  @override
  State<_HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<_HomeScreenBody> {
  @override
  Widget build(BuildContext context) {
    final rol = widget.rol;
    final MenuProvider uiProvider = Provider.of<MenuProvider>(context);
    final currentIndex = uiProvider.selectedMenuOpt;
    final userRol = Provider.of<UsersRols>(context);

    return FutureBuilder(
      future: userRol.getUser(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (rol == "Viajero") {
            switch (currentIndex) {
              case 0:
                return const CitiesScreen();
              case 1:
                return const CarScreen();
              case 2:
                return const ReservationsScreen();
              case 3:
                return const FavoritesScreen();
              case 4:
                return const TouristProfileScreen();
              default:
                return const CitiesScreen();
            }
          } else {
            switch (currentIndex) {
              case 0:
                return const CitiesScreen();
              case 1:
                return const CarScreen();
              case 2:
                return const ReservationsScreen();
              case 3:
                return const FavoritesScreen();
              case 4:
                return const GuideProfilelScreen();
              default:
                return const CitiesScreen();
            }
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
