import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';

class ConnectivityService {
  static bool _isConnected = true;
  static final ValueNotifier<bool> isConnected = ValueNotifier<bool>(true);
  static Timer? _checkTimer;
  static List<VoidCallback> _listeners = [];

  static Future<void> init() async {
    await checkConnection();

    // Verificar cada 5 segundos
    _checkTimer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      await checkConnection();
    });
  }

  static Future<bool> checkConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      final hasConnection = result.isNotEmpty && result[0].rawAddress.isNotEmpty;

      if (_isConnected != hasConnection) {
        _isConnected = hasConnection;
        isConnected.value = hasConnection;

        // Notificar a los listeners
        for (var listener in _listeners) {
          listener();
        }
      }

      return hasConnection;
    } on SocketException catch (_) {
      if (_isConnected != false) {
        _isConnected = false;
        isConnected.value = false;

        for (var listener in _listeners) {
          listener();
        }
      }
      return false;
    }
  }

  static Future<bool> hasConnection() async {
    return await checkConnection();
  }

  static void addListener(VoidCallback listener) {
    _listeners.add(listener);
  }

  static void removeListener(VoidCallback listener) {
    _listeners.remove(listener);
  }

  static void dispose() {
    _checkTimer?.cancel();
    isConnected.dispose();
    _listeners.clear();
  }
}