import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/services/report_storage_service.dart';
import 'package:viatux/core/utils/responsive.dart';
import 'package:viatux/routes/app_routes.dart';

class ReportListCard extends StatelessWidget {
  final Report report;

  const ReportListCard({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final statusColor = report.status == 'Pendiente'
        ? Colors.orange
        : (report.status == 'En proceso' ? Colors.blue : AppColors.softGreen);

    final categoryColor = _getCategoryColor(report.category);

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.reportDetail);
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(
          resp.wp(5),
          resp.hp(0.5),
          resp.wp(5),
          resp.hp(0.5),
        ),
        padding: EdgeInsets.all(resp.wp(3)),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                width: resp.wp(20),
                height: resp.wp(20),
                color: isDark ? Colors.grey[800] : Colors.grey[200],
                child: Icon(Icons.image_outlined, color: Colors.grey[500]),
              ),
            ),
            SizedBox(width: resp.wp(4)),
            Expanded(
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
                          color: categoryColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          report.category,
                          style: TextStyle(
                            fontSize: resp.sp(11),
                            color: categoryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        report.folio,
                        style: TextStyle(
                          fontSize: resp.sp(10),
                          color: isDark ? Colors.grey[500] : Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: resp.hp(0.5)),
                  Text(
                    report.title,
                    style: TextStyle(
                      fontSize: resp.sp(14),
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: resp.hp(0.5)),
                  Row(
                    children: [
                      Icon(Icons.location_on_rounded,
                          size: resp.iconSize(12), color: Colors.grey),
                      SizedBox(width: resp.wp(1)),
                      Expanded(
                        child: Text(
                          report.location,
                          style: TextStyle(
                            fontSize: resp.sp(11),
                            color: Colors.grey,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: resp.hp(0.5)),
                  Row(
                    children: [
                      Icon(Icons.access_time_rounded,
                          size: resp.iconSize(12), color: Colors.grey),
                      SizedBox(width: resp.wp(1)),
                      Text(
                        report.date,
                        style: TextStyle(fontSize: resp.sp(11), color: Colors.grey),
                      ),
                      const Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: resp.wp(2),
                          vertical: resp.hp(0.3),
                        ),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          report.status,
                          style: TextStyle(
                            fontSize: resp.sp(10),
                            color: statusColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Bache':
        return Colors.orange;
      case 'Derrumbe':
        return Colors.brown;
      case 'Inundación':
        return Colors.blue;
      case 'Señalización':
        return Colors.purple;
      case 'Accidente':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}