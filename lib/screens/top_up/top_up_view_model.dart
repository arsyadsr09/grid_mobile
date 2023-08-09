import 'package:flutter/material.dart';
import './top_up.dart';

abstract class TopUpViewModel extends State<TopUp> {
  void onTopUpMethodClicked(String name) {
    debugPrint(name);
  }
}
