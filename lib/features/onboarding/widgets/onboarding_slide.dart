import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/constants/text_styles.dart';
import 'package:viatux/core/utils/responsive.dart';
import '../pages/onboarding_page.dart';

class OnboardingSlide extends StatelessWidget {
  final OnboardingData data;
  final bool isLast;

  const OnboardingSlide({
    super.key,
    required this.data,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      child: Padding(
        padding: resp.padding(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icono circular - Tamaño responsivo
            Container(
              height: resp.hp(25),
              width: resp.hp(25),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    data.illustrationColor.withOpacity(0.15),
                    data.illustrationColor.withOpacity(0.05),
                  ],
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(
                data.icon,
                size: resp.iconSize(80),
                color: data.illustrationColor,
              ),
            ),
            resp.sizedBox(height: 20),
            // Tarjeta de contenido
            Container(
              padding: resp.padding(all: 20),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                borderRadius: resp.radius(24),
                boxShadow: isDark
                    ? null
                    : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    data.title,
                    style: AppTextStyles.getTitleLarge(context).copyWith(
                      fontSize: resp.sp(22),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  resp.sizedBox(height: 12),
                  Text(
                    data.description,
                    style: AppTextStyles.getBodyLarge(context).copyWith(
                      fontSize: resp.sp(14),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}