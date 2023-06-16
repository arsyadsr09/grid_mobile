import 'package:flutter/material.dart';
import './landing.dart';

abstract class LandingViewModel extends State<Landing> {
  void onSignIn() {
    Navigator.pushNamed(context, '/SignIn');
  }
}
