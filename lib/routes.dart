import 'package:flutter/material.dart';

import 'screens/home/home.dart';
import 'screens/layout/layout.dart';
import 'screens/sign_in/sign_in.dart';
import 'screens/sign_up/sign_up.dart';

final Map<String, WidgetBuilder> routes = {
  '/Home': (BuildContext context) => const Home(),
  '/Layout': (BuildContext context) => const Layout(),
  '/SignIn': (BuildContext context) => const SignIn(),
  '/SignUp': (BuildContext context) => const SignUp(),
};
