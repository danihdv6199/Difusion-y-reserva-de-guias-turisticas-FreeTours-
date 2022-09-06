import 'package:flutter/material.dart';
import 'package:freetour_tfg/features/destinations/models/city.dart';

import 'package:freetour_tfg/features/app/ui/theme/extension.dart';

class ToursAppBar extends StatelessWidget {
  const ToursAppBar({
    Key? key,
    required this.argument,
    required this.size,
  }) : super(key: key);

  final City argument;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: size.height * 0.15,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Container(
          color: context.colors.onBackground.withOpacity(0.2),
          alignment: Alignment.bottomCenter,
          child: Text(
            argument.name!,
            style: context.headlineMedium,
          ),
        ),
        background: Image.network(
          argument.imgurl!,
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}
