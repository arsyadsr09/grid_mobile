import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:grid_mobile/routes.dart';
import 'package:grid_mobile/screens/introductions/introductions.dart';
import 'package:grid_mobile/screens/layout/layout.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'redux/app_state.dart';
import 'redux/store.dart';
import 'screens/location_permission/location_permission.dart';
import 'utils/bad_certificate_handler.dart';
import 'helpers/colors_custom.dart';
import 'utils/injector.dart';

Future<void> main() async {
  await Injector.initializeDependencies();
  HttpOverrides.global = MyHttpOverrides();

  Store<AppState> store = (await createStore());

  runApp(MainApp(
    store: store,
  ));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key, required this.store});

  final Store<AppState> store;

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool introduction = false;
  bool noPermissionLocation = false;

  Future<void> checkLocationPermission() async {
    if (await Permission.location.request().isGranted == false) {
      // Either the permission was already granted before or the user just granted it.
      setState(() {
        noPermissionLocation = true;
      });
    }
  }

  Future<void> initLocal() async {
    final prefs = await SharedPreferences.getInstance();
    bool intro = prefs.getBool("introduction") ?? false;

    setState(() {
      introduction = intro;
    });
  }

  @override
  void initState() {
    initLocal();
    checkLocationPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
        store: widget.store,
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Grid Mobile',
            theme: ThemeData(
              colorScheme:
                  ColorScheme.fromSeed(seedColor: ColorsCustom.primary),
              useMaterial3: true,
            ),
            home: !introduction
                ? const Introductions()
                : noPermissionLocation
                    ? const LocationPermission()
                    : const Layout(),
            routes: routes));
  }
}
