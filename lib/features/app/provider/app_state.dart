import 'package:flutter/material.dart';
import 'package:freetour_tfg/features/app/config/share_preferences/preferences.dart';

import 'package:freetour_tfg/features/providers.dart';
import 'package:freetour_tfg/features/services.dart';
import 'package:freetour_tfg/main.dart';

import 'package:provider/provider.dart';

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => LoginFormProvider()),
        ChangeNotifierProvider(create: (_) => AddCommentsProvider()),
        ChangeNotifierProvider(create: (_) => RegisterFormProvider()),
        ChangeNotifierProvider(create: (_) => MenuProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        //Services
        ChangeNotifierProvider(create: (_) => CitiesService()),
        ChangeNotifierProvider(create: (_) => ToursServices()),
        ChangeNotifierProvider(create: (_) => NewTourProvider()),
        ChangeNotifierProvider(create: (_) => UsersRols()),
        ChangeNotifierProvider(create: (_) => FavoritesServices()),
        ChangeNotifierProvider(create: (_) => CarService()),
        ChangeNotifierProvider(create: (_) => ReservationsService()),
        ChangeNotifierProvider(create: (_) => CommentServices()),

        ChangeNotifierProvider(
            create: (_) => ThemeProvider(isDarkMode: Preferences.isDarkMode)),
      ],
      child: const MyApp(),
    );
  }
}
