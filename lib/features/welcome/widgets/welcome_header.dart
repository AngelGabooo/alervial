import 'package:flutter/material.dart';
import '../../../core/constants/text_styles.dart';
import '../../../core/utils/responsive.dart';

class WelcomeHeader extends StatelessWidget {
  const WelcomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: resp.padding(all: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.warning_rounded,
                size: resp.iconSize(36),
                color: isDark ? Colors.white : const Color(0xFF0A2540),
              ),
              resp.sizedBox(width: 10),
              Text(
                'ALERTAVIAL\nCHIAPAS',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: resp.sp(20),
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : const Color(0xFF0A2540),
                  height: 1.1,
                ),
              ),
            ],
          ),
          resp.sizedBox(height: 24),
          Text(
            'Conecta tu ciudad con reportes inteligentes',
            style: AppTextStyles.getTitleLarge(context).copyWith(
              fontSize: resp.sp(24),
              color: isDark ? Colors.white : const Color(0xFF0A2540),
            ),
            textAlign: TextAlign.center,
          ),
          resp.sizedBox(height: 10),
          Text(
            'Reporta incidencias viales en tiempo real y ayuda a mejorar la seguridad vial de Chiapas.',
            style: AppTextStyles.getBodyLarge(context).copyWith(
              fontSize: resp.sp(14),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}