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

    // Navegación según el índice seleccionado
    switch (index) {
      case 0: // Inicio (ya estamos aquí)
        break;
      case 1: // Mapa
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const InteractiveMapPage(),
          ),
        ).then((_) {
          setState(() {
            _currentIndex = 0;
          });
        });
        break;
      case 2: // Reportar - Navegar a Crear Reporte
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CreateReportPage(),
          ),
        ).then((_) {
          setState(() {
            _currentIndex = 0;
          });
        });
        break;
      case 3: // Notificaciones - Navegar a Notificaciones
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const NotificationsPage(),
          ),
        ).then((_) {
          setState(() {
            _currentIndex = 0;
          });
        });
        break;
      case 4: // Perfil - Navegar a Mis Reportes
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MyReportsPage(),
          ),
        ).then((_) {
          setState(() {
            _currentIndex = 0;
          });
        });
        break;
    }
  }

  void _navigateToRiskZones() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RiskZonesPage(),
      ),
    );
  }

  void _navigateToCommentsEvidences() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CommentsEvidencesPage(),
      ),
    );
  }

  void _navigateToMyReports() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MyReportsPage(),
      ),
    );
  }

  void _navigateToHistory() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HistoryPage(),
      ),
    );
  }

  void _navigateToRecentActivity() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RecentActivityFeedPage(),
      ),
    );
  }

  void _navigateToNotifications() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const NotificationsPage(),
      ),
    );
  }

  void _navigateToSmartAlerts() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SmartAlertsPage(),
      ),
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
              // Header
              HomeHeader(
                userName: 'Ángel',
                onNotificationTap: _navigateToNotifications,
                onProfileTap: _navigateToMyReports,
              ),
              // Stats Card
              GestureDetector(
                onTap: _navigateToRiskZones,
                child: const StatsCard(),
              ),
              // Nearby Incidents
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
              // Mini Map
              MiniMap(
                onViewMap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const InteractiveMapPage()),
                  );
                },
              ),
              // Recent Activity - Con navegación a Historial y Actividad Reciente
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