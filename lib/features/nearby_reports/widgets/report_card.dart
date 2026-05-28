import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';

class ReportCard extends StatelessWidget {
  const ReportCard({super.key});

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: EdgeInsets.only(bottom: resp.hp(2)),
      padding: EdgeInsets.all(resp.wp(3)),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Imagen
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              width: resp.wp(25),
              height: resp.wp(25),
              color: Colors.grey[300],
              child: Icon(Icons.image_outlined, size: resp.iconSize(30), color: Colors.grey[500]),
            ),
          ),
          SizedBox(width: resp.wp(4)),
          // Contenido
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _buildCategoryBadge(context, 'Bache', Colors.orange),
                    const Spacer(),
                    _buildRiskBadge(context, 'Crítico', Colors.red),
                  ],
                ),
                SizedBox(height: resp.hp(0.8)),
                Text(
                  'Bache profundo en Av. Central',
                  style: TextStyle(
                    fontSize: resp.sp(15),
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: resp.hp(0.5)),
                Row(
                  children: [
                    Icon(Icons.location_on_rounded, size: resp.iconSize(14), color: Colors.grey),
                    SizedBox(width: resp.wp(1)),
                    Text('A 250 metros', style: TextStyle(fontSize: resp.sp(12), color: Colors.grey)),
                    SizedBox(width: resp.wp(4)),
                    Icon(Icons.access_time_rounded, size: resp.iconSize(14), color: Colors.grey),
                    SizedBox(width: resp.wp(1)),
                    Text('Hace 2 horas', style: TextStyle(fontSize: resp.sp(12), color: Colors.grey)),
                  ],
                ),
                SizedBox(height: resp.hp(0.8)),
                _buildStatusBadge(context, 'Pendiente'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryBadge(BuildContext context, String text, Color color) {
    final resp = context.resp;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: resp.wp(2), vertical: resp.hp(0.3)),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: resp.sp(11), color: color, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _buildRiskBadge(BuildContext context, String text, Color color) {
    final resp = context.resp;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: resp.wp(2), vertical: resp.hp(0.3)),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.warning_rounded, size: resp.iconSize(12), color: color),
          SizedBox(width: resp.wp(1)),
          Text(text, style: TextStyle(fontSize: resp.sp(11), color: color, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(BuildContext context, String status) {
    final resp = context.resp;
    Color color;
    if (status == 'Pendiente') color = Colors.orange;
    else if (status == 'En proceso') color = Colors.blue;
    else color = AppColors.softGreen;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: resp.wp(2.5), vertical: resp.hp(0.4)),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        status,
        style: TextStyle(fontSize: resp.sp(11), color: color, fontWeight: FontWeight.w500),
      ),
    );
  }
}