import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart' hide PermissionStatus;

class LocationService {
  static final Location _location = Location();
  static bool _isMockEnabled = false;
  static StreamSubscription<LocationData>? _locationSubscription;
  static List<VoidCallback> _listeners = [];

  static Future<bool> checkMockLocation() async {
    try {
      final serviceEnabled = await _location.serviceEnabled();
      if (!serviceEnabled) {
        _isMockEnabled = false;
        return false;
      }

      final permissionGranted = await _location.hasPermission();
      if (permissionGranted != PermissionStatus.granted) {
        _isMockEnabled = false;
        return false;
      }

      final locationData = await _location.getLocation();
      _isMockEnabled = locationData.isMock ?? false;

      return _isMockEnabled;
    } catch (e) {
      debugPrint('Error checking mock location: $e');
      return false;
    }
  }

  static void startListening(VoidCallback onMockDetected) {
    _locationSubscription = _location.onLocationChanged.listen((locationData) {
      final isMock = locationData.isMock ?? false;
      if (isMock != _isMockEnabled) {
        _isMockEnabled = isMock;
        if (isMock) {
          onMockDetected();
        }
      }
    });
  }

  static void stopListening() {
    _locationSubscription?.cancel();
    _locationSubscription = null;
  }

  static void addListener(VoidCallback listener) {
    _listeners.add(listener);
  }

  static void removeListener(VoidCallback listener) {
    _listeners.remove(listener);
  }

  static Future<bool> requestPermissions() async {
    final status = await Permission.location.request();
    return status.isGranted;
  }

  static void dispose() {
    stopListening();
    _listeners.clear();
  }
}