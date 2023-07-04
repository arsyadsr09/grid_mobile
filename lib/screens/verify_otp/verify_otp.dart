import 'package:flutter/material.dart';
import './verify_otp_view.dart';

class VerifyOtp extends StatefulWidget {
  const VerifyOtp({super.key, required this.email});

  final String email;
  
  @override
  VerifyOtpView createState() =>  VerifyOtpView();
}
  
