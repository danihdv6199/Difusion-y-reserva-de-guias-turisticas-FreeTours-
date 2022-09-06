import 'package:flutter/material.dart';
import 'package:freetour_tfg/features/app/ui/theme/extension.dart';

class GeneralContainer extends StatelessWidget {
  const GeneralContainer({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 7),
      decoration: BoxDecoration(
          color: context.colors.primaryContainer,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: context.colors.outline.withOpacity(0.3))),
      child: child,
    );
  }
}
