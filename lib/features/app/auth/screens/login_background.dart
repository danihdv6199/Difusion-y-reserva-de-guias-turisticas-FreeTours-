import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:freetour_tfg/features/app/ui/theme/extension.dart';

class LoginBackgound extends StatelessWidget {
  const LoginBackgound({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fitHeight,
                    image: NetworkImage(
                        'https://cdn.pixabay.com/photo/2019/03/13/11/04/copenhagen-4052654_960_720.jpg'))),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
              child: Container(
                decoration: BoxDecoration(
                    color: context.colors.background.withOpacity(0.3)),
              ),
            ),
          ),
          const _HeaderIcon(),
          child,
        ],
      ),
    );
  }
}

class _HeaderIcon extends StatelessWidget {
  const _HeaderIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 30),
        child: Column(children: const [
          Icon(
            Icons.person_pin_circle_outlined,
            color: Colors.white,
            size: 100,
          ),
          Icon(
            Icons.remove_red_eye_outlined,
            color: Colors.white,
            size: 50,
          )
        ]),
      ),
    );
  }
}
