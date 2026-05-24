import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class ScreenshotService {
  static const MethodChannel _channel = MethodChannel('screenshot_channel');
  static bool _isSecureModeEnabled = false;
  static VoidCallback? _onScreenshotTaken;

  // Registrar el callback para recibir eventos de Android
  static void register() {
    _channel.setMethodCallHandler((call) async {
      if (call.method == 'screenshot_taken') {
        debugPrint('📸 Screenshot detected from native!');
        _onScreenshotTaken?.call();
      }
      return null;
    });
  }

  static Future<void> disableScreenshots({VoidCallback? onScreenshotTaken}) async {
    if (_isSecureModeEnabled) return;

    try {
      _onScreenshotTaken = onScreenshotTaken;
      await _channel.invokeMethod('disableScreenshots');
      _isSecureModeEnabled = true;
      debugPrint('✅ Screenshots blocked');
    } catch (e) {
      debugPrint('Error blocking screenshots: $e');
    }
  }

  static Future<void> enableScreenshots() async {
    if (!_isSecureModeEnabled) return;

    try {
      await _channel.invokeMethod('enableScreenshots');
      _isSecureModeEnabled = false;
      _onScreenshotTaken = null;
      debugPrint('✅ Screenshots enabled');
    } catch (e) {
      debugPrint('Error enabling screenshots: $e');
    }
  }
}