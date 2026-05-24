// lib/features/onboarding/presentation/widgets/onboarding_page.dart (CORREGIDO)
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final int currentPage;
  final int totalPages;
  final bool isLast;
  final VoidCallback onNext;

  const OnboardingPage({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.currentPage,
    required this.totalPages,
    required this.isLast,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Ilustración grande
          TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: 1),
            duration: const Duration(milliseconds: 600),
            builder: (context, double value, child) {
              return Transform.scale(
                scale: value,
                child: Opacity(
                  opacity: value,
                  child: child,
                ),
              );
            },
            child: Container(
              height: 280,
              width: 280,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.primaryBlue.withOpacity(0.1),
                    AppColors.primaryBlue.withOpacity(0.05),
                  ],
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 140,
                color: AppColors.primaryBlue,
              ),
            ),
          ),
          const SizedBox(height: 50),
          // Título
          Text(
            title,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: isDark ? AppColors.darkText : AppColors.textDark,
              height: 1.3,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          // Descripción
          Text(
            description,
            style: TextStyle(
              fontSize: 16,
              height: 1.5,
              color: isDark ? AppColors.darkTextLight : AppColors.textLight,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 60),
          // Indicador de páginas
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              totalPages,
                  (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 6),
                width: currentPage == index ? 32 : 8,
                height: 8,
                decoration: BoxDecoration(
                  gradient: currentPage == index ? AppColors.primaryGradient : null,
                  color: currentPage == index
                      ? null
                      : isDark
                      ? AppColors.darkCard
                      : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          // Botón principal
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: onNext,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              child: Text(
                isLast ? "Comenzar" : "Siguiente",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          if (!isLast)
            const SizedBox(height: 8),
          if (!isLast)
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/welcome');
              },
              child: Text(
                "Omitir",
                style: TextStyle(
                  color: isDark ? AppColors.darkTextLight : Colors.grey[600],
                  fontSize: 15,
                ),
              ),
            ),
        ],
      ),
    );
  }
}