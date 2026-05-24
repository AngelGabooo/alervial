// lib/core/theme/app_colors.dart
import 'package:flutter/material.dart';

class AppColors {
  // Light Mode Colors
  static const Color primaryDark = Color(0xFF0A2540);
  static const Color primaryBlue = Color(0xFF00B4FF);
  static const Color primaryBlueLight = Color(0xFF5DC9FF);
  static const Color accentGreen = Color(0xFF00D4A5);
  static const Color accentYellow = Color(0xFFFFD166);
  static const Color accentRed = Color(0xFFEF476F);
  static const Color background = Color(0xFFF8FAFC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color textDark = Color(0xFF1E2937);
  static const Color textLight = Color(0xFF64748B);
  static const Color textWhite = Colors.white;

  // Dark Mode Colors
  static const Color darkBackground = Color(0xFF0F172A);
  static const Color darkSurface = Color(0xFF1E2937);
  static const Color darkCard = Color(0xFF334155);
  static const Color darkText = Color(0xFFF1F5F9);
  static const Color darkTextLight = Color(0xFF94A3B8);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryBlue, Color(0xFF0096FF), Color(0xFF0066CC)],
  );

  static const LinearGradient darkGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryDark, Color(0xFF1E3A8A), Color(0xFF0F172A)],
  );

  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [accentGreen, Color(0xFF00B894)],
  );
}