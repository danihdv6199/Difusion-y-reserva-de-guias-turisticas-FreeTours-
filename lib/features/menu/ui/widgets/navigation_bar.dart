import 'package:flutter/material.dart';
import 'package:freetour_tfg/features/app/config/share_preferences/preferences.dart';

import 'package:freetour_tfg/features/providers.dart';

import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:freetour_tfg/features/app/ui/theme/extension.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<MenuProvider>(context);
    final userRol = Provider.of<UsersRols>(context);
    final currentIndex = uiProvider.selectedMenuOpt;

    final theme = Provider.of<ThemeProvider>(context);
    Color selectedItemColor;
    theme.isLightMode
        ? selectedItemColor = context.colors.primary
        : selectedItemColor = context.colors.primary;
    setState(() {
      Preferences.isDarkMode
          ? selectedItemColor = context.colors.primary
          : selectedItemColor = context.colors.primary;
    });

    if (userRol.rol == 'Viajero') {
      return SalomonBottomBar(
        unselectedItemColor: context.colors.outline,
        selectedColorOpacity: 0.1,
        selectedItemColor: selectedItemColor,
        currentIndex: currentIndex,
        items: [
          SalomonBottomBarItem(
              icon: const Icon(Icons.travel_explore),
              title: const Text('Ciudades')),
          SalomonBottomBarItem(
              icon: const Icon(Icons.shopping_cart_outlined),
              title: const Text('Carrito')),
          SalomonBottomBarItem(
              icon: const Icon(Icons.local_activity_outlined),
              title: const Text('Reservas')),
          SalomonBottomBarItem(
            icon: const Icon(Icons.favorite_border),
            title: const Text('Favoritos'),
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.person_pin),
            title: const Text('Perfil'),
          ),
        ],
        onTap: (pagina) {
          uiProvider.selectedMenuOpt = pagina;
        },
      );
    } else {
      return SalomonBottomBar(
        unselectedItemColor: context.colors.outline,
        selectedColorOpacity: 0.1,
        selectedItemColor: selectedItemColor,
        currentIndex: currentIndex,
        items: [
          SalomonBottomBarItem(
              icon: const Icon(Icons.travel_explore),
              title: const Text('Ciudades')),
          SalomonBottomBarItem(
              icon: const Icon(Icons.shopping_cart),
              title: const Text('Carrito')),
          SalomonBottomBarItem(
              icon: const Icon(Icons.local_activity_outlined),
              title: const Text('Reservas')),
          SalomonBottomBarItem(
              icon: const Icon(Icons.favorite), title: const Text('Favoritos')),
          SalomonBottomBarItem(
            icon: const Icon(Icons.hiking),
            title: const Text('Perfil'),
          ),
        ],
        onTap: (pagina) {
          uiProvider.selectedMenuOpt = pagina;
        },
      );
    }
  }
}
