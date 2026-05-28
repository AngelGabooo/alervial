import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';
import '../../../core/services/report_storage_service.dart';
import '../../../routes/app_routes.dart';
import '../widgets/history_header.dart';
import '../widgets/history_summary.dart';
import '../widgets/history_filters.dart';
import '../widgets/timeline_event.dart';
import '../widgets/stats_charts.dart';
import '../widgets/empty_history.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();

  String _selectedFilter = 'Todos';
  String _selectedCategory = 'Todas';
  String _selectedDate = 'Este mes';
  bool _hasHistory = true;

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _onRefresh,
        color: AppColors.blueBright,
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: HistoryHeader()),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: resp.wp(5)),
                child: const HistorySummary(),
              ),
            ),
            SliverToBoxAdapter(
              child: HistoryFilters(
                selectedFilter: _selectedFilter,
                selectedCategory: _selectedCategory,
                selectedDate: _selectedDate,
                onFilterSelected: (filter) {
                  setState(() => _selectedFilter = filter);
                },
                onCategorySelected: (category) {
                  setState(() => _selectedCategory = category);
                },
                onDateSelected: (date) {
                  setState(() => _selectedDate = date);
                },
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: resp.wp(5)),
                child: const StatsCharts(),
              ),
            ),
            if (_hasHistory)
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    final reports = ReportStorageService().reports;
                    if (index >= reports.length * 3) return null;

                    // Mostrar múltiples eventos por reporte
                    final reportIndex = index ~/ 3;
                    final eventTypeIndex = index % 3;

                    if (reportIndex >= reports.length) return null;

                    final report = reports[reportIndex];

                    String eventType;
                    if (eventTypeIndex == 0) eventType = 'created';
                    else if (eventTypeIndex == 1 && report.status != 'Pendiente') eventType = 'updated';
                    else if (eventTypeIndex == 2 && report.status == 'Resuelto') eventType = 'resolved';
                    else return const SizedBox.shrink();

                    return TimelineEvent(report: report, eventType: eventType);
                  },
                  childCount: ReportStorageService().reports.length * 3,
                ),
              )
            else
              SliverToBoxAdapter(
                child: EmptyHistory(
                  onCreateReport: () {
                    Navigator.pushNamed(context, AppRoutes.createReport);
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}