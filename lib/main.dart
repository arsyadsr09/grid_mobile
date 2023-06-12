import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:grid_mobile/screens/home/home.dart';
import 'package:redux/redux.dart';

import 'redux/app_state.dart';
import 'redux/store.dart';
import 'utils/bad_certificate_handler.dart';
import 'utils/colors_custom.dart';
import 'utils/injector.dart';

Future<void> main() async {
  await Injector.initializeDependencies();
  HttpOverrides.global = MyHttpOverrides();

  Store<AppState> store = (await createStore());

  runApp(MainApp(
    store: store,
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.store});

  final Store<AppState> store;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
        store: store,
        child: MaterialApp(
          title: 'Grid Mobile',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: ColorsCustom.primary),
            useMaterial3: true,
          ),
          home: const Home(),
        ));
  }
}
