import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import './settings.dart';

abstract class SettingsViewModel extends State<Settings> {
  Future<void> onLogOut() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();

      // ignore: use_build_context_synchronously
      Navigator.pushNamedAndRemoveUntil(context, "/Landing", (route) => false);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
