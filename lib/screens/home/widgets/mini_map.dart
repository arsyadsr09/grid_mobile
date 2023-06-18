import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:geolocator/geolocator.dart';
import 'package:grid_mobile/redux/modules/main_state.dart';
import 'package:grid_mobile/widgets/custom_text.dart';
// ignore: depend_on_referenced_packages
import 'package:latlong2/latlong.dart' show LatLng;
import 'package:flutter_map/flutter_map.dart';
import 'package:lottie/lottie.dart' hide Marker;
import 'package:redux/redux.dart';

import '../../../constants/general_const.dart';
import '../../../constants/enum/route_enum.dart';
import '../../../helpers/helpers.dart';
import '../../../redux/actions/main_action.dart';
import '../../../redux/app_state.dart';

class MiniMap extends StatefulWidget {
  const MiniMap({super.key});

  @override
  State<MiniMap> createState() => _MiniMapState();
}

class _MiniMapState extends State<MiniMap> {
  late Store<AppState> store;
  MapController mapController = MapController();
  LatLng initLatLng = const LatLng(-6.175392, 106.827153);

  bool mapReady = false;

  void toggleMapReady(bool value) {
    setState(() {
      mapReady = value;
    });
  }

  void onMapReady() {
    toggleMapReady(true);
  }

  Widget getItemCurrentLocation({required LatLng latLng}) {
    double size = mapController.zoom >= 17
        ? 250 * (mapController.zoom / 50)
        : mapController.zoom >= 15
            ? 250 * (mapController.zoom / 60)
            : mapController.zoom >= 13
                ? 250 * (mapController.zoom / 100)
                : mapController.zoom >= 10
                    ? 250 * (mapController.zoom / 150)
                    : 250 * (mapController.zoom / 200);

    return MarkerLayer(
      markers: [
        Marker(
          width: size,
          height: size,
          point: LatLng(
            latLng.latitude,
            latLng.longitude,
          ),
          anchorPos: AnchorPos.align(
            AnchorAlign.center,
          ),
          builder: (_) => Stack(
            children: [
              Center(
                child: Opacity(
                  opacity: 0.7,
                  child: Lottie.asset(
                    'assets/lotties/lottie-marker-ping.json',
                  ),
                ),
              ),
              Positioned.fill(
                child: Center(
                    child: Container(
                  width: (mapController.zoom / 1.5),
                  height: (mapController.zoom / 1.5),
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular((mapController.zoom / 1.5)),
                      color: ColorsCustom.blue),
                )),
              )
            ],
          ),
        ),
      ],
    );
  }

  Future<void> getMyLocation([bool moveMap = false]) async {
    if (await Geolocator.isLocationServiceEnabled()) {
      try {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.bestForNavigation);
        await store.dispatch(SetMyLocation(myLocation: position));
        if (moveMap) {
          mapController.move(LatLng(position.latitude, position.longitude), 18);
        }
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
      }
    } else {
      await Geolocator.openLocationSettings();
    }
  }

  void onFullscreenPressed() {
    store.dispatch(SetLayoutIndexScreen(layoutIndexScreen: RouteEnum.map));
  }

  @override
  void initState() {
    getMyLocation(true);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      store = StoreProvider.of<AppState>(context);
      Timer.periodic(const Duration(seconds: 1), (_) {
        getMyLocation();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
        width: double.maxFinite,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: StoreConnector<AppState, MainState>(
              converter: (store) => store.state.mainState,
              builder: (context, state) {
                return Stack(
                  children: [
                    FlutterMap(
                      mapController: mapController,
                      options: MapOptions(
                        rotationWinGestures: MultiFingerGesture.none,
                        onMapReady: onMapReady,
                        center: state.myLocation != null
                            ? LatLng(state.myLocation!.latitude,
                                state.myLocation!.longitude)
                            : initLatLng,
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
                          height: 200,
                          width: double.infinity,
                        ),
                        if (state.myLocation != null && mapReady)
                          getItemCurrentLocation(
                              latLng: LatLng(state.myLocation!.latitude,
                                  state.myLocation!.longitude)),
                      ],
                    ),
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                            color: ColorsCustom.black,
                            borderRadius: BorderRadius.circular(12)),
                        child: CustomText(
                          "Charging Station Near Me",
                          color: ColorsCustom.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 9,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 8,
                      bottom: 8,
                      child: GestureDetector(
                        onTap: onFullscreenPressed,
                        child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                color: ColorsCustom.black.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(20)),
                            child: Icon(
                              Icons.fullscreen_rounded,
                              size: 24,
                              color: ColorsCustom.white,
                            )),
                      ),
                    )
                  ],
                );
              }),
        ));
  }
}
