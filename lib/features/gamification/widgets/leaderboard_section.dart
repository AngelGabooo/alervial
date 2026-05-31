import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';

class LeaderboardSection extends StatelessWidget {
  final int userXP;
  final String userName;
  final String userMunicipio;

  const LeaderboardSection({
    super.key,
    required this.userXP,
    required this.userName,
    required this.userMunicipio,
  });

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Datos de ejemplo para la clasificación
    final List<Map<String, dynamic>> leaders = [
      {'pos': '🥇', 'name': 'Carlos R.', 'xp': 4500, 'municipio': 'Tuxtla', 'isUser': false},
      {'pos': '🥈', 'name': 'Sofía M.', 'xp': 3800, 'municipio': 'San Cristóbal', 'isUser': false},
      {'pos': '🥉', 'name': 'Ana L.', 'xp': 3100, 'municipio': 'Chiapa de Corzo', 'isUser': false},
      {'pos': '4', 'name': userName, 'xp': userXP, 'municipio': userMunicipio, 'isUser': true},
      {'pos': '5', 'name': 'Luis F.', 'xp': 1800, 'municipio': 'Tuxtla', 'isUser': false},
    ];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: resp.wp(5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Clasificación municipal',
            style: TextStyle(
              fontSize: resp.sp(18),
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          SizedBox(height: resp.hp(1.5)),
          Container(
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E293B) : Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              children: leaders.map((leader) {
                return _buildLeaderRow(context, leader);
              }).toList(),
            ),
          ),
          SizedBox(height: resp.hp(4)),
        ],
      ),
    );
  }

  Widget _buildLeaderRow(BuildContext context, Map<String, dynamic> leader) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isUser = leader['isUser'] as bool;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: resp.wp(4), vertical: resp.hp(1.2)),
      decoration: BoxDecoration(
        color: isUser
            ? AppColors.blueBright.withOpacity(0.1)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          SizedBox(
            width: resp.wp(10),
            child: Text(
              leader['pos'],
              style: TextStyle(
                fontSize: resp.sp(16),
                fontWeight: FontWeight.bold,
                color: isUser ? AppColors.blueBright : (isDark ? Colors.white : Colors.black87),
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  leader['name'],
                  style: TextStyle(
                    fontSize: resp.sp(14),
                    fontWeight: isUser ? FontWeight.bold : FontWeight.w500,
                    color: isUser ? AppColors.blueBright : (isDark ? Colors.white : Colors.black87),
                  ),
                ),
                Text(
                  leader['municipio'],
                  style: TextStyle(
                    fontSize: resp.sp(11),
                    color: isDark ? Colors.grey[500] : Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: resp.wp(2), vertical: resp.hp(0.3)),
            decoration: BoxDecoration(
              color: Colors.amber.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.star_rounded, size: resp.iconSize(12), color: Colors.amber),
                SizedBox(width: resp.wp(0.5)),
                Text(
                  '${leader['xp']} XP',
                  style: TextStyle(
                    fontSize: resp.sp(11),
                    fontWeight: FontWeight.w600,
                    color: Colors.amber,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}