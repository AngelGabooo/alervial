// lib/main.dart (Actualizado)
import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/app_colors.dart';

// Onboarding
import 'features/onboarding/presentation/screens/splash_screen.dart';
import 'features/onboarding/presentation/screens/onboarding_screen.dart';

// Auth
import 'features/auth/presentation/screens/welcome_screen.dart';
import 'features/auth/presentation/screens/role_selection_screen.dart';
import 'features/auth/presentation/screens/register_screen.dart';
import 'features/auth/presentation/screens/login_screen.dart';
import 'features/auth/presentation/screens/forgot_password_screen.dart';

// Home
import 'features/home/presentation/screens/home_screen.dart';

// Risk
import 'features/risk/presentation/screens/risk_zones_screen.dart';

// Reports
import 'features/reports/presentation/screens/create_report_screen.dart';
import 'features/reports/presentation/screens/report_success_screen.dart';
import 'features/reports/presentation/screens/report_detail_screen.dart';
import 'features/reports/presentation/screens/comments_evidences_screen.dart';
import 'features/reports/presentation/screens/my_reports_screen.dart';


void main() {
  runApp(const AlertaVialApp());
}

class AlertaVialApp extends StatelessWidget {
  const AlertaVialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AlertaVial Chiapas',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/onboarding': (context) => const OnboardingScreen(),
        '/welcome': (context) => const WelcomeScreen(),
        '/role-selection': (context) => const RoleSelectionScreen(),
        '/register': (context) => const RegisterScreen(),
        '/login': (context) => const LoginScreen(),
        '/forgot-password': (context) => const ForgotPasswordScreen(),
        '/home': (context) => const HomeScreen(),
        '/risk-zones': (context) => const RiskZonesScreen(),
        '/create-report': (context) => const CreateReportScreen(),
        // Agregar en routes:
        '/report-success': (context) {
          final args = ModalRoute.of(context)?.settings.arguments as String;
          return ReportSuccessScreen(reportId: args);
        },
        '/report-detail': (context) {
          final args = ModalRoute.of(context)?.settings.arguments as String;
          return ReportDetailScreen(reportId: args);
        },
        // Agregar en routes:
        '/comments-evidences': (context) {
          final args = ModalRoute.of(context)?.settings.arguments as String;
          return CommentsEvidencesScreen(reportId: args);
        },
        '/my-reports': (context) => const MyReportsScreen(),
      },
    );
  }
}