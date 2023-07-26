import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/models.dart';
import '../../providers/providers.dart';
import '../../redux/actions/main_action.dart';
import '../../redux/app_state.dart';
import '../lifecycle_manager/lifecycle_manager.dart';
import './verify_otp.dart';

abstract class VerifyOtpViewModel extends State<VerifyOtp> {
  late Store<AppState> store;
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

  Future<void> onVerify() async {
    try {
      store.dispatch(SetLoading(isLoading: true));
      Response res = await Providers.submitOtp(otp: otpController.text);
      ResponseModel resData = ResponseModel.fromJson(res.data);

      if (resData.status!) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('is_login', true);
        store.dispatch(SetLoading(isLoading: true));
        // ignore: use_build_context_synchronously
        Navigator.pushNamedAndRemoveUntil(context, "/Layout", (route) => false);
      }
    } catch (e) {
      store.dispatch(SetLoading(isLoading: true));
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> onResendOtp() async {
    if (resendActive) {
      try {
        await store.dispatch(SetLoading(isLoading: true));
        setState(() {
          startTimer = 30;
        });
        toggleTimer();
        Response res = await Providers.resendOtp();
        ResponseModel resData = ResponseModel.fromJson(res.data);

        if (resData.status!) {
          await store.dispatch(SetLoading(isLoading: true));
          setState(() {
            resendActive = false;
          });

          // ignore: use_build_context_synchronously
          await LifecycleManager.of(context)?.initData();
          // ignore: use_build_context_synchronously
          Navigator.pushNamedAndRemoveUntil(
              context, "/Layout", (route) => false);
        } else {
          await store.dispatch(SetLoading(isLoading: true));
          setState(() {
            resendActive = true;
            if (mounted && timer != null) {
              timer!.cancel();
            }
          });
        }
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
  }

  @override
  void initState() {
    toggleTimer();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      store = StoreProvider.of(context);
    });
  }

  @override
  void dispose() {
    if (mounted && timer != null) {
      timer!.cancel();
    }
    super.dispose();
  }
}
