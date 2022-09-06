import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:freetour_tfg/features/app/config/share_preferences/preferences.dart';
import 'package:freetour_tfg/features/app/ui/theme/extension.dart';
import 'package:freetour_tfg/features/providers.dart';
import 'package:freetour_tfg/features/services.dart';
import 'package:freetour_tfg/features/widgets.dart';

class TouristProfileScreen extends StatefulWidget {
  const TouristProfileScreen({Key? key}) : super(key: key);

  @override
  State<TouristProfileScreen> createState() => _TouristProfileScreenState();
}

class _TouristProfileScreenState extends State<TouristProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Mi Perfil'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              ContainerOutline(
                child: ListTile(
                  title: Text('Mis datos', style: context.bodyMedium),
                  trailing: const Icon(Icons.account_circle),
                  onTap: () => Navigator.pushNamed(context, 'manageProfile'),
                ),
              ),
              ContainerOutline(
                child: SwitchListTile(
                    value: Preferences.isDarkMode,
                    title: Text(
                      "Modo oscuro",
                      style: context.bodyMedium,
                    ),
                    onChanged: (value) {
                      Preferences.isDarkMode = value;
                      final themeProvider =
                          Provider.of<ThemeProvider>(context, listen: false);
                      value
                          ? themeProvider.setDarkMode()
                          : themeProvider.setLightMode();
                      setState(() {});
                    }),
              ),
              ContainerOutline(
                child: ListTile(
                  title: Text('Acerca de FreeTour', style: context.bodyMedium),
                  trailing: const Icon(Icons.navigate_next),
                  onTap: () {
                    showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return SizedBox(
                              height: 200,
                              child: Column(
                                children: [
                                  const AboutListTile(
                                    applicationLegalese:
                                        "Creada por Daniel Hernández de Vega",
                                    applicationVersion: "1.0",
                                  ),
                                  ElevatedButton.icon(
                                      onPressed: () => Navigator.pop(context),
                                      icon: const Icon(Icons.close),
                                      label: const Text('Close'))
                                ],
                              ));
                        });
                  },
                ),
              ),
              const Expanded(child: SizedBox()),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'mycomments');
                  },
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Mis comentarios', style: context.titleSmall)
                      ])),
              const SizedBox(height: 15),
              ElevatedButton(
                  onPressed: () {
                    final authModel =
                        Provider.of<AuthService>(context, listen: false);
                    authModel.logout();
                    Navigator.pushReplacementNamed(context, 'login');
                  },
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Cerrar Sesión', style: context.titleSmall)
                      ])),
            ],
          ),
        ));
  }
}
