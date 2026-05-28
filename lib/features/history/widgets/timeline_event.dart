import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/services/report_storage_service.dart';
import 'package:viatux/core/utils/responsive.dart';

class TimelineEvent extends StatelessWidget {
  final Report report;
  final String eventType;

  const TimelineEvent({super.key, required this.report, required this.eventType});

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    String title;
    IconData icon;
    Color color;

    switch (eventType) {
      case 'created':
        title = 'Reporte creado';
        icon = Icons.send_rounded;
        color = AppColors.blueBright;
        break;
      case 'updated':
        title = 'Estado actualizado a ${report.status}';
        icon = Icons.update_rounded;
        color = Colors.orange;
        break;
      case 'resolved':
        title = 'Reporte resuelto';
        icon = Icons.check_circle_rounded;
        color = AppColors.softGreen;
        break;
      default:
        title = 'Actividad registrada';
        icon = Icons.history_rounded;
        color = Colors.grey;
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: resp.wp(5), vertical: resp.hp(0.5)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.all(resp.wp(2)),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: resp.iconSize(20), color: color),
              ),
              Container(
                width: 2,
                height: resp.hp(8),
                color: isDark ? Colors.grey[800] : Colors.grey[200],
              ),
            ],
          ),
          SizedBox(width: resp.wp(3)),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: resp.hp(2)),
              padding: EdgeInsets.all(resp.wp(3)),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: resp.wp(2),
                          vertical: resp.hp(0.3),
                        ),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: resp.sp(11),
                            color: color,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        report.date,
                        style: TextStyle(
                          fontSize: resp.sp(11),
                          color: isDark ? Colors.grey[500] : Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: resp.hp(1)),
                  Text(
                    report.title,
                    style: TextStyle(
                      fontSize: resp.sp(14),
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  SizedBox(height: resp.hp(0.5)),
                  Text(
                    report.description,
                    style: TextStyle(
                      fontSize: resp.sp(12),
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}