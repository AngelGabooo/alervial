import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';

class RiskBottomSheet extends StatelessWidget {
  const RiskBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return DraggableScrollableSheet(
      initialChildSize: 0.28,
      minChildSize: 0.2,
      maxChildSize: 0.45,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: resp.hp(1)),
                width: resp.wp(12),
                height: 4,
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[600] : Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: EdgeInsets.all(resp.wp(4)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildStatItem(context, '42', 'Incidencias', Icons.report_problem_rounded, Colors.red),
                          _buildStatItem(context, '8', 'Zona crítica', Icons.warning_rounded, Colors.orange),
                          _buildStatItem(context, 'Bache', 'Más común', Icons.circle_outlined, AppColors.blueBright),
                        ],
                      ),
                      SizedBox(height: resp.hp(2)),
                      Container(
                        padding: EdgeInsets.all(resp.wp(3)),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.location_on_rounded, color: Colors.red),
                            SizedBox(width: resp.wp(3)),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Zona más afectada',
                                    style: TextStyle(fontSize: resp.sp(12), color: Colors.grey),
                                  ),
                                  Text(
                                    'Av. Central - Zona Centro',
                                    style: TextStyle(
                                      fontSize: resp.sp(14),
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text('+12 reportes', style: TextStyle(fontSize: resp.sp(12), color: Colors.red)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatItem(BuildContext context, String value, String label, IconData icon, Color color) {
    final resp = context.resp;
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(resp.wp(2)),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: resp.iconSize(20), color: color),
        ),
        SizedBox(height: resp.hp(0.5)),
        Text(
          value,
          style: TextStyle(fontSize: resp.sp(18), fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: TextStyle(fontSize: resp.sp(11), color: Colors.grey),
        ),
      ],
    );
  }
}