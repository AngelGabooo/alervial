import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';
import 'package:viatux/routes/app_routes.dart'; // 👉 IMPORTANTE PARA LAS RUTAS
import '../../home/widgets/bottom_nav_bar.dart';
import '../widgets/neon_level_card.dart';
import '../widgets/badges_grid.dart';
import '../widgets/challenge_list.dart';
import '../widgets/leaderboard_view.dart';

class GamificationPage extends StatefulWidget {
  const GamificationPage({super.key});

  @override
  State<GamificationPage> createState() => _GamificationPageState();
}

class _GamificationPageState extends State<GamificationPage> {
  final int _currentIndex = 0; // Se mantiene en inicio o el índice que gustes asignarle

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F172A) : AppColors.lightBackground,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Gamificación'),
        actions: [
          IconButton(icon: const Icon(Icons.emoji_events_outlined, color: Colors.amber), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: resp.padding(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Participa y desbloquea logros ayudando a tu ciudad.',
              style: TextStyle(fontSize: resp.sp(14), color: Colors.grey),
            ),
            resp.sizedBox(height: 20),

            const NeonLevelCard(),
            resp.sizedBox(height: 24),

            Text('Insignias Desbloqueadas', style: TextStyle(fontSize: resp.sp(16), fontWeight: FontWeight.bold)),
            resp.sizedBox(height: 12),
            const BadgesGrid(),
            resp.sizedBox(height: 24),

            Text('Retos Activos', style: TextStyle(fontSize: resp.sp(16), fontWeight: FontWeight.bold)),
            resp.sizedBox(height: 12),
            const ChallengeList(),
            resp.sizedBox(height: 24),

            Text('Clasificación por Municipio', style: TextStyle(fontSize: resp.sp(16), fontWeight: FontWeight.bold)),
            resp.sizedBox(height: 12),
            const LeaderboardView(),
            resp.sizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          // 👉 LÓGICA DE NAVEGACIÓN ACTIVA
          if (index == 0) {
            Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (route) => false);
          }
        },
      ),
    );
  }
}