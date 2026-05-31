import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';

class FakeLocationDialog extends StatelessWidget {
  final VoidCallback onClose;

  const FakeLocationDialog({super.key, required this.onClose});

  static void show(BuildContext context, {VoidCallback? onClose}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => FakeLocationDialog(
        onClose: () {
          if (onClose != null) onClose();
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
      child: Padding(
        padding: EdgeInsets.all(resp.wp(6)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icono de advertencia
            Container(
              padding: EdgeInsets.all(resp.wp(4)),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.gps_off_rounded,
                size: resp.iconSize(48),
                color: Colors.red,
              ),
            ),
            SizedBox(height: resp.hp(2)),
            Text(
              'Ubicación falsa detectada',
              style: TextStyle(
                fontSize: resp.sp(20),
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: resp.hp(1)),
            Text(
              'Hemos detectado que estás usando una aplicación de ubicación falsa.\n\nPor favor, desactívala para poder usar todas las funciones de la aplicación.',
              style: TextStyle(
                fontSize: resp.sp(14),
                color: isDark ? Colors.grey[400] : Colors.grey[600],
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: resp.hp(3)),
            SizedBox(
              width: double.infinity,
              height: resp.buttonHeight(48),
              child: ElevatedButton(
                onPressed: onClose,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.blueBright,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Entendido',
                  style: TextStyle(fontSize: resp.sp(16), fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}