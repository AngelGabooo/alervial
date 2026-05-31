import 'package:flutter/material.dart';
import 'package:viatux/core/utils/responsive.dart';
import 'package:viatux/core/constants/colors.dart';
class BadgesSection extends StatelessWidget {
  final int totalReports;

  const BadgesSection({super.key, required this.totalReports});

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final List<Map<String, dynamic>> badges = [
      {'emoji': '🏅', 'name': 'Primer Reporte', 'required': 1, 'unlocked': totalReports >= 1},
      {'emoji': '📸', 'name': 'Fotógrafo', 'required': 3, 'unlocked': totalReports >= 3},
      {'emoji': '🛡️', 'name': 'Protector', 'required': 5, 'unlocked': totalReports >= 5},
      {'emoji': '🏆', 'name': 'Leyenda', 'required': 10, 'unlocked': totalReports >= 10},
      {'emoji': '⭐', 'name': 'Estrella', 'required': 15, 'unlocked': totalReports >= 15},
      {'emoji': '👑', 'name': 'Rey Vial', 'required': 20, 'unlocked': totalReports >= 20},
    ];

    final unlockedCount = badges.where((b) => b['unlocked'] == true).length;
    final totalCount = badges.length;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: resp.wp(5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Insignias',
                style: TextStyle(
                  fontSize: resp.sp(18),
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: resp.wp(2), vertical: resp.hp(0.3)),
                decoration: BoxDecoration(
                  color: AppColors.blueBright.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '$unlockedCount/$totalCount',
                  style: TextStyle(
                    fontSize: resp.sp(12),
                    color: AppColors.blueBright,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: resp.hp(1.5)),
          SizedBox(
            height: resp.hp(12),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: badges.length,
              itemBuilder: (context, index) {
                final badge = badges[index];
                final unlocked = badge['unlocked'];
                return Container(
                  width: resp.wp(25),
                  margin: EdgeInsets.only(right: resp.wp(3)),
                  padding: EdgeInsets.all(resp.wp(2)),
                  decoration: BoxDecoration(
                    gradient: unlocked
                        ? LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.amber.shade300, Colors.amber.shade600],
                    )
                        : null,
                    color: !unlocked
                        ? (isDark ? const Color(0xFF1E293B) : Colors.grey[200])
                        : null,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: unlocked ? Colors.amber : Colors.grey.withOpacity(0.2),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (unlocked)
                        Text(badge['emoji'], style: TextStyle(fontSize: resp.sp(28)))
                      else
                        Icon(Icons.lock_outline_rounded, size: resp.iconSize(28), color: Colors.grey),
                      SizedBox(height: resp.hp(1)),
                      Text(
                        badge['name'],
                        style: TextStyle(
                          fontSize: resp.sp(11),
                          fontWeight: unlocked ? FontWeight.w600 : FontWeight.normal,
                          color: unlocked ? Colors.white : Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      if (!unlocked)
                        Text(
                          '${badge['required']} reportes',
                          style: TextStyle(fontSize: resp.sp(9), color: Colors.grey),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(height: resp.hp(3)),
        ],
      ),
    );
  }
}

// Import necesario
