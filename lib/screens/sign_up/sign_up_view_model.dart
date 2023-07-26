import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:grid_mobile/screens/verify_otp/verify_otp.dart';
import 'package:redux/redux.dart';
import '../../constants/storage_const.dart';
import '../../localization/app_translations.dart';
import '../../models/models.dart';
import '../../providers/providers.dart';
import '../../redux/actions/main_action.dart';
import '../../redux/actions/user_action.dart';
import '../../redux/app_state.dart';
import '../../utils/secure_storage.dart';
import './sign_up.dart';

abstract class SignUpViewModel extends State<SignUp> {
  late Store<AppState> store;
  final storage = FlutterSecureStorage(
    iOptions: SecureStorage.getIOSOptions(),
    aOptions: SecureStorage.getAndroidOptions(),
  );
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

  void setError({required String type, required String value}) {
    setState(() {
      if (type == 'password') {
        errorPassword = value;
      } else if (type == 'retype_password') {
        errorRetypePassword = value;
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
    });
  }

  void clearError(String type) {
    setState(() {
      if (type == 'email') {
        errorEmail = "";
      } else if (type == 'password') {
        errorPassword = "";
      } else if (type == 'retype_password') {
        errorRetypePassword = "";
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
      } else if (type == 'retype_password') {
        retypePasswordController.text = "";
      } else if (type == 'firstname') {
        firstnameController.text = "";
      } else if (type == 'lastname') {
        lastnameController.text = "";
      } else if (type == 'phoneNumber') {
        emailController.text = "";
      }
    });
  }

  Future<void> onSignUp() async {
    if (emailController.text.isEmpty) {
      setError(
          type: "email",
          value:
              AppTranslations.of(context)!.text("please_fill_in_your_email"));
    }
    if (passwordController.text.isEmpty) {
      setError(
          type: "password",
          value: AppTranslations.of(context)!
              .text("please_fill_in_your_password"));
    }
    if (phoneNumberController.text.isEmpty) {
      setError(
          type: "phoneNumber",
          value:
              AppTranslations.of(context)!.text("please_fill_in_your_phone"));
    }
    if (firstnameController.text.isEmpty) {
      setError(
          type: "firstname",
          value: AppTranslations.of(context)!
              .text("please_fill_in_your_firstname"));
    }
    if (lastnameController.text.isEmpty) {
      setError(
          type: "lastname",
          value: AppTranslations.of(context)!
              .text("please_fill_in_your_lastname"));
    }
    if (retypePasswordController.text.isEmpty) {
      setError(
          type: "retype_password",
          value:
              AppTranslations.of(context)!.text("please_fill_in_your_retype"));
    }
    if (emailController.text.isNotEmpty &&
        !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(emailController.text)) {
      setError(
          type: "email",
          value: AppTranslations.of(context)!.text("invalid_email"));
    }
    if (phoneNumberController.text.isNotEmpty &&
            !RegExp(r'^[0]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$').hasMatch(
                phoneNumberController.text.replaceAll(RegExp(r"\s+"), "")) ||
        phoneNumberController.text.length < 6) {
      setError(
          type: "phoneNumber",
          value: AppTranslations.of(context)!.text("invalid_phone"));
    }
    if (passwordController.text != retypePasswordController.text) {
      setError(
          type: "password",
          value: AppTranslations.of(context)!.text("password_not_same"));
    }

    if (errorEmail == "" && errorRegister == "" && errorPassword == "") {
      try {
        store.dispatch(SetLoading(isLoading: true));

        String phoneFormattted =
            phoneNumberController.text.replaceAll(RegExp(r"\s+"), "");

        Response res = await Providers.signUp(
            password: passwordController.text,
            email: emailController.text,
            firstName: firstnameController.text,
            lastName: lastnameController.text,
            phone: phoneFormattted);
        ResponseModel resData = ResponseModel.fromJson(res.data);
        if (resData.status!) {
          UserModel userData = UserModel(
            id: resData.data['user']['id'],
            idHash: resData.data['user']['id_hash'],
            email: resData.data['user']['email'],
            phone: resData.data['user']['phone'],
            firstName: resData.data['user']['first_name'],
            lastName: resData.data['user']['last_name'],
            isActive: resData.data['user']['is_active'],
            roleId: resData.data['user']['role_id'],
            createdAt: resData.data['user']['created_at'],
            updatedAt: resData.data['user']['updated_at'],
          );
          Map userDataJson = userData.toJson();

          await storage.write(
            key: StorageConst.userDataKey,
            value: jsonEncode(userDataJson),
            iOptions: SecureStorage.getIOSOptions(),
            aOptions: SecureStorage.getAndroidOptions(),
          );
          await storage.write(
            key: StorageConst.tokenKey,
            value: resData.data['access_token'],
          );

          await store.dispatch(SetUserInfo(userInfo: userData));

          await store
              .dispatch(SetCredit(credit: resData.data['user']['credit']));

          // ignore: use_build_context_synchronously
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => VerifyOtp(email: emailController.text)));
        }
      } catch (e) {
        store.dispatch(SetLoading(isLoading: true));
        if (kDebugMode) {
          print(e);
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      store = StoreProvider.of(context);
    });
  }
}
