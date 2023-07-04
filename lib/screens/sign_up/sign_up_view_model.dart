import 'package:flutter/material.dart';
import 'package:grid_mobile/screens/verify_otp/verify_otp.dart';
import './sign_up.dart';

abstract class SignUpViewModel extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController retypePasswordController = TextEditingController();

  String errorEmail = "";
  String errorFirstname = "";
  String errorLastname = "";
  String errorPhoneNumber = "";
  String errorPassword = "";
  String errorRetypePassword = "";
  String errorRegister = "";

  bool isLoading = false;

  void setError({required String type, required String value}) {
    setState(() {
      if (type == 'password') {
        errorPassword = value;
      } else if (type == 'firstname') {
        errorFirstname = value;
      } else if (type == 'lastname') {
        errorLastname = value;
      } else if (type == 'phoneNumber') {
        errorPhoneNumber = value;
      } else if (type == 'email') {
        errorEmail = value;
      } else if (type == 'register') {
        errorRegister = value;
      }
      isLoading = false;
    });
  }

  void clearError(String type) {
    setState(() {
      if (type == 'email') {
        errorEmail = "";
      } else if (type == 'password') {
        errorPassword = "";
      } else if (type == 'firstname') {
        errorFirstname = "";
      } else if (type == 'lastname') {
        errorLastname = "";
      } else if (type == 'phoneNumber') {
        errorPhoneNumber = "";
      }
    });
  }

  void onClearTextField(String type) {
    setState(() {
      if (type == 'email') {
        emailController.text = "";
      } else if (type == 'password') {
        passwordController.text = "";
      }
    });
  }

  void onSignUp() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => const VerifyOtp(email: "abcdefg@gmail.com")));
  }
}
