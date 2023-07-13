import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:latlong2/latlong.dart' show LatLng;
import 'package:flutter_map/flutter_map.dart';

import '../../../../../constants/general_const.dart';
import '../../../../../helpers/helpers.dart';

class ReservationMap extends StatefulWidget {
  const ReservationMap(
      {super.key, required this.latLng, required this.onOpenDirection});
  final LatLng latLng;
  final void Function() onOpenDirection;

  @override
  State<ReservationMap> createState() => _ReservationMapState();
}

class _ReservationMapState extends State<ReservationMap> {
  MapController mapController = MapController();
  LatLng initLatLng = const LatLng(-8.1727817, 114.3855937);

  bool mapReady = false;

  void toggleMapReady(bool value) {
    setState(() {
      mapReady = value;
    });
  }

  void onMapReady() {
    toggleMapReady(true);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            margin: const EdgeInsets.only(top: 16),
            height: 120,
            width: double.maxFinite,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(width: 1, color: ColorsCustom.border)),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: FlutterMap(
                  mapController: mapController,
                  options: MapOptions(
                    rotationWinGestures: MultiFingerGesture.none,
                    onMapReady: onMapReady,
                    center: mapReady ? widget.latLng : initLatLng,
                    minZoom: 1,
                    zoom: 18,
                    interactiveFlags:
                        InteractiveFlag.pinchZoom | InteractiveFlag.drag,
                  ),
                  children: [
                    TileLayer(
                      backgroundColor: Colors.transparent,
                      maxNativeZoom: 19,
                      maxZoom: 30,
                      urlTemplate: GeneralConstants.gmapLayer,
                      subdomains: const ['mt0', 'mt1', 'mt2', 'mt3'],
                    ),
                    Container(
                      color: ColorsCustom.black.withOpacity(0.2),
                      height: 175,
                      width: double.infinity,
                    ),
                  ],
                ))),
        Container(
          height: 120,
          width: double.maxFinite,
          color: Colors.transparent,
        ),
      ],
    );
  }
}
