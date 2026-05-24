import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import '../../../core/utils/responsive.dart';
import '../widgets/action_buttons.dart';
import '../widgets/welcome_header.dart';
import '../widgets/welcome_illustration.dart';
import '../../../routes/app_routes.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const WelcomeHeader(),
              const WelcomeIllustration(),
              resp.sizedBox(height: 20),
              // ✅ CORREGIDO: Pasar los 3 callbacks requeridos
              ActionButtons(
                onLogin: () {
                  Navigator.pushNamed(context, AppRoutes.login);
                },
                onRegister: () {
                  Navigator.pushNamed(context, AppRoutes.register);
                },
                onVisitor: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Modo visitante - Próximamente')),
                  );
                },
              ),
              resp.sizedBox(height: 16),
              Container(
                padding: resp.padding(horizontal: 20),
                child: Column(
                  children: [
                    Container(
                      padding: resp.padding(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.softGreen.withOpacity(0.1),
                        borderRadius: resp.radius(16),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.verified_rounded,
                            size: resp.iconSize(14),
                            color: AppColors.softGreen,
                          ),
                          resp.sizedBox(width: 6),
                          Text(
                            'Más de 1,200 reportes ciudadanos gestionados',
                            style: TextStyle(
                              fontSize: resp.sp(11),
                              color: AppColors.softGreen,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    resp.sizedBox(height: 12),
                    Text(
                      'Gobierno abierto y participación ciudadana',
                      style: TextStyle(
                        fontSize: resp.sp(11),
                        color: isDark ? Colors.grey[400] : Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              resp.sizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}