import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';

class ProgressionCard extends StatelessWidget {
  const ProgressionCard({super.key});

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: resp.padding(all: 18),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: resp.radius(20),
        border: Border.all(color: isDark ? Colors.white10 : Colors.grey.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Nivel Ciudadano', style: TextStyle(fontSize: resp.sp(14), fontWeight: FontWeight.bold)),
              Text('Impacto: Alto', style: TextStyle(fontSize: resp.sp(12), color: AppColors.blueBright, fontWeight: FontWeight.w600)),
            ],
          ),
          resp.sizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: 0.75,
              minHeight: resp.hp(1),
              backgroundColor: isDark ? Colors.white10 : Colors.grey[200],
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.blueBright),
            ),
          ),
          resp.sizedBox(height: 12),
          Text(
            'Has ayudado a resolver 18 incidencias viales.',
            style: TextStyle(fontSize: resp.sp(12), color: isDark ? Colors.grey[400] : Colors.grey[700]),
          ),
        ],
      ),
    );
  }
}