import 'package:flutter/material.dart';
import 'package:freetour_tfg/features/app/ui/theme/extension.dart';

class NotificationSnackBar extends StatelessWidget {
  const NotificationSnackBar({
    Key? key,
    required this.message,
    required this.icon,
    required this.color,
  }) : super(key: key);

  final String message;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Icon(icon, color: Colors.white),
        ),
        const SizedBox(width: 10),
        Flexible(
          flex: 2,
          child: Text(
            message,
            style: context.titleSmall,
            overflow: TextOverflow.fade,
          ),
        ),
      ],
    );
  }
}
