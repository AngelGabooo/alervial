import 'package:flutter/material.dart';
import 'package:viatux/core/utils/responsive.dart';

class ChallengeList extends StatelessWidget {
  const ChallengeList({super.key});

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: resp.padding(all: 16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: resp.radius(20),
      ),
      child: Column(
        children: [
          _buildRow(context, 'Reportar 3 incidencias', '2/3', 0.66, '+150 XP'),
          const Divider(height: 24),
          _buildRow(context, 'Agregar una evidencia extra', '0/1', 0.0, '+50 XP'),
        ],
      ),
    );
  }

  Widget _buildRow(BuildContext context, String title, String progress, double value, String reward) {
    final resp = context.resp;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: TextStyle(fontSize: resp.sp(13), fontWeight: FontWeight.w600)),
            Text(reward, style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
          ],
        ),
        resp.sizedBox(height: 8),
        LinearProgressIndicator(value: value, minHeight: 4),
        resp.sizedBox(height: 4),
        Text('Progreso: $progress', style: TextStyle(fontSize: resp.sp(11), color: Colors.grey)),
      ],
    );
  }
}