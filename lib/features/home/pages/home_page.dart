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

// 👉 IMPORTS CONECTADOS DIRECTAMENTE AL HOME
import 'package:viatux/features/personal_stats/pages/personal_stats_page.dart';
import 'package:viatux/features/gamification/pages/gamification_page.dart';
import 'package:viatux/features/favorites/pages/favorites_page.dart';
import 'package:viatux/features/intelligent_search/pages/intelligent_search_page.dart';

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
      case 0: // Inicio
        break;
      case 1: // Mapa 👉 AHORA REDIRIGE A TU BÚSQUEDA INTELIGENTE CON MAPA EN VIVO
        Navigator.pushNamed(
          context,
          AppRoutes.intelligentSearch,
        ).then((_) {
          setState(() {
            _currentIndex = 0;
          });
        });
        break;
      case 2: // Reportar
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
      case 3: // Alertas 👉 AHORA REDIRIGE A TU PANTALLA PREMIUM DE FAVORITOS
        Navigator.pushNamed(
          context,
          AppRoutes.favorites,
        ).then((_) {
          setState(() {
            _currentIndex = 0;
          });
        });
        break;
      case 4: // Perfil 👉 CONECTADO A TUS ESTADÍSTICAS PERSONALES PREMIUM
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PersonalStatsPage(),
          ),
        ).then((_) {
          setState(() {
            _currentIndex = 0;
          });
        });
        break;
    }
  }

  // 👉 ACCIÓN REDIRIGIDA A ESTADÍSTICAS AL TOCAR LA TARJETA PRINCIPAL
  void _navigateToPersonalStats() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PersonalStatsPage(),
      ),
    );
  }

  // 👉 FUNCIÓN PARA IR A LA PANTALLA DE GAMIFICACIÓN (LOGROS/DESAFÍOS)
  void _navigateToGamification() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const GamificationPage(),
      ),
    );
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
              // Header - Al tocar tu foto de avatar abre la Gamificación/Logros
              HomeHeader(
                userName: 'Ángel',
                onNotificationTap: _navigateToNotifications,
                onProfileTap: _navigateToGamification,
              ),

              // Stats Card - Al tocarla abre tus Estadísticas Personales Premium
              GestureDetector(
                onTap: _navigateToPersonalStats,
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

              // Recent Activity
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