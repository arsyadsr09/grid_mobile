import 'package:flutter/material.dart';
import 'package:grid_mobile/screens/layout/layout.dart';

import 'screens/home/home.dart';

final Map<String, WidgetBuilder> routes = {
  '/Home': (BuildContext context) => const Home(),
  '/Layout': (BuildContext context) => const Layout(),
};
