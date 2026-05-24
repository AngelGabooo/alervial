import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/services/screenshot_service.dart';
import 'package:viatux/core/widgets/screenshot_alert.dart';
import 'package:viatux/core/widgets/gradient_background.dart';
import 'package:viatux/routes/app_routes.dart';
import '../widgets/login_form.dart';
import '../widgets/social_login.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    _disableScreenshots();
  }

  @override
  void dispose() {
    _enableScreenshots();
    super.dispose();
  }

  Future<void> _disableScreenshots() async {
    await ScreenshotService.disableScreenshots(
      onScreenshotTaken: () {
        debugPrint('📸 Screenshot detected in LoginPage!');
        if (mounted) {
          showScreenshotAlert(context);
        }
      },
    );
  }

  Future<void> _enableScreenshots() async {
    await ScreenshotService.enableScreenshots();
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      hasPattern: true,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.warning_rounded,
                    size: 45,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Bienvenido nuevamente',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Inicia sesión para continuar reportando incidencias.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(32),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(24),
                    child: LoginForm(),
                  ),
                ),
                const SizedBox(height: 24),
                TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Recuperar contraseña - Próximamente')),
                    );
                  },
                  child: Text(
                    '¿Olvidaste tu contraseña?',
                    style: TextStyle(
                      color: AppColors.softGreen,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const SocialLogin(),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '¿No tienes cuenta? ',
                      style: TextStyle(color: Colors.white70),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, AppRoutes.register);
                      },
                      child: Text(
                        'Regístrate',
                        style: TextStyle(
                          color: AppColors.softGreen,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}