import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';

class RecommendationsSection extends StatelessWidget {
  const RecommendationsSection({super.key});

  final List<Map<String, dynamic>> _recommendations = const [
    {
      'title': 'Evita carretera Tuxtla - San Cristóbal',
      'reason': 'Derrumbe reportado a la altura del km 12',
      'icon': Icons.warning_rounded,
      'color': Colors.red,
    },
    {
      'title': 'Toma vía alterna por Libramiento Sur',
      'reason': 'Tráfico denso por inundación en Calle 5',
      'icon': Icons.alt_route_rounded,
      'color': Colors.orange,
    },
    {
      'title': 'Precaución por lluvias intensas',
      'reason': 'Riesgo de inundaciones en zonas bajas',
      'icon': Icons.beach_access_rounded,
      'color': Colors.blue,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: resp.hp(2)),
        Text(
          'Recomendaciones',
          style: TextStyle(
            fontSize: resp.sp(18),
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        SizedBox(height: resp.hp(1.5)),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _recommendations.length,
          itemBuilder: (context, index) {
            final rec = _recommendations[index];
            return Container(
              margin: EdgeInsets.only(bottom: resp.hp(1.5)),
              padding: EdgeInsets.all(resp.wp(3)),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: (rec['color'] as Color).withOpacity(0.3),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(resp.wp(2)),
                    decoration: BoxDecoration(
                      color: (rec['color'] as Color).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(rec['icon'], color: rec['color'], size: resp.iconSize(20)),
                  ),
                  SizedBox(width: resp.wp(3)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          rec['title'],
                          style: TextStyle(
                            fontSize: resp.sp(14),
                            fontWeight: FontWeight.w600,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                        SizedBox(height: resp.hp(0.5)),
                        Text(
                          rec['reason'],
                          style: TextStyle(
                            fontSize: resp.sp(12),
                            color: isDark ? Colors.grey[400] : Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.chevron_right_rounded, color: Colors.grey),
                    onPressed: () {},
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}