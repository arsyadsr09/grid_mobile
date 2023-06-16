import 'package:flutter/material.dart';
import './verify_otp_view.dart';

class VerifyOtp extends StatefulWidget {
  const VerifyOtp({super.key, required this.phoneNumber});

  final String phoneNumber;
  
  @override
  VerifyOtpView createState() =>  VerifyOtpView();
}
  
