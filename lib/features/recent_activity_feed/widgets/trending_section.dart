import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';

class TrendingSection extends StatelessWidget {
  const TrendingSection({super.key});

  final List<Map<String, dynamic>> _trending = const [
    {'name': 'Tuxtla Gtz', 'count': '24 reportes', 'color': Colors.red},
    {'name': 'San Cristóbal', 'count': '18 reportes', 'color': Colors.orange},
    {'name': 'Chiapa de Corzo', 'count': '12 reportes', 'color': Colors.yellow},
  ];

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tendencias cercanas',
          style: TextStyle(
            fontSize: resp.sp(18),
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        SizedBox(height: resp.hp(1.5)),
        SizedBox(
          height: resp.hp(12),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: _trending.length,
            itemBuilder: (context, index) {
              final item = _trending[index];
              return Container(
                width: resp.wp(40),
                margin: EdgeInsets.only(right: resp.wp(3)),
                padding: EdgeInsets.all(resp.wp(3)),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [item['color'].withOpacity(0.8), item['color'].withOpacity(0.6)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.trending_up_rounded, color: Colors.white),
                    const Spacer(),
                    Text(
                      item['name'],
                      style: TextStyle(
                        fontSize: resp.sp(14),
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      item['count'],
                      style: TextStyle(fontSize: resp.sp(11), color: Colors.white70),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}