import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart' hide LocationPermission;
import 'package:permission_handler/permission_handler.dart';
import './location_permission.dart';

abstract class LocationPermissionViewModel extends State<LocationPermission> {
  List<Map<String, dynamic>> policyText = [
    {"title": true, "value": "Mengenai izin lokasi dalam mode belakang layar:"},
    {
      "title": false,
      "value":
          "Aplikasi Grid Mobile memiliki menu map, untuk mengetahui lokasi anda dengan EV Station Grid terdekat"
    },
    {
      "title": false,
      "value":
          "Ketika aplikasi Grid Mobile tidak digunakan, aplikasi ini tidak akan mengumpulkan lokasi Anda."
    },
  ];

  Future<void> onApproveClicked() async {
    if (await Permission.locationWhenInUse.serviceStatus.isEnabled) {
      if (await Permission.locationWhenInUse.request().isGranted) {
        PermissionStatus status = await Permission.storage.status;
        if (!status.isGranted) {
          await Permission.storage.request();
        }

        PermissionStatus statusManage =
            await Permission.manageExternalStorage.status;
        if (!statusManage.isGranted) {
          await Permission.manageExternalStorage.request();
        }

        // ignore: use_build_context_synchronously
        await Navigator.pushReplacementNamed(context, "/Landing");
      } else if (await Permission.locationWhenInUse
              .request()
              .isPermanentlyDenied ||
          await Permission.locationWhenInUse.status ==
              PermissionStatus.denied) {
        await Geolocator.requestPermission();
      } else {
        // Permission.locationWhenInUse.request();
        onApproveClicked();
      }
    } else {
      await Geolocator.openLocationSettings();
    }
  }
}
