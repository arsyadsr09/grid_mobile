import 'package:flutter/material.dart';
import './sign_in.dart';

abstract class SignInViewModel extends State<SignIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String errorEmail = "";
  String errorPassword = "";
  String errorLogin = "";

  bool isLoading = false;

  void setError({required String type, required String value}) {
    setState(() {
      if (type == 'password') {
        errorPassword = value;
      } else if (type == 'email') {
        errorEmail = value;
      } else if (type == 'login') {
        errorLogin = value;
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
}
