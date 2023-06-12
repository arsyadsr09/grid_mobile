import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './introduction.dart';

abstract class IntroductionViewModel extends State<Introduction> {
  final introKey = GlobalKey<IntroductionScreenState>();

  Future<void> onIntroEnd(context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("introduction", true);

    Navigator.pushReplacementNamed(context, "/LocationPermission");
  }

  Widget buildImage(String assetName, [double width = 550]) {
    return Image.asset('assets/images/$assetName', width: width);
  }
}
