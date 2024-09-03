import 'dart:io';

import 'package:location/location.dart';

class LocationProvider {
  final Location _location = Location();

  late LocationData locationData;

  LocationProvider() {
    askServicesEnabled();
    askPermission();
    getLocationData();
  }

  Future<bool?> askServicesEnabled() async {
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        exit(0);
      }
    }
    return null;
  }

  Future<PermissionStatus?> askPermission() async {
    PermissionStatus permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        exit(0);
      }
    }
    return null;
  }

  Future<void> getLocationData() async {
    locationData = await _location.getLocation();
  }
}
