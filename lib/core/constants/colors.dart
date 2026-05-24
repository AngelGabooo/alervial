import 'package:flutter/material.dart';

class AppColors {
  // Modo claro
  static const Color lightPrimary = Color(0xFF1A73E8);
  static const Color lightBackground = Color(0xFFF5F7FA);
  static const Color lightSurface = Colors.white;
  static const Color lightText = Color(0xFF202124);
  static const Color lightTextSecondary = Color(0xFF5F6368);

  // Modo oscuro
  static const Color darkPrimary = Color(0xFF8AB4F8);
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkText = Color(0xFFE8EAED);
  static const Color darkTextSecondary = Color(0xFF9AA0A6);

  // Colores fijos (no cambian con el tema)
  static const Color blueDark = Color(0xFF0A2540);
  static const Color blueBright = Color(0xFF2196F3);
  static const Color blueGlow = Color(0xFF64B5F6);
  static const Color softGreen = Color(0xFF4CAF50);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  // Gradientes
  static const LinearGradient splashGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [blueDark, blueBright],
  );

  static const LinearGradient buttonGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [blueBright, Color(0xFF1565C0)],
  );
}