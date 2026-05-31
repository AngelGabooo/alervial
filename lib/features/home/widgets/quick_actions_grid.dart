import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';

class QuickActionsGrid extends StatelessWidget {
  final VoidCallback onHistoryTap;
  final VoidCallback onRecentActivityTap;
  final VoidCallback onRiskZonesTap;
  final VoidCallback onMyReportsTap;
  final VoidCallback onGamificationTap;
  final VoidCallback onPersonalStatsTap;

  const QuickActionsGrid({
    super.key,
    required this.onHistoryTap,
    required this.onRecentActivityTap,
    required this.onRiskZonesTap,
    required this.onMyReportsTap,
    required this.onGamificationTap,
    required this.onPersonalStatsTap,
  });

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final List<Map<String, dynamic>> actions = [
      {'icon': Icons.history_rounded, 'label': 'Historial', 'color': Colors.blue, 'onTap': onHistoryTap},
      {'icon': Icons.access_time_rounded, 'label': 'Actividad', 'color': Colors.green, 'onTap': onRecentActivityTap},
      {'icon': Icons.warning_rounded, 'label': 'Riesgos', 'color': Colors.orange, 'onTap': onRiskZonesTap},
      {'icon': Icons.assignment_rounded, 'label': 'Mis reportes', 'color': Colors.purple, 'onTap': onMyReportsTap},
      {'icon': Icons.emoji_events_rounded, 'label': 'Logros', 'color': Colors.amber, 'onTap': onGamificationTap},
      {'icon': Icons.bar_chart_rounded, 'label': 'Estadísticas', 'color': Colors.teal, 'onTap': onPersonalStatsTap},
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: resp.wp(5), vertical: resp.hp(1.5)),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1.1,
          crossAxisSpacing: resp.wp(3),
          mainAxisSpacing: resp.hp(1.5),
        ),
        itemCount: actions.length,
        itemBuilder: (context, index) {
          final action = actions[index];
          return _buildActionCard(context, action);
        },
      ),
    );
  }

  Widget _buildActionCard(BuildContext context, Map<String, dynamic> action) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = action['color'] as Color;

    return GestureDetector(
      onTap: action['onTap'],
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color.withOpacity(0.15),
              color.withOpacity(0.05),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: color.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(resp.wp(3)),
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(
                action['icon'],
                size: resp.iconSize(28),
                color: color,
              ),
            ),
            SizedBox(height: resp.hp(1)),
            Text(
              action['label'],
              style: TextStyle(
                fontSize: resp.sp(12),
                fontWeight: FontWeight.w500,
                color: isDark ? Colors.white : Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}