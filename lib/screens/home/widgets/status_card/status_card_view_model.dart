import 'dart:async';

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:latlong2/latlong.dart' show LatLng;
import 'package:grid_mobile/constants/enum/status_enum.dart';
import 'package:grid_mobile/helpers/helpers.dart';
import '../../../../localization/app_translations.dart';
import './status_card.dart';

abstract class StatusCardViewModel extends State<StatusCard> {
  bool isShow = false;
  bool isStop = false;

  ChargingStatus status = ChargingStatus.reserved;

  double progress = 0.0;
  double minHeightShow = 400;
  double minHeightHide = 130;

  double totalPower = 20.0;
  double currentPower = 0.0;

  LatLng reservedLocation = const LatLng(-8.1727817, 114.3855937);

  String statusText = "";
  String statusDetailText = "";
  String location = "Mirah Hotel Banyuwangi";
  String slot = "BASEMENT 1 - A15";

  DateTime expiredIn = DateTime.now().add(const Duration(hours: 2));

  IconData statusDetailIcon = Icons.ev_station_outlined;

  Color statusBgColor = ColorsCustom.black;
  Color statusIconColor = ColorsCustom.black;

  void toggleIsShow() {
    setState(() {
      isShow = !isShow;
    });
  }

  void toggleIsStop() {
    setState(() {
      isStop = !isStop;
      minHeightShow -= 45;
    });
  }

  void setProgress(double value) {
    setState(() {
      progress = value;
    });
  }

  void onClaimSlot() {
    debugPrint("Claim success!");
  }

  void onOpenDirection() {
    debugPrint("Direction opened!");
  }

  void onStartCharging() {
    debugPrint("Start Charging");
  }

  void renderStatusDetail(String value, IconData icon) {
    setState(() {
      statusDetailText = value;
      statusDetailIcon = icon;
    });
  }

  void renderStatus() {
    setState(() {
      switch (status) {
        case ChargingStatus.process:
          statusText =
              AppTranslations.of(context)!.text("charging_in_progress");
          statusBgColor = ColorsCustom.blue;
          statusIconColor = ColorsCustom.blue;

          // dummy
          renderStatusDetail(AppTranslations.of(context)!.text("connected"),
              Icons.ev_station_outlined);

        case ChargingStatus.interupted:
          statusText = AppTranslations.of(context)!.text("interupted");
          statusBgColor = ColorsCustom.pomegrande;
          statusIconColor = ColorsCustom.sunflower;

          // dummy
          renderStatusDetail(AppTranslations.of(context)!.text("unplugged"),
              Icons.cable_outlined);

        case ChargingStatus.reserved:
          statusText = AppTranslations.of(context)!.text("reserved");
          statusBgColor = ColorsCustom.wisteria;
          statusIconColor = ColorsCustom.wisteria;

        case ChargingStatus.ready:
          statusText = AppTranslations.of(context)!.text("ready_to_charge");
          statusBgColor = ColorsCustom.green;
          statusIconColor = ColorsCustom.green;

        default:
          statusText = '';
      }
    });
  }

  @override
  void initState() {
    super.initState();

    Timer.periodic(const Duration(seconds: 1), (timer) {
      renderStatus();
      if (mounted) {
        setState(() {
          if (progress < 100 && status == ChargingStatus.process) {
            progress += 4;
            currentPower += 0.8;
          }
        });
      }
    });
  }
}
