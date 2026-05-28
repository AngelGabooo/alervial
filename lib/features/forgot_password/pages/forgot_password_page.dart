import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';
import 'package:viatux/core/widgets/gradient_background.dart';
import 'package:viatux/routes/app_routes.dart';
import '../widgets/forgot_password_form.dart';
import '../widgets/forgot_password_illustration.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;

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
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.warning_rounded, size: resp.iconSize(20), color: Colors.white),
              const SizedBox(width: 6),
              Text(
                'ALERTAVIAL',
                style: TextStyle(
                  fontSize: resp.sp(14),
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: resp.padding(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                resp.sizedBox(height: 20),
                const ForgotPasswordIllustration(),
                resp.sizedBox(height: 24),
                Text(
                  'Recuperar contraseña',
                  style: TextStyle(
                    fontSize: resp.sp(28),
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                resp.sizedBox(height: 8),
                Text(
                  'Ingresa tu correo electrónico y te enviaremos instrucciones para recuperar tu acceso.',
                  style: TextStyle(
                    fontSize: resp.sp(14),
                    color: Colors.white.withOpacity(0.8),
                    height: 1.4,
                  ),
                ),
                resp.sizedBox(height: 32),
                const ForgotPasswordForm(),
                resp.sizedBox(height: 16),
                Center(
                  child: Text(
                    'Revisa tu bandeja de entrada y spam.',
                    style: TextStyle(
                      fontSize: resp.sp(12),
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ),
                ),
                resp.sizedBox(height: 16),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, AppRoutes.login);
                    },
                    child: Text(
                      'Volver al inicio de sesión',
                      style: TextStyle(
                        color: AppColors.softGreen,
                        fontSize: resp.sp(14),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                resp.sizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}