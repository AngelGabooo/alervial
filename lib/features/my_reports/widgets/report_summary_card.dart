import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/services/report_storage_service.dart';
import 'package:viatux/core/utils/responsive.dart';

class ReportSummaryCard extends StatelessWidget {
  const ReportSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final stats = ReportStorageService().getStatistics();

    return Row(
      children: [
        _buildSummaryItem(context, 'Total', stats['total'].toString(), Icons.report_problem_rounded, AppColors.blueBright),
        SizedBox(width: resp.wp(3)),
        _buildSummaryItem(context, 'Pendientes', stats['pendientes'].toString(), Icons.pending_rounded, Colors.orange),
        SizedBox(width: resp.wp(3)),
        _buildSummaryItem(context, 'En proceso', stats['enProceso'].toString(), Icons.engineering_rounded, Colors.blue),
        SizedBox(width: resp.wp(3)),
        _buildSummaryItem(context, 'Resueltos', stats['resueltos'].toString(), Icons.check_circle_rounded, AppColors.softGreen),
      ],
    );
  }

  Widget _buildSummaryItem(BuildContext context, String label, String value, IconData icon, Color color) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: resp.hp(1.5)),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(resp.wp(2)),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: resp.iconSize(20), color: color),
            ),
            SizedBox(height: resp.hp(0.8)),
            Text(
              value,
              style: TextStyle(
                fontSize: resp.sp(20),
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: resp.sp(11),
                color: isDark ? Colors.grey[500] : Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}