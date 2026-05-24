import 'package:flutter/material.dart';
import 'package:viatux/app.dart';
import 'package:viatux/core/services/screenshot_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ScreenshotService.register(); // 👈 Registrar el servicio
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const App();
  }
}