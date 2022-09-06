import 'package:flutter/material.dart';

class TextChip extends StatelessWidget {
  const TextChip(
      {Key? key, required this.color, required this.style, required this.text})
      : super(key: key);

  final Color color;
  final TextStyle? style;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Chip(
        elevation: 0,
        backgroundColor: color,
        labelPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        label: Text(
          text,
          style: style,
        ));
  }
}
