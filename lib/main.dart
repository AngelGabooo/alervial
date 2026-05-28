import 'package:flutter/material.dart';
import 'package:viatux/app.dart';
import 'package:viatux/core/services/screenshot_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  ScreenshotService.register();

  runApp(const App());
}