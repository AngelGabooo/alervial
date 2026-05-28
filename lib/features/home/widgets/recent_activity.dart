import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/services/report_storage_service.dart';
import 'package:viatux/core/utils/responsive.dart';

class RecentActivity extends StatelessWidget {
  final VoidCallback onViewAll;
  final VoidCallback onActivityTap;

  const RecentActivity({
    super.key,
    required this.onViewAll,
    required this.onActivityTap,
  });

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final reports = ReportStorageService().getRecentActivity(3);

    return Padding(
      padding: resp.padding(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tu actividad reciente',
                style: TextStyle(
                  fontSize: resp.sp(18),
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
              TextButton(
                onPressed: onViewAll,
                child: Text(
                  'Ver historial',
                  style: TextStyle(
                    color: AppColors.blueBright,
                    fontSize: resp.sp(13),
                  ),
                ),
              ),
            ],
          ),
          resp.sizedBox(height: 12),
          if (reports.isEmpty)
            _buildEmptyState(context)
          else
            GestureDetector(
              onTap: onActivityTap,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: reports.length,
                itemBuilder: (context, index) {
                  final report = reports[index];
                  return _buildActivityCard(context, report);
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: resp.padding(all: 32),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: resp.radius(16),
      ),
      child: Column(
        children: [
          Icon(Icons.history_rounded, size: resp.iconSize(48), color: Colors.grey),
          resp.sizedBox(height: 12),
          Text(
            'No hay actividad reciente',
            style: TextStyle(
              fontSize: resp.sp(14),
              color: isDark ? Colors.grey[400] : Colors.grey[600],
            ),
          ),
          resp.sizedBox(height: 8),
          Text(
            'Tus reportes aparecerán aquí',
            style: TextStyle(
              fontSize: resp.sp(12),
              color: isDark ? Colors.grey[500] : Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityCard(BuildContext context, Report report) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final statusColor = report.status == 'Pendiente'
        ? Colors.orange
        : (report.status == 'En proceso' ? Colors.blue : AppColors.softGreen);
    final icon = report.status == 'Pendiente'
        ? Icons.report_problem_rounded
        : (report.status == 'En proceso' ? Icons.engineering_rounded : Icons.check_circle_rounded);

    return Container(
      margin: resp.padding(bottom: 12),
      padding: resp.padding(all: 16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: resp.radius(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: resp.padding(all: 10),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: resp.iconSize(20), color: statusColor),
          ),
          resp.sizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  report.title,
                  style: TextStyle(
                    fontSize: resp.sp(14),
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                resp.sizedBox(height: 4),
                Text(
                  report.location,
                  style: TextStyle(
                    fontSize: resp.sp(12),
                    color: isDark ? Colors.grey[500] : Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: resp.padding(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: resp.radius(12),
                ),
                child: Text(
                  report.status,
                  style: TextStyle(
                    fontSize: resp.sp(10),
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              resp.sizedBox(height: 4),
              Text(
                '${report.date}',
                style: TextStyle(
                  fontSize: resp.sp(10),
                  color: isDark ? Colors.grey[500] : Colors.grey[600],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}