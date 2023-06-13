import 'package:flutter/material.dart';
import './layout.dart';

abstract class LayoutViewModel extends State<Layout> {
  List<Map> listScreens = [
    {'name': 'Home', 'icon': Icons.home_outlined, 'index': 0},
    {'name': 'Map', 'icon': Icons.map_outlined, 'index': 1},
    {'name': 'Notifications', 'icon': Icons.notifications_outlined, 'index': 2},
    {'name': 'Setting', 'icon': Icons.settings_outlined, 'index': 3},
  ];
  int currentIndexScreen = 0;

  void setCurrentIndexScreen(int value) {
    setState(() {
      currentIndexScreen = value;
    });
  }

  bool isCurrentIndexScreen(int index) {
    return currentIndexScreen == index;
  }
}
