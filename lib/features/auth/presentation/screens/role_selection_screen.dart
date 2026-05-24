// lib/features/auth/presentation/screens/role_selection_screen.dart (CORREGIDO)
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/role_card.dart';
import '../../../../core/services/user_service.dart';

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: isDark ? AppColors.darkGradient : AppColors.primaryGradient,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                // Botón de retroceso
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
                // Header
                const Text(
                  "Selecciona tu rol",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Elige cómo quieres usar AlertaVial",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 40),
                // Cards
                RoleCard(
                  icon: Icons.person,
                  title: "Ciudadano",
                  description: "Reporta incidencias viales y da seguimiento a tus reportes.",
                  color: AppColors.primaryBlue,
                  onTap: () async {
                    // Guardar rol seleccionado
                    await UserService.updateUserRole('ciudadano');
                    if (mounted) {
                      Navigator.pushReplacementNamed(context, '/home');
                    }
                  },
                ),
                const SizedBox(height: 16),
                RoleCard(
                  icon: Icons.shield,
                  title: "Autoridad",
                  description: "Administra reportes y supervisa incidencias en tiempo real.",
                  color: AppColors.accentGreen,
                  onTap: () async {
                    // Guardar rol seleccionado
                    await UserService.updateUserRole('autoridad');
                    if (mounted) {
                      Navigator.pushReplacementNamed(context, '/home');
                    }
                  },
                ),
                const SizedBox(height: 16),
                RoleCard(
                  icon: Icons.map_outlined,
                  title: "Visitante",
                  description: "Consulta incidencias activas sin necesidad de registrarte.",
                  color: AppColors.accentYellow,
                  onTap: () async {
                    // Guardar rol seleccionado
                    await UserService.updateUserRole('visitante');
                    if (mounted) {
                      Navigator.pushReplacementNamed(context, '/home');
                    }
                  },
                ),
                const Spacer(),
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      "Puedes cambiar este acceso más adelante",
                      style: TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}