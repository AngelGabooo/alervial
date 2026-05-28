import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';
import 'package:viatux/routes/app_routes.dart'; // 👉 IMPORTANTE PARA LAS RUTAS
import '../../home/widgets/bottom_nav_bar.dart';
import '../widgets/personal_profile_card.dart';
import '../widgets/metric_grid.dart';
import '../widgets/progression_card.dart';
import '../widgets/activity_chart.dart';

class PersonalStatsPage extends StatefulWidget {
  const PersonalStatsPage({super.key});

  @override
  State<PersonalStatsPage> createState() => _PersonalStatsPageState();
}

class _PersonalStatsPageState extends State<PersonalStatsPage> {
  final int _currentIndex = 4; // Pestaña de Perfil activa

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Mis estadísticas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: resp.padding(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Consulta tu impacto ciudadano y actividad dentro de la app.',
              style: TextStyle(
                fontSize: resp.sp(14),
                color: isDark ? Colors.grey[400] : Colors.grey[600],
              ),
            ),
            resp.sizedBox(height: 20),

            const PersonalProfileCard(),
            resp.sizedBox(height: 24),

            const MetricGrid(),
            resp.sizedBox(height: 24),

            const ProgressionCard(),
            resp.sizedBox(height: 24),

            const ActivityChart(),
            resp.sizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          // 👉 LÓGICA DE NAVEGACIÓN ACTIVA
          if (index == 0) {
            // Regresa al inicio limpiando el historial de navegación para evitar bucles
            Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (route) => false);
          } else if (index != _currentIndex) {
            // Manejo dinámico para el resto de pestañas si deseas mapearlas luego
            setState(() {
              // Puedes procesar otros saltos de ruta aquí
            });
          }
        },
      ),
    );
  }
}