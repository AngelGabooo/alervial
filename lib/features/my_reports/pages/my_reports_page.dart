import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/services/report_storage_service.dart';
import 'package:viatux/core/utils/responsive.dart';
import 'package:viatux/routes/app_routes.dart';
import '../widgets/reports_header.dart';
import '../widgets/report_summary_card.dart';
import '../widgets/filter_chips_reports.dart';
import '../widgets/report_list_card.dart';
import '../widgets/empty_reports_state.dart';
import '../widgets/report_search_bar.dart';

class MyReportsPage extends StatefulWidget {
  const MyReportsPage({super.key});

  @override
  State<MyReportsPage> createState() => _MyReportsPageState();
}

class _MyReportsPageState extends State<MyReportsPage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();
  String _selectedFilter = 'Todos';
  String _selectedCategory = 'Todas';
  String _searchQuery = '';
  bool _hasReports = true;

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
            const SliverToBoxAdapter(child: ReportsHeader()),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: resp.wp(5)),
                child: ReportSearchBar(
                  onSearch: (query) {
                    setState(() => _searchQuery = query);
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: resp.wp(5)),
                child: const ReportSummaryCard(),
              ),
            ),
            SliverToBoxAdapter(
              child: FilterChipsReports(
                selectedFilter: _selectedFilter,
                selectedCategory: _selectedCategory,
                onFilterSelected: (filter) {
                  setState(() => _selectedFilter = filter);
                },
                onCategorySelected: (category) {
                  setState(() => _selectedCategory = category);
                },
              ),
            ),
            if (_hasReports)
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    final filteredReports = ReportStorageService().getReportsByFilter(
                      status: _selectedFilter,
                      category: _selectedCategory,
                      searchQuery: _searchQuery,
                    );
                    if (index >= filteredReports.length) return null;
                    return ReportListCard(report: filteredReports[index]);
                  },
                  childCount: ReportStorageService().getReportsByFilter(
                    status: _selectedFilter,
                    category: _selectedCategory,
                    searchQuery: _searchQuery,
                  ).length,
                ),
              )
            else
              SliverToBoxAdapter(
                child: EmptyReportsState(
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