import 'package:flutter/material.dart';

import 'package:freetour_tfg/features/menu/models/menu_option.dart';
import 'package:freetour_tfg/features/screens.dart';

class AppRoute {
  static const initialRoute = 'checking';

  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {};
    for (final option in menuOption) {
      appRoutes.addAll({option.route: (BuildContext context) => option.screen});
    }
    return appRoutes;
  }

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const CheckAuthScreen(),
    );
  }

  static final menuOption = <MenuOption>[
    ///App settings
    MenuOption(route: 'checking', screen: const CheckAuthScreen()),
    MenuOption(route: 'home', screen: const HomeScreen()),

    ///App Authentication
    MenuOption(route: 'register', screen: const RegisterScreen()),
    MenuOption(route: 'login', screen: const LoginScreen()),
    MenuOption(route: 'manageProfile', screen: const ManageProfileScreen()),
    MenuOption(route: 'deleteUser', screen: const DeleteUserScreen()),

    ///Module Cities and tours
    MenuOption(route: 'cities', screen: const CitiesScreen()),
    MenuOption(route: 'selectedCity', screen: const ToursByCity()),
    MenuOption(route: 'detailsGuide', screen: const TourDetails()),
    MenuOption(route: 'newGuide', screen: const NewTourScreen()),
    MenuOption(route: 'guide', screen: const GuidesScreen()),
    MenuOption(route: 'editguide', screen: const EditTourScreen()),

    ///Module ShoppingCar
    MenuOption(route: 'CartList', screen: const CarScreen()),

    ///Module Reservations
    MenuOption(route: 'reservation', screen: const ReservationsScreen()),

    /// Module Favorites
    MenuOption(route: 'fav', screen: const FavoritesScreen()),

    /// Module Comments
    MenuOption(route: 'mycomments', screen: const MyCommentsScreen()),
    MenuOption(route: 'addcomment', screen: const AddCommentScreen()),
  ];
}
