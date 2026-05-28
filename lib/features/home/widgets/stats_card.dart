import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';

class StatsCard extends StatelessWidget {
  const StatsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: resp.padding(horizontal: 20, top: 20),
      child: Container(
        padding: resp.padding(all: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              isDark ? const Color(0xFF1E1E1E) : Colors.white,
              isDark ? const Color(0xFF2D2D2D) : const Color(0xFFF8FAFF),
            ],
          ),
          borderRadius: resp.radius(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStatItem(
              context,
              value: '24',
              label: 'Reportes enviados',
              icon: Icons.report_problem_rounded,
              color: Colors.orange,
            ),
            Container(
              width: 1,
              height: resp.hp(6),
              color: Colors.grey.withOpacity(0.3),
            ),
            _buildStatItem(
              context,
              value: '18',
              label: 'Reportes resueltos',
              icon: Icons.check_circle_rounded,
              color: AppColors.softGreen,
            ),
            Container(
              width: 1,
              height: resp.hp(6),
              color: Colors.grey.withOpacity(0.3),
            ),
            _buildStatItem(
              context,
              value: '75%',
              label: 'Participación',
              icon: Icons.trending_up_rounded,
              color: AppColors.blueBright,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(
      BuildContext context, {
        required String value,
        required String label,
        required IconData icon,
        required Color color,
      }) {
    final resp = context.resp;

    return Column(
      children: [
        Container(
          padding: resp.padding(all: 8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: resp.iconSize(24), color: color),
        ),
        resp.sizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: resp.sp(24),
            fontWeight: FontWeight.bold,
          ),
        ),
        resp.sizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: resp.sp(11),
            color: Colors.grey[600],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}