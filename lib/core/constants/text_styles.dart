import 'package:flutter/material.dart';

import 'colors.dart';

class AppTextStyles {
  // Títulos grandes
  static const TextStyle titleLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.5,
  );

  static const TextStyle titleMedium = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.3,
  );

  static const TextStyle titleSmall = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  // Cuerpo de texto
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    height: 1.4,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
  );

  // Botones
  static const TextStyle buttonLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
  );

  static const TextStyle buttonSmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  // Métodos dinámicos para tema claro/oscuro
  static TextStyle getTitleLarge(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return titleLarge.copyWith(
      color: isDark ? AppColors.darkText : AppColors.lightText,
    );
  }

  static TextStyle getBodyLarge(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return bodyLarge.copyWith(
      color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
    );
  }
}