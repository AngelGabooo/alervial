import 'package:flutter/material.dart';

class Responsive {
  final BuildContext context;

  Responsive(this.context);

  // Obtener tamaño de pantalla
  Size get size => MediaQuery.of(context).size;
  double get width => size.width;
  double get height => size.height;

  // Escalado proporcional (base: iPhone 12/13/14 = 390px de ancho)
  double wp(double percentage) => width * (percentage / 100);
  double hp(double percentage) => height * (percentage / 100);

  // Escalado de fuentes responsive
  double sp(double size) {
    final scale = (width / 390).clamp(0.8, 1.2);
    return size * scale;
  }

  // Escalado de iconos
  double iconSize(double size) {
    final scale = (width / 390).clamp(0.7, 1.1);
    return size * scale;
  }

  // Altura de botones
  double buttonHeight(double baseHeight) {
    final scale = (width / 390).clamp(0.8, 1.0);
    return baseHeight * scale;
  }

  // Padding responsivo
  EdgeInsets padding({
    double? all,
    double? horizontal,
    double? vertical,
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) {
    final scale = (width / 390).clamp(0.7, 1.0);

    if (all != null) return EdgeInsets.all(all * scale);
    return EdgeInsets.only(
      top: (top ?? vertical ?? 0) * scale,
      bottom: (bottom ?? vertical ?? 0) * scale,
      left: (left ?? horizontal ?? 0) * scale,
      right: (right ?? horizontal ?? 0) * scale,
    );
  }

  // Border radius responsivo
  BorderRadius radius(double value) {
    final scale = (width / 390).clamp(0.7, 1.0);
    return BorderRadius.circular(value * scale);
  }

  // SizedBox responsivo
  SizedBox sizedBox({double? width, double? height}) {
    final scale = (this.width / 390).clamp(0.7, 1.0);
    return SizedBox(
      width: width != null ? width * scale : null,
      height: height != null ? height * scale : null,
    );
  }
}

// Extensión para usar fácilmente en cualquier widget
extension ResponsiveExtension on BuildContext {
  Responsive get resp => Responsive(this);
}