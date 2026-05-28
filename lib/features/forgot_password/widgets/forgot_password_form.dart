import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';
import 'package:viatux/routes/app_routes.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _sendRecovery() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      // Simular envío
      await Future.delayed(const Duration(seconds: 2));

      setState(() => _isLoading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Correo de recuperación enviado'),
          backgroundColor: AppColors.softGreen,
          behavior: SnackBarBehavior.floating,
        ),
      );

      Navigator.pushReplacementNamed(context, AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final buttonHeight = resp.buttonHeight(52);

    return Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: resp.radius(16),
            ),
            child: TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(color: Colors.white),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ingresa tu correo electrónico';
                }
                if (!value.contains('@') || !value.contains('.')) {
                  return 'Ingresa un correo válido';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Correo electrónico',
                labelStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                prefixIcon: Icon(Icons.email_outlined, color: Colors.white.withOpacity(0.7)),
                border: OutlineInputBorder(
                  borderRadius: resp.radius(16),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: resp.radius(16),
                  borderSide: BorderSide(color: Colors.white.withOpacity(0.2)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: resp.radius(16),
                  borderSide: const BorderSide(color: AppColors.blueBright, width: 2),
                ),
                contentPadding: resp.padding(horizontal: 16, vertical: 16),
              ),
            ),
          ),
          resp.sizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: buttonHeight,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _sendRecovery,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.blueBright,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: resp.radius(28)),
                elevation: 0,
              ),
              child: _isLoading
                  ? SizedBox(
                width: resp.wp(6),
                height: resp.wp(6),
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
                  : Text(
                'Enviar recuperación',
                style: TextStyle(fontSize: resp.sp(16), fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}