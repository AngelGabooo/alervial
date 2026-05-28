import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';
import '../widgets/feed_header.dart';
import '../widgets/featured_card.dart';
import '../widgets/feed_filters.dart';
import '../widgets/activity_card.dart';
import '../widgets/trending_section.dart';

class RecentActivityFeedPage extends StatefulWidget {
  const RecentActivityFeedPage({super.key});

  @override
  State<RecentActivityFeedPage> createState() => _RecentActivityFeedPageState();
}

class _RecentActivityFeedPageState extends State<RecentActivityFeedPage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();
  String _selectedFilter = 'Todos';

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
            const SliverToBoxAdapter(child: FeedHeader()),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: resp.wp(5)),
                child: const FeaturedCard(),
              ),
            ),
            SliverToBoxAdapter(
              child: FeedFilters(
                selectedFilter: _selectedFilter,
                onFilterSelected: (filter) {
                  setState(() => _selectedFilter = filter);
                },
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) => const ActivityCard(),
                childCount: 5,
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: resp.wp(5)),
                child: const TrendingSection(),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: resp.hp(10))),
          ],
        ),
      ),
    );
  }
}