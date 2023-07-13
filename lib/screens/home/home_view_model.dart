import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:grid_mobile/redux/app_state.dart';
import 'package:redux/redux.dart';

import './home.dart';

abstract class HomeViewModel extends State<Home> {
  late Store<AppState> store;
  late ScrollController scrollController;
  double scrollPosition = 0.0;

  String currentLocation = "";

  void _scrollListener() {
    setState(() {
      scrollPosition = scrollController.position.pixels;
    });
  }

  Future<void> getCurrentCity() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      List<Placemark> placemark =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      setState(() {
        currentLocation = (Platform.isIOS
            ? placemark[0].locality
            : placemark[0].subAdministrativeArea)!;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
    getCurrentCity();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      store = StoreProvider.of(context);
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
