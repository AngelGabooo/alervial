import 'package:flutter/material.dart';
import 'package:viatux/core/utils/responsive.dart';

class BadgesGrid extends StatelessWidget {
  const BadgesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;

    final List<Map<String, String>> badges = [
      {'emoji': '🏃', 'name': 'Ciudadano Activo'},
      {'emoji': '🛡️', 'name': 'Protector Vial'},
      {'emoji': '📸', 'name': 'Reportero Experto'},
    ];

    return SizedBox(
      height: resp.hp(12),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: badges.length,
        itemBuilder: (context, index) {
          final item = badges[index];
          final isDark = Theme.of(context).brightness == Brightness.dark;

          return Container(
            width: resp.wp(28),
            margin: resp.padding(right: 12),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E293B) : Colors.white,
              borderRadius: resp.radius(16),
              border: Border.all(color: Colors.grey.withOpacity(0.1)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(item['emoji']!, style: TextStyle(fontSize: resp.sp(24))),
                resp.sizedBox(height: 4),
                Text(
                  item['name']!,
                  style: TextStyle(fontSize: resp.sp(10), fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}