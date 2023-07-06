import 'package:flutter/material.dart';
import 'package:grid_mobile/widgets/header_page.dart';
import './charging_point_view_model.dart';

class ChargingPointView extends ChargingPointViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          HeaderPage(
            title: "Charging Point",
          )
        ],
      ),
    );
  }
}
