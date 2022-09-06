import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:freetour_tfg/features/app/ui/theme/extension.dart';
import 'package:freetour_tfg/features/destinations/ui/widgets/buttons_section.dart';
import 'package:freetour_tfg/features/destinations/ui/widgets/info_section.dart';
import 'package:freetour_tfg/features/destinations/ui/widgets/review_section.dart';
import 'package:freetour_tfg/features/models.dart';
import 'package:freetour_tfg/features/providers.dart';
import 'package:freetour_tfg/features/services.dart';

class TourDetails extends StatelessWidget {
  const TourDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Tour;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          TourDetailsAppBar(tour: arg),
          SliverList(
              delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: InfoSection(tour: arg),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ButtonsSection(tour: arg),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ReviewSection(tour: arg),
            )
          ]))
        ],
      ),
    );
  }
}

class TourDetailsAppBar extends StatelessWidget {
  const TourDetailsAppBar({
    Key? key,
    required this.tour,
  }) : super(key: key);
  final Tour tour;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: Stack(
        children: [
          FlexibleSpaceBar(
            centerTitle: true,
            title: Container(
              alignment: Alignment.bottomCenter,
              color: context.colors.onBackground.withOpacity(0.3),
              width: double.infinity,
              child: Text(
                tour.title!,
                style: context.titleMedium,
              ),
            ),
            background: FadeInImage(
              placeholder: const AssetImage('assets/loading.gif'),
              image: NetworkImage(tour.imgurl!),
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: context.colors.primaryContainer,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: FavoriteButton(tour: tour)),
          )
        ],
      ),
    );
  }
}

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({
    Key? key,
    required this.tour,
  }) : super(key: key);

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
  final Tour tour;
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool _like = false;

  @override
  Widget build(BuildContext context) {
    final favservice = Provider.of<FavoritesServices>(context, listen: false);
    final userservice = Provider.of<UsersRols>(context, listen: false);
    final user = userservice.loggedInUser.userk;
    return FutureBuilder(
        future: favservice.getFavoritesByUser(user!, widget.tour.id!),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Container();
          } else {
            final favs = snapshot.data as List<Favorite>;
            String? favorito;

            if (favs.isEmpty) {
              _like = false;
            } else {
              favorito = favs.first.id;
              _like = true;
            }
            return GestureDetector(
                child: Icon(
                  _like ? Icons.favorite : Icons.favorite_border,
                  color: Colors.red,
                  size: 25,
                ),
                onTap: _like
                    ? () {
                        removeFavorites(
                            widget.tour, user, favservice, favorito!);
                        setState(() {
                          _like = false;
                        });
                      }
                    : () {
                        addFavorites(widget.tour, user, favservice);
                        setState(() {
                          _like = true;
                        });
                      });
          }
        });
  }

  addFavorites(
      Tour tour, String user, FavoritesServices favoritesServices) async {
    await favoritesServices.addFavorite(
        user, tour.id!, tour.imgurl!, tour.title!);
  }

  removeFavorites(Tour tour, String user, FavoritesServices favoritesServices,
      String idfav) async {
    await favoritesServices.deleteFavorites(idfav);
  }
}
