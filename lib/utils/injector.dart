import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Injector {
  static Future<void> initializeDependencies() async {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }
}
