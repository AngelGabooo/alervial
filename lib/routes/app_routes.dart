import 'package:flutter/material.dart';
import '../features/splash/pages/splash_page.dart';
import '../features/onboarding/pages/onboarding_page.dart';
import '../features/role_selection/pages/role_selection_page.dart';
import '../features/welcome/pages/welcome_page.dart';
import '../features/register/pages/register_page.dart';
import '../features/login/pages/login_page.dart';
import '../features/forgot_password/pages/forgot_password_page.dart';
import '../features/home/pages/home_page.dart';
import '../features/nearby_reports/pages/nearby_reports_page.dart';
import '../features/interactive_map/pages/interactive_map_page.dart';
import '../features/risk_zones/pages/risk_zones_page.dart';
import '../features/create_report/pages/create_report_page.dart';
import '../features/report_success/pages/report_success_page.dart';
import '../features/report_detail/pages/report_detail_page.dart';
import '../features/comments_evidences/pages/comments_evidences_page.dart';
import '../features/my_reports/pages/my_reports_page.dart';
import '../features/history/pages/history_page.dart';
import '../features/recent_activity_feed/pages/recent_activity_feed_page.dart';
import '../features/notifications/pages/notifications_page.dart';
import '../features/smart_alerts/pages/smart_alerts_page.dart';

class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String roleSelection = '/role-selection';
  static const String welcome = '/welcome';
  static const String register = '/register';
  static const String login = '/login';
  static const String forgotPassword = '/forgot-password';
  static const String home = '/home';
  static const String nearbyReports = '/nearby-reports';
  static const String interactiveMap = '/interactive-map';
  static const String riskZones = '/risk-zones';
  static const String createReport = '/create-report';
  static const String reportSuccess = '/report-success';
  static const String reportDetail = '/report-detail';
  static const String commentsEvidences = '/comments-evidences';
  static const String myReports = '/my-reports';
  static const String history = '/history';
  static const String recentActivityFeed = '/recent-activity-feed';
  static const String notifications = '/notifications';
  static const String smartAlerts = '/smart-alerts';

  static Map<String, WidgetBuilder> get routes {
    return {
      splash: (context) => const SplashPage(),
      onboarding: (context) => const OnboardingPage(),
      roleSelection: (context) => const RoleSelectionPage(),
      welcome: (context) => const WelcomePage(),
      register: (context) => const RegisterPage(),
      login: (context) => const LoginPage(),
      forgotPassword: (context) => const ForgotPasswordPage(),
      home: (context) => const HomePage(),
      nearbyReports: (context) => const NearbyReportsPage(),
      interactiveMap: (context) => const InteractiveMapPage(),
      riskZones: (context) => const RiskZonesPage(),
      createReport: (context) => const CreateReportPage(),
      reportSuccess: (context) => const ReportSuccessPage(),
      reportDetail: (context) => const ReportDetailPage(),
      commentsEvidences: (context) => const CommentsEvidencesPage(),
      myReports: (context) => const MyReportsPage(),
      history: (context) => const HistoryPage(),
      recentActivityFeed: (context) => const RecentActivityFeedPage(),
      notifications: (context) => const NotificationsPage(),
      smartAlerts: (context) => const SmartAlertsPage(),
    };
  }
}