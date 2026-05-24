// lib/features/onboarding/presentation/screens/onboarding_screen.dart (CORREGIDO)
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/onboarding_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> onboardingData = [
    {
      "title": "Reporta problemas viales fácilmente",
      "description": "Captura baches, derrumbes e inundaciones en segundos usando tu celular.",
      "icon": Icons.camera_alt,
    },
    {
      "title": "Ubicación en tiempo real",
      "description": "La app detecta automáticamente la ubicación exacta del problema mediante GPS.",
      "icon": Icons.gps_fixed,
    },
    {
      "title": "Da seguimiento a tus reportes",
      "description": "Recibe notificaciones y consulta el estado de cada incidencia reportada.",
      "icon": Icons.timeline,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [AppColors.darkBackground, AppColors.darkSurface]
                : [AppColors.background, Colors.white],
          ),
        ),
        child: Column(
          children: [
            // Skip button
            Padding(
              padding: const EdgeInsets.only(top: 60, right: 24),
              child: Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/welcome');
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: isDark ? AppColors.darkTextLight : AppColors.textLight,
                  ),
                  child: const Text(
                    "Omitir",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
            // PageView
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (value) {
                  setState(() {
                    _currentPage = value;
                  });
                },
                itemCount: onboardingData.length,
                itemBuilder: (context, index) => OnboardingPage(
                  title: onboardingData[index]['title'],
                  description: onboardingData[index]['description'],
                  icon: onboardingData[index]['icon'],
                  currentPage: _currentPage,
                  totalPages: onboardingData.length,
                  isLast: index == onboardingData.length - 1,
                  onNext: () {
                    if (index < onboardingData.length - 1) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      Navigator.pushReplacementNamed(context, '/welcome');
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}