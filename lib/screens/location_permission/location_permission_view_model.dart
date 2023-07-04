import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart' hide LocationPermission;
import 'package:permission_handler/permission_handler.dart';
import '../../localization/app_translations.dart';
import './location_permission.dart';

abstract class LocationPermissionViewModel extends State<LocationPermission> {
  late List<Map<String, dynamic>> policyText;

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

  @override
  void initState() {
    policyText = [
      {"title": true, "value": AppTranslations.of(context)!.text("policy_1")},
      {"title": false, "value": AppTranslations.of(context)!.text("policy_2")},
      {"title": false, "value": AppTranslations.of(context)!.text("policy_3")},
    ];
    super.initState();
  }
}
