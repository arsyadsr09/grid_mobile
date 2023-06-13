import 'package:flutter/material.dart';
import 'package:grid_mobile/constants/route_enum.dart';
import './layout_view.dart';

class Layout extends StatefulWidget {
  const Layout({super.key, this.route});

  final RouteEnum? route;

  @override
  LayoutView createState() => LayoutView();
}
