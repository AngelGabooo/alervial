import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';
import 'package:viatux/routes/app_routes.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/home_header.dart';
import '../widgets/stats_card.dart';
import '../widgets/nearby_incidents.dart';
import '../widgets/mini_map.dart';
import '../widgets/recent_activity.dart';
import '../widgets/quick_actions_grid.dart';
import 'package:viatux/features/interactive_map/pages/interactive_map_page.dart';
import 'package:viatux/features/nearby_reports/pages/nearby_reports_page.dart';
import 'package:viatux/features/risk_zones/pages/risk_zones_page.dart';
import 'package:viatux/features/create_report/pages/create_report_page.dart';
import 'package:viatux/features/my_reports/pages/my_reports_page.dart';
import 'package:viatux/features/comments_evidences/pages/comments_evidences_page.dart';
import 'package:viatux/features/history/pages/history_page.dart';
import 'package:viatux/features/recent_activity_feed/pages/recent_activity_feed_page.dart';
import 'package:viatux/features/notifications/pages/notifications_page.dart';
import 'package:viatux/features/smart_alerts/pages/smart_alerts_page.dart';
import 'package:viatux/features/personal_stats/pages/personal_stats_page.dart';
import 'package:viatux/features/gamification/pages/gamification_page.dart';
import 'package:viatux/features/favorites/pages/favorites_page.dart';
import 'package:viatux/features/intelligent_search/pages/intelligent_search_page.dart';
import 'package:viatux/features/profile/pages/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {});
  }

  void _onBottomNavTap(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        break;
      case 1:
      // ✅ CORREGIDO: Ahora navega al mapa interactivo original
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const InteractiveMapPage()),
        ).then((_) => setState(() => _currentIndex = 0));
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CreateReportPage()),
        ).then((_) => setState(() => _currentIndex = 0));
        break;
      case 3:
        Navigator.pushNamed(context, AppRoutes.favorites).then((_) {
          setState(() => _currentIndex = 0);
        });
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfilePage()),
        ).then((_) => setState(() => _currentIndex = 0));
        break;
    }
  }

  void _navigateToIntelligentSearch() {
    Navigator.pushNamed(context, AppRoutes.intelligentSearch);
  }

  void _navigateToPersonalStats() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PersonalStatsPage()),
    );
  }

  void _navigateToGamification() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const GamificationPage()),
    );
  }

  void _navigateToRiskZones() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RiskZonesPage()),
    );
  }

  void _navigateToCommentsEvidences() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CommentsEvidencesPage()),
    );
  }

  void _navigateToMyReports() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MyReportsPage()),
    );
  }

  void _navigateToHistory() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HistoryPage()),
    );
  }

  void _navigateToRecentActivity() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RecentActivityFeedPage()),
    );
  }

  void _navigateToNotifications() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NotificationsPage()),
    );
  }

  void _navigateToSmartAlerts() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SmartAlertsPage()),
    );
  }

  void _navigateToProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProfilePage()),
    );
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
        backgroundColor: isDark ? AppColors.darkSurface : Colors.white,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              HomeHeader(
                userName: 'Ángel',
                onNotificationTap: _navigateToNotifications,
                onProfileTap: _navigateToProfile,
                onSearchTap: _navigateToIntelligentSearch,
              ),
              GestureDetector(
                onTap: _navigateToPersonalStats,
                child: const StatsCard(),
              ),
              QuickActionsGrid(
                onHistoryTap: _navigateToHistory,
                onRecentActivityTap: _navigateToRecentActivity,
                onRiskZonesTap: _navigateToRiskZones,
                onMyReportsTap: _navigateToMyReports,
                onGamificationTap: _navigateToGamification,
                onPersonalStatsTap: _navigateToPersonalStats,
              ),
              NearbyIncidents(
                onViewAll: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const NearbyReportsPage()),
                  );
                },
                onIncidentTap: (incident) {
                  _navigateToCommentsEvidences();
                },
              ),
              MiniMap(
                onViewMap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const InteractiveMapPage()),
                  );
                },
              ),
              RecentActivity(
                onViewAll: _navigateToHistory,
                onActivityTap: _navigateToRecentActivity,
              ),
              resp.sizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onBottomNavTap,
      ),
    );
  }
}