import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';

class ChallengesSection extends StatelessWidget {
  final int totalReports;

  const ChallengesSection({super.key, required this.totalReports});

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final challenges = [
      {
        'title': 'Primeros pasos',
        'description': 'Reporta tu primera incidencia',
        'progress': totalReports >= 1 ? 'Completado' : '0/1',
        'value': totalReports >= 1 ? 1.0 : 0.0,
        'reward': '+100 XP',
        'icon': Icons.rocket_launch_rounded,
        'completed': totalReports >= 1,
      },
      {
        'title': 'Fotógrafo urbano',
        'description': 'Sube fotos a tus reportes',
        'progress': 'En progreso',
        'value': 0.3,
        'reward': '+150 XP',
        'icon': Icons.camera_alt_rounded,
        'completed': false,
      },
      {
        'title': 'Ciudadano activo',
        'description': 'Alcanza 5 reportes',
        'progress': totalReports >= 5 ? 'Completado' : '$totalReports/5',
        'value': totalReports >= 5 ? 1.0 : totalReports / 5,
        'reward': '+250 XP',
        'icon': Icons.people_alt_rounded,
        'completed': totalReports >= 5,
      },
      {
        'title': 'Guardián vial',
        'description': 'Alcanza 10 reportes',
        'progress': totalReports >= 10 ? 'Completado' : '$totalReports/10',
        'value': totalReports >= 10 ? 1.0 : totalReports / 10,
        'reward': '+500 XP',
        'icon': Icons.shield_rounded,
        'completed': totalReports >= 10,
      },
    ];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: resp.wp(5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Desafíos activos',
            style: TextStyle(
              fontSize: resp.sp(18),
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          SizedBox(height: resp.hp(1.5)),
          ...challenges.map((challenge) => _buildChallengeCard(context, challenge)),
          SizedBox(height: resp.hp(3)),
        ],
      ),
    );
  }

  Widget _buildChallengeCard(BuildContext context, Map<String, dynamic> challenge) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final completed = challenge['completed'] as bool;

    return Container(
      margin: EdgeInsets.only(bottom: resp.hp(1.5)),
      padding: EdgeInsets.all(resp.wp(3)),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: completed
            ? Border.all(color: AppColors.softGreen, width: 1.5)
            : null,
      ),
      child: Row(
        children: [
          Container(
            width: resp.wp(12),
            height: resp.wp(12),
            decoration: BoxDecoration(
              color: completed
                  ? AppColors.softGreen.withOpacity(0.1)
                  : AppColors.blueBright.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              challenge['icon'],
              size: resp.iconSize(24),
              color: completed ? AppColors.softGreen : AppColors.blueBright,
            ),
          ),
          SizedBox(width: resp.wp(3)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      challenge['title'],
                      style: TextStyle(
                        fontSize: resp.sp(14),
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      challenge['reward'],
                      style: TextStyle(
                        fontSize: resp.sp(11),
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: resp.hp(0.3)),
                Text(
                  challenge['description'],
                  style: TextStyle(
                    fontSize: resp.sp(12),
                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
                if (!completed) ...[
                  SizedBox(height: resp.hp(1)),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: challenge['value'],
                      minHeight: resp.hp(0.6),
                      backgroundColor: isDark ? Colors.grey[800] : Colors.grey[200],
                      valueColor: const AlwaysStoppedAnimation<Color>(AppColors.blueBright),
                    ),
                  ),
                  SizedBox(height: resp.hp(0.5)),
                  Text(
                    'Progreso: ${challenge['progress']}',
                    style: TextStyle(
                      fontSize: resp.sp(10),
                      color: isDark ? Colors.grey[500] : Colors.grey[500],
                    ),
                  ),
                ] else ...[
                  SizedBox(height: resp.hp(0.8)),
                  Row(
                    children: [
                      Icon(Icons.check_circle_rounded, size: resp.iconSize(14), color: AppColors.softGreen),
                      SizedBox(width: resp.wp(1)),
                      Text(
                        'Completado',
                        style: TextStyle(
                          fontSize: resp.sp(11),
                          color: AppColors.softGreen,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}