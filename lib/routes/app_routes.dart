import 'package:flutter/material.dart';

import '../features/login/pages/login_page.dart';
import '../features/onboarding/pages/onboarding_page.dart';
import '../features/register/pages/register_page.dart';
import '../features/role_selection/pages/role_selection_page.dart';
import '../features/splash/pages/splash_page.dart';
import '../features/welcome/pages/welcome_page.dart';

class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String roleSelection = '/role-selection';
  static const String welcome = '/welcome';
  static const String register = '/register';
  static const String login = '/login';

  static Map<String, WidgetBuilder> get routes {
    return {
      splash: (context) => const SplashPage(),
      onboarding: (context) => const OnboardingPage(),
      roleSelection: (context) => const RoleSelectionPage(),
      welcome: (context) => const WelcomePage(),
      register: (context) => const RegisterPage(),
      login: (context) => const LoginPage(),
    };
  }
}