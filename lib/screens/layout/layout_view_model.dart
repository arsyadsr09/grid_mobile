import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:grid_mobile/constants/enum/route_enum.dart';
import 'package:grid_mobile/redux/actions/main_action.dart';
import 'package:grid_mobile/redux/app_state.dart';
import 'package:grid_mobile/screens/home/home.dart';
import 'package:grid_mobile/screens/map_layer/map_layer.dart';
import 'package:redux/redux.dart';
import './layout.dart';

abstract class LayoutViewModel extends State<Layout> {
  late Store<AppState> store;
  List<Map> listScreens = [
    {
      'name': 'Home',
      'screens': const Home(),
      'icon': Icons.home_outlined,
      'index': RouteEnum.home
    },
    {
      'name': 'Map',
      'screens': const MapLayer(),
      'icon': Icons.map_outlined,
      'index': RouteEnum.map
    },
    {
      'name': 'Notifications',
      'screens': const Home(),
      'icon': Icons.notifications_outlined,
      'index': RouteEnum.notifications
    },
    {
      'name': 'Setting',
      'screens': const Home(),
      'icon': Icons.settings_outlined,
      'index': RouteEnum.settings
    },
  ];

  void setCurrentIndexScreen(RouteEnum value) {
    store.dispatch(SetLayoutIndexScreen(layoutIndexScreen: value));
  }

  Widget getScreens(RouteEnum index) {
    Map filtered =
        listScreens.firstWhere((element) => element['index'] == index);

    return filtered['screens'];
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      store = StoreProvider.of<AppState>(context);
    });
  }
}
