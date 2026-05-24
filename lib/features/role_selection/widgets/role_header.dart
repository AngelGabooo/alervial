import 'package:flutter/material.dart';
import '../../../core/constants/text_styles.dart';

class RoleHeader extends StatelessWidget {
  const RoleHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.warning_rounded,
                size: 32,
                color: Colors.white,
              ),
              const SizedBox(width: 8),
              Text(
                'ALERTAVIAL',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Text(
            '¿Cómo deseas ingresar?',
            style: AppTextStyles.getTitleLarge(context).copyWith(
              color: Colors.white,
              fontSize: 28,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            'Selecciona el tipo de acceso para continuar',
            style: AppTextStyles.getBodyLarge(context).copyWith(
              color: Colors.white.withOpacity(0.9),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}