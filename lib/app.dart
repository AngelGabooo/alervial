import 'package:flutter/material.dart';
import 'package:viatux/routes/app_routes.dart';
import 'core/themes/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AlertaVial Chiapas',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system, // Detecta automáticamente el tema del sistema
      initialRoute: AppRoutes.splash,
      routes: AppRoutes.routes,
    );
  }
}