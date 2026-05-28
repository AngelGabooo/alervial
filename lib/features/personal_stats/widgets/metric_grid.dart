import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';

class MetricGrid extends StatelessWidget {
  const MetricGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1.4,
      children: [
        _buildItem(context, 'Reportes enviados', '24', Icons.analytics_rounded, Colors.orange),
        _buildItem(context, 'Reportes resueltos', '18', Icons.check_circle_rounded, AppColors.softGreen),
        _buildItem(context, 'Evidencias agregadas', '42', Icons.camera_enhance_rounded, AppColors.blueBright),
        _buildItem(context, 'Participación mensual', '88%', Icons.trending_up_rounded, Colors.purple),
      ],
    );
  }

  Widget _buildItem(BuildContext context, String title, String value, IconData icon, Color color) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: resp.padding(all: 14),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: resp.radius(20),
        border: Border.all(color: isDark ? Colors.white10 : Colors.grey.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(fontSize: resp.sp(11), color: Colors.grey[500], fontWeight: FontWeight.w500),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(icon, color: color, size: resp.iconSize(18)),
            ],
          ),
          Text(value, style: TextStyle(fontSize: resp.sp(24), fontWeight: FontWeight.bold)),
          Text('Actualizado hoy', style: TextStyle(fontSize: resp.sp(10), color: Colors.grey)),
        ],
      ),
    );
  }
}