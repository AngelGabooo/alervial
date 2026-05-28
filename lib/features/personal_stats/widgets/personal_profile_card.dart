import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';

class PersonalProfileCard extends StatelessWidget {
  const PersonalProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: resp.padding(all: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [const Color(0xFF1E293B), const Color(0xFF0F172A)]
              : [AppColors.blueDark, AppColors.blueBright],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: resp.radius(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.blueBright.withOpacity(isDark ? 0.15 : 0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: resp.wp(9),
            backgroundColor: Colors.white24,
            child: CircleAvatar(
              radius: resp.wp(8.2),
              backgroundImage: const NetworkImage('https://randomuser.me/api/portraits/men/32.jpg'),
            ),
          ),
          resp.sizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ángel Morales',
                  style: TextStyle(fontSize: resp.sp(18), fontWeight: FontWeight.bold, color: Colors.white),
                ),
                resp.sizedBox(height: 4),
                Container(
                  padding: resp.padding(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: resp.radius(20),
                  ),
                  child: Text(
                    '⚡ Ciudadano Supervisor',
                    style: TextStyle(fontSize: resp.sp(11), color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
                resp.sizedBox(height: 6),
                Text(
                  '📍 Tuxtla Gutiérrez • Desde 2025',
                  style: TextStyle(fontSize: resp.sp(11), color: Colors.white.withOpacity(0.7)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}