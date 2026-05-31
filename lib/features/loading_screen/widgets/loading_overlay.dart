import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';
import 'loading_message.dart';

class LoadingOverlay extends StatelessWidget {
  final String message;
  final bool dismissible;

  const LoadingOverlay({
    super.key,
    required this.message,
    this.dismissible = false,
  });

  static OverlayEntry? _currentOverlay;

  static void show(BuildContext context, {required String message}) {
    hide();
    _currentOverlay = OverlayEntry(
      builder: (context) => LoadingOverlay(message: message),
    );
    Overlay.of(context).insert(_currentOverlay!);
  }

  static void hide() {
    _currentOverlay?.remove();
    _currentOverlay = null;
  }

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;

    return Material(
      color: Colors.black.withOpacity(0.7),
      child: Center(
        child: Container(
          padding: EdgeInsets.all(resp.wp(8)),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: resp.wp(12),
                height: resp.wp(12),
                child: const CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.blueBright),
                ),
              ),
              const SizedBox(height: 24),
              LoadingMessage(message: message, isDark: false),
            ],
          ),
        ),
      ),
    );
  }
}