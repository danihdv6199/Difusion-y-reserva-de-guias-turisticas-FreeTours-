import 'package:flutter/material.dart';
import 'package:freetour_tfg/features/app/ui/theme/extension.dart';

class FormFeacturesRows extends StatelessWidget {
  const FormFeacturesRows({
    Key? key,
    required this.icon,
    required this.itemName,
    required this.value,
    required this.onChanged,
  }) : super(key: key);
  final IconData icon;
  final String itemName;
  final bool value;
  final Function(bool?)? onChanged;
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
        activeColor: context.colors.tertiary,
        title: Row(
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
          ],
        ),
        value: value,
        onChanged: onChanged);
  }
}
