import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';

class ScreenshotBlockerOverlay extends StatelessWidget {
  final Widget child;

  const ScreenshotBlockerOverlay({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        // Detector de capturas de pantalla (simulado)
        // En Android real, esto se maneja con FLAG_SECURE
        // Este widget es visual para mostrar el mensaje estilo WhatsApp
      ],
    );
  }
}