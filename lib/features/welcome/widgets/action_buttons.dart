import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import '../../../core/utils/responsive.dart';

class ActionButtons extends StatelessWidget {
  final VoidCallback onLogin;
  final VoidCallback onRegister;
  final VoidCallback onVisitor;

  const ActionButtons({
    super.key,
    required this.onLogin,
    required this.onRegister,
    required this.onVisitor,
  });

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final buttonHeight = resp.buttonHeight(48);
    final buttonFontSize = resp.sp(15);

    return Padding(
      padding: resp.padding(horizontal: 20),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: onLogin,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.blueBright,
              foregroundColor: Colors.white,
              minimumSize: Size(double.infinity, buttonHeight),
              shape: RoundedRectangleBorder(
                borderRadius: resp.radius(28),
              ),
              elevation: 0,
            ),
            child: Text(
              'Iniciar sesión',
              style: TextStyle(fontSize: buttonFontSize, fontWeight: FontWeight.w600),
            ),
          ),
          resp.sizedBox(height: 10),
          OutlinedButton(
            onPressed: onRegister,
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.blueBright,
              minimumSize: Size(double.infinity, buttonHeight),
              shape: RoundedRectangleBorder(
                borderRadius: resp.radius(28),
              ),
              side: BorderSide(color: AppColors.blueBright),
            ),
            child: Text(
              'Registrarse',
              style: TextStyle(fontSize: buttonFontSize, fontWeight: FontWeight.w600),
            ),
          ),
          resp.sizedBox(height: 10),
          TextButton(
            onPressed: onVisitor,
            style: TextButton.styleFrom(
              foregroundColor: isDark ? Colors.grey[400] : Colors.grey[600],
            ),
            child: Text(
              'Entrar como visitante',
              style: TextStyle(fontSize: resp.sp(14)),
            ),
          ),
        ],
      ),
    );
  }
}