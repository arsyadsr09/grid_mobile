import 'package:flutter/material.dart';
import 'package:grid_mobile/widgets/custom_text.dart';
// ignore: depend_on_referenced_packages
import 'package:latlong2/latlong.dart' show LatLng;
import 'package:flutter_map/flutter_map.dart';

import '../../../../../constants/general_const.dart';
import '../../../../../helpers/helpers.dart';
import '../../../../../localization/app_translations.dart';

class DirectionMap extends StatefulWidget {
  const DirectionMap(
      {super.key,
      required this.latLng,
      required this.onOpenDirection,
      required this.isShow});

  final bool isShow;
  final LatLng latLng;
  final void Function() onOpenDirection;

  @override
  State<DirectionMap> createState() => _DirectionMapState();
}

class _DirectionMapState extends State<DirectionMap> {
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
    return AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: widget.isShow ? 1 : 0,
        child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: EdgeInsets.only(top: widget.isShow ? 16 : 0),
            height: widget.isShow ? 175 : 0,
            width: double.maxFinite,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  children: [
                    FlutterMap(
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
                    ),
                    Positioned(
                        top: 8,
                        left: 8,
                        child: SizedBox(
                          height: 27,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                backgroundColor: ColorsCustom.blue),
                            onPressed: widget.onOpenDirection,
                            child:
                                Row(mainAxisSize: MainAxisSize.min, children: [
                              Icon(
                                Icons.directions,
                                size: 14,
                                color: ColorsCustom.white,
                              ),
                              const SizedBox(width: 6),
                              CustomText(
                                AppTranslations.of(context)!
                                    .text("open_direction"),
                                color: ColorsCustom.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 9,
                              ),
                            ]),
                          ),
                        )),
                  ],
                ))));
  }
}
