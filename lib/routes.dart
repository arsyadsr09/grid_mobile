import 'package:flutter/material.dart';

import 'screens/home/home.dart';
import 'screens/layout/layout.dart';
import 'screens/landing/landing.dart';
import 'screens/scanner/scanner.dart';
import 'screens/sign_in/sign_in.dart';
import 'screens/sign_up/sign_up.dart';
import 'screens/charging_point/charging_point.dart';
import 'screens/reservation/reservation.dart';

final Map<String, WidgetBuilder> routes = {
  '/Home': (BuildContext context) => const Home(),
  '/Landing': (BuildContext context) => const Landing(),
  '/Layout': (BuildContext context) => const Layout(),
  '/SignIn': (BuildContext context) => const SignIn(),
  '/SignUp': (BuildContext context) => const SignUp(),
  '/Scanner': (BuildContext context) => const Scanner(),
  '/ChargingPoint': (BuildContext context) => const ChargingPoint(),
  '/Reservation': (BuildContext context) => const Reservation(),
};
