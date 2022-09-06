import 'package:flutter/material.dart';

extension TypographyUtils on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colors => theme.colorScheme;
  TextStyle? get displayLarge => textTheme.displayLarge?.copyWith();
  TextStyle? get displayMedium => textTheme.displayMedium?.copyWith();
  TextStyle? get displaySmall => textTheme.displaySmall?.copyWith();
  TextStyle? get headlineLarge => textTheme.headlineLarge?.copyWith();
  TextStyle? get headlineMedium =>
      textTheme.headlineMedium?.copyWith(color: colors.primaryContainer);
  TextStyle? get headlineSmall => textTheme.headlineSmall?.copyWith();
  TextStyle? get titleLarge => textTheme.titleLarge
      ?.copyWith(color: colors.surfaceVariant, fontSize: 20);
  TextStyle? get titleMedium =>
      textTheme.titleMedium?.copyWith(color: colors.primaryContainer);
  TextStyle? get titleSmall =>
      textTheme.titleSmall?.copyWith(color: colors.primaryContainer);
  TextStyle? get labelLarge => textTheme.labelLarge?.copyWith();
  TextStyle? get labelMedium => textTheme.labelMedium?.copyWith();
  TextStyle? get labelSmall => textTheme.labelSmall?.copyWith();
  TextStyle? get bodyLarge =>
      textTheme.bodyLarge?.copyWith(color: colors.inverseSurface, fontSize: 16);
  TextStyle? get bodyMedium =>
      textTheme.bodyMedium?.copyWith(color: colors.surfaceVariant);
  TextStyle? get bodySmall =>
      textTheme.bodySmall?.copyWith(color: colors.surface);
}
