import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';
import '../widgets/alert_header.dart';
import '../widgets/critical_alert_card.dart';
import '../widgets/alert_list_card.dart';
import '../widgets/alert_mini_map.dart';
import '../widgets/recommendations_section.dart';

class SmartAlertsPage extends StatefulWidget {
  const SmartAlertsPage({super.key});

  @override
  State<SmartAlertsPage> createState() => _SmartAlertsPageState();
}

class _SmartAlertsPageState extends State<SmartAlertsPage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.grey[100],
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _onRefresh,
        color: AppColors.blueBright,
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: AlertHeader()),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: resp.wp(5)),
                child: const CriticalAlertCard(),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: resp.wp(5)),
                child: const AlertMiniMap(),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: resp.wp(5)),
                child: Row(
                  children: [
                    Text(
                      'Alertas cercanas',
                      style: TextStyle(
                        fontSize: resp.sp(18),
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Ver todas',
                        style: TextStyle(color: AppColors.blueBright),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) => const AlertListCard(),
                childCount: 4,
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: resp.wp(5)),
                child: const RecommendationsSection(),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: resp.hp(10))),
          ],
        ),
      ),
    );
  }
}