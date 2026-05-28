import 'package:flutter/material.dart';
import 'package:viatux/core/utils/responsive.dart';

class ActivityChart extends StatelessWidget {
  const ActivityChart({super.key});

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: resp.padding(all: 16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: resp.radius(20),
        border: Border.all(color: isDark ? Colors.white10 : Colors.grey.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Actividad Semanal',
            style: TextStyle(fontSize: resp.sp(14), fontWeight: FontWeight.bold),
          ),
          resp.sizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end, // 👈 ¡Corregido a .end!
            children: [
              _buildBar(context, 'Lun', 0.3),
              _buildBar(context, 'Mar', 0.6),
              _buildBar(context, 'Mié', 0.9),
              _buildBar(context, 'Jue', 0.4),
              _buildBar(context, 'Vie', 0.7),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBar(BuildContext context, String day, double heightFactor) {
    final resp = context.resp;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: resp.hp(10) * heightFactor,
          width: resp.wp(4),
          decoration: BoxDecoration(
            color: const Color(0xFF1565C0),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        resp.sizedBox(height: 6),
        Text(day, style: TextStyle(fontSize: resp.sp(10), color: Colors.grey)),
      ],
    );
  }
}