import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class ScreenshotDetector {
  static final ScreenshotDetector _instance = ScreenshotDetector._internal();
  factory ScreenshotDetector() => _instance;
  ScreenshotDetector._internal();

  final MethodChannel _channel = const MethodChannel('screenshot_detector');
  Timer? _debounceTimer;
  VoidCallback? _onScreenshotTaken;

  void startListening(VoidCallback onScreenshotTaken) {
    _onScreenshotTaken = onScreenshotTaken;

    _channel.setMethodCallHandler((call) async {
      if (call.method == 'screenshot_taken') {
        _onDebouncedScreenshot();
      }
    });
  }

  void _onDebouncedScreenshot() {
    if (_debounceTimer?.isActive ?? false) return;

    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      _onScreenshotTaken?.call();
    });
  }

  void stopListening() {
    _channel.setMethodCallHandler(null);
    _debounceTimer?.cancel();
    _onScreenshotTaken = null;
  }
}