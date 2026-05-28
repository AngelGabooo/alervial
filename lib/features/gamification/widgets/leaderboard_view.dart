import 'package:flutter/material.dart';
import 'package:viatux/core/utils/responsive.dart';

class LeaderboardView extends StatelessWidget {
  const LeaderboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final List<Map<String, String>> leaders = [
      {'pos': '1', 'name': 'Carlos R.', 'xp': '4,500 XP', 'mun': 'Tuxtla'},
      {'pos': '2', 'name': 'Sofía M.', 'xp': '3,800 XP', 'mun': 'San Cristóbal'},
      {'pos': '3', 'name': 'Ángel M. (Tú)', 'xp': '2,450 XP', 'mun': 'Tuxtla'},
    ];

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: leaders.length,
        itemBuilder: (context, index) {
          final user = leaders[index];
          return ListTile(
            leading: CircleAvatar(
              radius: 14,
              backgroundColor: user['pos'] == '1' ? Colors.amber : Colors.transparent,
              child: Text(user['pos']!, style: TextStyle(fontWeight: FontWeight.bold, color: user['pos'] == '1' ? Colors.black : Colors.grey)),
            ),
            title: Text(user['name']!, style: const TextStyle(fontWeight: FontWeight.w600)),
            subtitle: Text(user['mun']!),
            trailing: Text(user['xp']!, style: const TextStyle(color: Colors.indigoAccent, fontWeight: FontWeight.bold)),
          );
        },
      ),
    );
  }
}