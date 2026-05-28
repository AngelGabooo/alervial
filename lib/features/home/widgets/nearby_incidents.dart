import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';

class NearbyIncidents extends StatelessWidget {
  final VoidCallback onViewAll;
  final Function(Map<String, dynamic>) onIncidentTap;

  const NearbyIncidents({
    super.key,
    required this.onViewAll,
    required this.onIncidentTap,
  });

  final List<Map<String, dynamic>> _incidents = const [
    {
      'title': 'Bache en Av. Central',
      'type': 'Bache',
      'distance': '500 m',
      'status': 'Pendiente',
      'risk': 'Alto',
      'icon': Icons.circle_outlined,
      'color': Colors.red,
    },
    {
      'title': 'Inundación en Calle 5',
      'type': 'Inundación',
      'distance': '1.2 km',
      'status': 'En proceso',
      'risk': 'Crítico',
      'icon': Icons.water_drop_outlined,
      'color': Colors.blue,
    },
    {
      'title': 'Derrrumbe carretera',
      'type': 'Derrumbe',
      'distance': '2.5 km',
      'status': 'Resuelto',
      'risk': 'Moderado',
      'icon': Icons.landslide_outlined,
      'color': Colors.orange,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: resp.padding(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          resp.sizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Incidencias cercanas',
                style: TextStyle(
                  fontSize: resp.sp(18),
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: onViewAll,
                child: Text(
                  'Ver todas',
                  style: TextStyle(
                    color: AppColors.blueBright,
                    fontSize: resp.sp(13),
                  ),
                ),
              ),
            ],
          ),
          resp.sizedBox(height: 12),
          SizedBox(
            height: resp.hp(28),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: _incidents.length,
              itemBuilder: (context, index) {
                final incident = _incidents[index];
                return GestureDetector(
                  onTap: () => onIncidentTap(incident),
                  child: Container(
                    width: resp.wp(70),
                    margin: resp.padding(right: 16),
                    padding: resp.padding(all: 16),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                      borderRadius: resp.radius(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: resp.padding(all: 6),
                              decoration: BoxDecoration(
                                color: (incident['color'] as Color).withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                incident['icon'],
                                size: resp.iconSize(18),
                                color: incident['color'],
                              ),
                            ),
                            resp.sizedBox(width: 8),
                            Expanded(
                              child: Text(
                                incident['title'],
                                style: TextStyle(
                                  fontSize: resp.sp(14),
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        resp.sizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.location_on_rounded, size: resp.iconSize(12), color: Colors.grey),
                            resp.sizedBox(width: 4),
                            Text(
                              incident['distance'],
                              style: TextStyle(fontSize: resp.sp(11), color: Colors.grey),
                            ),
                            const Spacer(),
                            Container(
                              padding: resp.padding(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: (incident['color'] as Color).withOpacity(0.1),
                                borderRadius: resp.radius(12),
                              ),
                              child: Text(
                                incident['risk'],
                                style: TextStyle(
                                  fontSize: resp.sp(10),
                                  color: incident['color'],
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        resp.sizedBox(height: 8),
                        Container(
                          padding: resp.padding(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.softGreen.withOpacity(0.1),
                            borderRadius: resp.radius(12),
                          ),
                          child: Text(
                            incident['status'],
                            style: TextStyle(
                              fontSize: resp.sp(10),
                              color: AppColors.softGreen,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}