import 'dart:async';

import 'package:flutter/material.dart';
import './verify_otp.dart';

abstract class VerifyOtpViewModel extends State<VerifyOtp> {
  TextEditingController otpController = TextEditingController();

  String errorOtp = "";

  bool resendActive = false;
  bool isLoading = false;

  Timer? timer;
  int startTimer = 30;

  void setError(String value) {
    setState(() {
      errorOtp = value;
      isLoading = false;
    });
  }

  void clearError() {
    setState(() {
      errorOtp = "";
    });
  }

  void toggleTimer() {
    const Duration oneSec = Duration(seconds: 1);
    timer = Timer.periodic(oneSec, (Timer timer) {
      if (mounted) {
        setState(
          () {
            if (startTimer < 1) {
              timer.cancel();
              resendActive = true;
            } else {
              startTimer = startTimer - 1;
            }
          },
        );
      }
    });
  }

  String leadingZero(int value) {
    return value.toString().padLeft(2, '0');
  }

  @override
  void initState() {
    toggleTimer();
    super.initState();
  }

  @override
  void dispose() {
    if (mounted && timer != null) {
      timer!.cancel();
    }
    super.dispose();
  }
}
