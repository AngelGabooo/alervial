import 'package:flutter/material.dart';
import 'package:viatux/app.dart';
import 'package:viatux/core/services/connectivity_service.dart';
import 'package:viatux/core/services/screenshot_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar servicios
  ScreenshotService.register();
  await ConnectivityService.init();

  runApp(const App());
}