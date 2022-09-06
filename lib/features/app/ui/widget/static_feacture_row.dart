import 'package:flutter/material.dart';
import 'package:freetour_tfg/features/app/ui/theme/extension.dart';

class StaticFeacturesRows extends StatelessWidget {
  const StaticFeacturesRows({
    Key? key,
    required this.icon,
    required this.itemName,
    required this.active,
  }) : super(key: key);

  final IconData icon;
  final String itemName;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Icon(
            icon,
            color: context.colors.inverseSurface,
          ),
          const SizedBox(width: 15),
          Text(
            itemName,
            overflow: TextOverflow.ellipsis,
            style: context.bodyMedium,
          ),
          const Expanded(child: SizedBox()),
          active
              ? Icon(
                  Icons.check_box_outlined,
                  color: context.colors.primary,
                )
              : Icon(
                  Icons.check_box_outline_blank_outlined,
                  color: context.colors.inverseSurface,
                )
        ],
      ),
    );
  }
}
