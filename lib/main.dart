import 'package:freetour_tfg/features/app/notifications/notifications.dart';

import 'features/app/provider/app_state.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:freetour_tfg/features/app/config/share_preferences/preferences.dart';
import 'package:freetour_tfg/features/app/ui/routes/app_route.dart';
import 'package:freetour_tfg/features/providers.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Preferences.init();
  await Firebase.initializeApp();

  runApp(const AppState());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FreeTour',
      initialRoute: AppRoute.initialRoute,
      routes: AppRoute.getAppRoutes(),
      onGenerateRoute: (settings) => AppRoute.onGenerateRoute(settings),
      theme: Provider.of<ThemeProvider>(context).currentTheme,
      scaffoldMessengerKey: NotificationProvider.messegerKey,
    );
  }
}
