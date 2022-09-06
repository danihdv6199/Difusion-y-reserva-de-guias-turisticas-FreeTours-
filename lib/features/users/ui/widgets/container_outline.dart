import 'package:flutter/material.dart';

import 'package:freetour_tfg/features/app/ui/theme/extension.dart';

class ContainerOutline extends StatelessWidget {
  const ContainerOutline({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          color: context.colors.background.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1.5, color: context.colors.outline)),
    );
  }
}
