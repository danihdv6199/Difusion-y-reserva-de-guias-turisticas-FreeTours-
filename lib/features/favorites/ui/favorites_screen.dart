import 'package:flutter/material.dart';
import 'package:freetour_tfg/features/app/ui/theme/extension.dart';
import 'package:freetour_tfg/features/models.dart';
import 'package:freetour_tfg/features/providers.dart';
import 'package:freetour_tfg/features/services.dart';
import 'package:freetour_tfg/features/widgets.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: const Icon(Icons.visibility_outlined)),
      body: const ListFavorites(),
    );
  }
}

class ListFavorites extends StatefulWidget {
  const ListFavorites({
    Key? key,
  }) : super(key: key);

  @override
  State<ListFavorites> createState() => _ListFavoritesState();
}

class _ListFavoritesState extends State<ListFavorites> {
  @override
  Widget build(BuildContext context) {
    final user =
        Provider.of<UsersRols>(context, listen: false).loggedInUser.userk;
    final service = Provider.of<FavoritesServices>(context);
    return FutureBuilder(
      future: service.getFavorites(user!),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        } else {
          final favorites = snapshot.data as List<Favorite>;

          if (favorites.isEmpty) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.upcoming,
                  size: 40,
                  color: context.colors.surfaceVariant,
                ),
                const SizedBox(height: 20),
                Text('Aún no agregas a favoritos.', style: context.bodyMedium),
              ],
            ));
          } else {
            return Stack(
              children: [
                ListView.builder(
                  padding: const EdgeInsets.only(top: 50, left: 15, right: 15),
                  itemCount: favorites.length,
                  itemBuilder: (BuildContext context, int index) {
                    final fav = favorites[index];
                    return Dismissible(
                        background: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.red)),
                        ),
                        key: Key(fav.id!),
                        child: GeneralContainer(
                            child: ListTile(
                                title: Text(
                                  fav.title!,
                                  style: context.bodyLarge,
                                ),
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.network(
                                    fav.imgurl!,
                                    width: 55,
                                    height: 55,
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                                trailing: const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                ))),
                        direction: DismissDirection.endToStart,
                        onDismissed: (DismissDirection direction) {
                          setState(() {
                            showDialog(
                                context: context,
                                builder: (_) {
                                  return FavoriteAlert(
                                      fav: fav, service: service, userid: user);
                                });
                            favorites.removeAt(index).id;
                          });
                        });
                  },
                ),
                Container(
                  color: context.colors.background,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                      Text('Mis Favoritos', style: context.titleLarge),
                      IconButton(
                          tooltip: 'Borrar todos',
                          onPressed: () {
                            setState(() {
                              showDialog(
                                  context: context,
                                  builder: (context) => ConfimationAlert(
                                      favorites: favorites,
                                      service: service,
                                      userid: user));
                            });
                          },
                          icon:
                              Icon(Icons.delete, color: context.colors.surface))
                    ],
                  ),
                ),
              ],
            );
          }
        }
      },
    );
  }
}

class ConfimationAlert extends StatelessWidget {
  const ConfimationAlert(
      {Key? key,
      required this.favorites,
      required this.service,
      required this.userid})
      : super(key: key);

  final List<Favorite> favorites;
  final FavoritesServices service;
  final String userid;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Borrar todos los favoritos',
        style: context.bodyMedium,
      ),
      content: Text(
          'Si presiona "Borrar Todo" se borran todas las guias que están en favoritos de forma permanente',
          style: context.bodyMedium),
      actions: [
        ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel')),
        ElevatedButton(
            onPressed: () {
              service.deleteAll(userid);
              Navigator.pop(context);
            },
            child: const Text(
              'Borrar Todo',
            ))
      ],
    );
  }
}

class FavoriteAlert extends StatelessWidget {
  const FavoriteAlert(
      {Key? key,
      required this.service,
      required this.userid,
      required this.fav})
      : super(key: key);

  final Favorite fav;
  final FavoritesServices service;
  final String userid;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Borrar Favorito',
        style: context.bodyMedium,
      ),
      content: Text(
          'Si presiona "Borrar" se borran la guia de favoritos de forma permanente',
          style: context.bodyMedium),
      actions: [
        ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel')),
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              service.deleteFavorites(fav.id!);
            },
            child: const Text(
              'Borrar',
            ))
      ],
    );
  }
}
