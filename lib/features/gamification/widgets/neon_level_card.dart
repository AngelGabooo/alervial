import 'package:flutter/material.dart';
import 'package:viatux/core/utils/responsive.dart';

class NeonLevelCard extends StatelessWidget {
  const NeonLevelCard({super.key});

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;

    return Container(
      padding: resp.padding(all: 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6366F1), Color(0xFFA855F7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: resp.radius(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFA855F7).withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('RANGO CIUDADANO', style: TextStyle(color: Colors.white70, fontSize: resp.sp(11), fontWeight: FontWeight.bold)),
                  Text('Nivel 14', style: TextStyle(color: Colors.white, fontSize: resp.sp(28), fontWeight: FontWeight.bold)),
                ],
              ),
              const Icon(Icons.workspace_premium_rounded, color: Colors.amber, size: 36),
            ],
          ),
          resp.sizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: 0.65,
              minHeight: resp.hp(1),
              backgroundColor: Colors.white24,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.greenAccent),
            ),
          ),
          resp.sizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('2,450 XP', style: TextStyle(color: Colors.white, fontSize: resp.sp(12))),
              Text('Ranking: #5 Estatal', style: TextStyle(color: Colors.white70, fontSize: resp.sp(12))),
            ],
          )
        ],
      ),
    );
  }
}