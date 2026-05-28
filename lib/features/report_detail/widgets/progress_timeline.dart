import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';

class ProgressTimeline extends StatelessWidget {
  const ProgressTimeline({super.key});

  final List<Map<String, dynamic>> _steps = const [
    {
      'title': 'Reporte enviado',
      'date': '15 mayo, 14:30',
      'completed': true,
      'icon': Icons.send_rounded,
    },
    {
      'title': 'Reporte revisado',
      'date': '16 mayo, 09:15',
      'completed': true,
      'icon': Icons.visibility_rounded,
    },
    {
      'title': 'En atención',
      'date': 'En progreso',
      'completed': false,
      'icon': Icons.engineering_rounded,
    },
    {
      'title': 'Solucionado',
      'date': 'Pendiente',
      'completed': false,
      'icon': Icons.check_circle_rounded,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Progreso del reporte',
          style: TextStyle(
            fontSize: resp.sp(18),
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        SizedBox(height: resp.hp(2)),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _steps.length,
          itemBuilder: (context, index) {
            final step = _steps[index];
            final isLast = index == _steps.length - 1;
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(resp.wp(2)),
                      decoration: BoxDecoration(
                        color: step['completed']
                            ? AppColors.softGreen
                            : (isDark ? Colors.grey[800] : Colors.grey[200]),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        step['icon'],
                        size: resp.iconSize(18),
                        color: step['completed'] ? Colors.white : Colors.grey,
                      ),
                    ),
                    if (!isLast)
                      Container(
                        width: 2,
                        height: resp.hp(5),
                        color: step['completed']
                            ? AppColors.softGreen
                            : (isDark ? Colors.grey[800] : Colors.grey[200]),
                      ),
                  ],
                ),
                SizedBox(width: resp.wp(3)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        step['title'],
                        style: TextStyle(
                          fontSize: resp.sp(15),
                          fontWeight: FontWeight.w600,
                          color: step['completed']
                              ? AppColors.softGreen
                              : (isDark ? Colors.white : Colors.black87),
                        ),
                      ),
                      SizedBox(height: resp.hp(0.5)),
                      Text(
                        step['date'],
                        style: TextStyle(
                          fontSize: resp.sp(12),
                          color: isDark ? Colors.grey[500] : Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: isLast ? 0 : resp.hp(2)),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}