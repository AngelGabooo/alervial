import 'package:flutter/material.dart';
import 'package:viatux/core/utils/responsive.dart';
import 'package:viatux/routes/app_routes.dart';
import '../widgets/onboarding_slide.dart';
import 'package:viatux/core/constants/colors.dart';
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingData> _slides = [
    OnboardingData(
      title: 'Reporta problemas viales fácilmente',
      description: 'Captura baches, derrumbes e inundaciones en segundos usando tu celular.',
      icon: Icons.camera_alt_rounded,
      illustrationColor: Colors.blue,
    ),
    OnboardingData(
      title: 'Ubicación en tiempo real',
      description: 'La app detecta automáticamente la ubicación exacta del problema mediante GPS.',
      icon: Icons.gps_fixed_rounded,
      illustrationColor: Colors.green,
    ),
    OnboardingData(
      title: 'Da seguimiento a tus reportes',
      description: 'Recibe notificaciones y consulta el estado de cada incidencia reportada.',
      icon: Icons.notifications_active_rounded,
      illustrationColor: Colors.orange,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFF5F7FA),
      body: SafeArea(
        child: Column(
          children: [
            // PageView con altura responsiva
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _slides.length,
                itemBuilder: (context, index) {
                  return OnboardingSlide(
                    data: _slides[index],
                    isLast: index == _slides.length - 1,
                  );
                },
              ),
            ),
            // Navegación responsiva
            Padding(
              padding: resp.padding(horizontal: 20, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Botón Omitir
                  TextButton(
                    onPressed: () {
                      _pageController.jumpToPage(_slides.length - 1);
                    },
                    child: Text(
                      'Omitir',
                      style: TextStyle(
                        fontSize: resp.sp(14),
                        color: isDark ? Colors.grey[400] : Colors.grey[600],
                      ),
                    ),
                  ),
                  // Indicador de páginas
                  Row(
                    children: List.generate(_slides.length, (index) {
                      return Container(
                        margin: resp.padding(horizontal: 4),
                        width: _currentPage == index ? resp.wp(6) : resp.wp(2.5),
                        height: resp.hp(0.8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(resp.sp(4)),
                          color: _currentPage == index
                              ? AppColors.blueBright
                              : AppColors.blueBright.withOpacity(0.3),
                        ),
                      );
                    }),
                  ),
                  // Botón Siguiente/Comenzar
                  ElevatedButton(
                    onPressed: () {
                      if (_currentPage == _slides.length - 1) {
                        // Navegar a Role Selection
                        Navigator.pushReplacementNamed(context, AppRoutes.roleSelection);
                      } else {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.blueBright,
                      foregroundColor: Colors.white,
                      padding: resp.padding(horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: resp.radius(30),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      _currentPage == _slides.length - 1 ? 'Comenzar' : 'Siguiente',
                      style: TextStyle(
                        fontSize: resp.sp(14),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            resp.sizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class OnboardingData {
  final String title;
  final String description;
  final IconData icon;
  final Color illustrationColor;

  OnboardingData({
    required this.title,
    required this.description,
    required this.icon,
    required this.illustrationColor,
  });
}

