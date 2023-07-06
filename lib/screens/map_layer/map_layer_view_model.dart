import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:geolocator/geolocator.dart';
import 'package:grid_mobile/constants/dummy_data.dart';
import 'package:grid_mobile/redux/actions/map_action.dart';
import 'package:grid_mobile/screens/map_layer/widgets/detail_station/detail_station.dart';
// ignore: depend_on_referenced_packages
import 'package:latlong2/latlong.dart' show LatLng;
import 'package:lottie/lottie.dart' hide Marker;
import 'package:redux/redux.dart';
import '../../helpers/helpers.dart';
import '../../redux/actions/main_action.dart';
import '../../redux/app_state.dart';
import './map_layer.dart';

abstract class MapLayerViewModel extends State<MapLayer> {
  late Store<AppState> store;
  MapController mapController = MapController();

  TextEditingController searchController = TextEditingController();

  LatLng initLatLng = const LatLng(-6.175392, 106.827153);

  bool mapReady = false;
  bool isShowSliderInfo = false;
  bool isResultShow = false;

  double filterValue = 0;

  void toggleSliderInfo(bool value) {
    setState(() {
      isShowSliderInfo = value;
    });
  }

  void toggleResultShow(bool value) {
    setState(() {
      isResultShow = value;
    });
  }

  void toggleMapReady(bool value) {
    setState(() {
      mapReady = value;
    });
  }

  void setFilterValue(double value) {
    setState(() {
      filterValue = value.roundToDouble();
      isShowSliderInfo = true;
    });

    delayOffSlider();
  }

  Future<void> delayOffSlider() async {
    await Future.delayed(const Duration(seconds: 2));

    toggleSliderInfo(false);
  }

  void onSearchChanged(String value) {
    if (value.isEmpty) {
      toggleResultShow(false);
    } else {
      toggleResultShow(true);
    }
  }

  void onMapReady() {
    toggleMapReady(true);
  }

  void onDetailStationOpen() {
    // TODO: Dummy Data
    store.dispatch(SetSelectedMarker(selectedMarker: DummyData.selectedMarker));

    showModalBottomSheet<void>(
        context: context,
        useSafeArea: true,
        builder: (BuildContext context) {
          return const DetailStation();
        });
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
        debugPrint(e.toString());
      }
    } else {
      await Geolocator.openLocationSettings();
    }
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
}
