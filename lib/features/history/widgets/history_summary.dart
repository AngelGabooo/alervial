import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';

class HistorySummary extends StatelessWidget {
  const HistorySummary({super.key});

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      children: [
        _buildSummaryCard(
          context,
          value: '24',
          label: 'Reportes',
          icon: Icons.report_problem_rounded,
          color: AppColors.blueBright,
        ),
        SizedBox(width: resp.wp(2)),
        _buildSummaryCard(
          context,
          value: '18',
          label: 'Resueltos',
          icon: Icons.check_circle_rounded,
          color: AppColors.softGreen,
        ),
        SizedBox(width: resp.wp(2)),
        _buildSummaryCard(
          context,
          value: '75%',
          label: 'Participación',
          icon: Icons.trending_up_rounded,
          color: Colors.orange,
        ),
        SizedBox(width: resp.wp(2)),
        _buildSummaryCard(
          context,
          value: '48h',
          label: 'Tiempo promedio',
          icon: Icons.access_time_rounded,
          color: Colors.purple,
        ),
      ],
    );
  }

  Widget _buildSummaryCard(BuildContext context, {
    required String value,
    required String label,
    required IconData icon,
    required Color color,
  }) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: resp.hp(1.5)),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(resp.wp(2)),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: resp.iconSize(18), color: color),
            ),
            SizedBox(height: resp.hp(0.5)),
            Text(
              value,
              style: TextStyle(
                fontSize: resp.sp(16),
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: resp.sp(10),
                color: isDark ? Colors.grey[500] : Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}