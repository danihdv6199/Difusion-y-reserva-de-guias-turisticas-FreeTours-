import 'package:flutter/material.dart';

import 'package:freetour_tfg/features/app/ui/theme/extension.dart';

class CardContainer extends StatelessWidget {
  final Widget child;

  const CardContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        decoration: _createCardShape(
            context, context.colors.background.withOpacity(0.8)),
        child: child,
      ),
    );
  }

  BoxDecoration _createCardShape(BuildContext context, Color color) {
    return BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 15, offset: Offset(0, 5))
        ]);
  }
}
