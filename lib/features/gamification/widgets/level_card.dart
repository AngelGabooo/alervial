import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';

class LevelCard extends StatelessWidget {
  final int level;
  final int currentXP;
  final int nextLevelXP;
  final double xpProgress;
  final int totalReports;

  const LevelCard({
    super.key,
    required this.level,
    required this.currentXP,
    required this.nextLevelXP,
    required this.xpProgress,
    required this.totalReports,
  });

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: EdgeInsets.all(resp.wp(5)),
      padding: EdgeInsets.all(resp.wp(4)),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.blueBright,
            const Color(0xFF1565C0),
          ],
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: AppColors.blueBright.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: resp.wp(15),
                height: resp.wp(15),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '$level',
                    style: TextStyle(
                      fontSize: resp.sp(32),
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(width: resp.wp(4)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nivel $level',
                      style: TextStyle(
                        fontSize: resp.sp(22),
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '${_getRankTitle(level)} • $totalReports reportes',
                      style: TextStyle(
                        fontSize: resp.sp(12),
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: resp.wp(3),
                  vertical: resp.hp(0.8),
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(Icons.star_rounded, size: resp.iconSize(14), color: Colors.amber),
                    SizedBox(width: resp.wp(1)),
                    Text(
                      '$currentXP XP',
                      style: TextStyle(
                        fontSize: resp.sp(12),
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: resp.hp(2)),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: LinearProgressIndicator(
              value: xpProgress.clamp(0.0, 1.0),
              minHeight: resp.hp(1.2),
              backgroundColor: Colors.white.withOpacity(0.2),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.greenAccent),
            ),
          ),
          SizedBox(height: resp.hp(1)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$currentXP XP',
                style: TextStyle(fontSize: resp.sp(11), color: Colors.white70),
              ),
              Text(
                '${nextLevelXP - currentXP} XP para nivel ${level + 1}',
                style: TextStyle(fontSize: resp.sp(11), color: Colors.white70),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getRankTitle(int level) {
    if (level >= 20) return 'Leyenda Vial';
    if (level >= 15) return 'Guardián de la Ciudad';
    if (level >= 10) return 'Protector Vial';
    if (level >= 5) return 'Ciudadano Activo';
    return 'Nuevo Recluta';
  }
}