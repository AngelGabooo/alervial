import 'package:flutter/material.dart';
import 'package:viatux/core/utils/responsive.dart';
import 'package:viatux/core/constants/colors.dart';
class TimelineSteps extends StatelessWidget {
  const TimelineSteps({super.key});

  final List<Map<String, dynamic>> _steps = const [
    {'title': 'Reporte enviado', 'icon': Icons.send_rounded, 'active': true},
    {'title': 'Revisión', 'icon': Icons.visibility_rounded, 'active': false},
    {'title': 'En proceso', 'icon': Icons.engineering_rounded, 'active': false},
    {'title': 'Resuelto', 'icon': Icons.check_circle_rounded, 'active': false},
  ];

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '¿Qué sucede ahora?',
          style: TextStyle(
            fontSize: resp.sp(16),
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        SizedBox(height: resp.hp(2)),
        Row(
          children: _steps.asMap().entries.map((entry) {
            final index = entry.key;
            final step = entry.value;
            final isLast = index == _steps.length - 1;

            return Expanded(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(resp.wp(2.5)),
                    decoration: BoxDecoration(
                      color: step['active']
                          ? AppColors.softGreen
                          : Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      step['icon'],
                      size: resp.iconSize(20),
                      color: step['active'] ? Colors.white : Colors.white70,
                    ),
                  ),
                  SizedBox(height: resp.hp(0.5)),
                  Text(
                    step['title'],
                    style: TextStyle(
                      fontSize: resp.sp(10),
                      color: step['active'] ? Colors.white : Colors.white60,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }).toList(),
        ),
        SizedBox(height: resp.hp(1)),
        Row(
          children: _steps.asMap().entries.map((entry) {
            final index = entry.key;
            final isLast = index == _steps.length - 1;

            return Expanded(
              child: Container(
                height: 2,
                margin: EdgeInsets.symmetric(horizontal: resp.wp(2)),
                color: index < 1
                    ? AppColors.softGreen
                    : Colors.white.withOpacity(0.2),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

// Import necesario
