import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:grid_mobile/models/models.dart';
import 'package:grid_mobile/redux/actions/main_action.dart';
import 'package:grid_mobile/redux/actions/user_action.dart';
import 'package:grid_mobile/redux/app_state.dart';
import 'package:grid_mobile/screens/lifecycle_manager/lifecycle_manager.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/storage_const.dart';
import '../../localization/app_translations.dart';
import '../../providers/providers.dart';
import '../../utils/secure_storage.dart';
import './sign_in.dart';

abstract class SignInViewModel extends State<SignIn> {
  late Store<AppState> store;
  final storage = FlutterSecureStorage(
    iOptions: SecureStorage.getIOSOptions(),
    aOptions: SecureStorage.getAndroidOptions(),
  );
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

  Future<void> onSignIn() async {
    if (emailController.text.isEmpty) {
      setError(
          type: "username",
          value:
              AppTranslations.of(context)!.text("please_fill_in_your_email"));
    }
    if (passwordController.text.isEmpty) {
      setError(
          type: "password",
          value: AppTranslations.of(context)!
              .text("please_fill_in_your_password"));
    }

    if (errorEmail == "" && errorLogin == "" && errorPassword == "") {
      try {
        store.dispatch(SetLoading(isLoading: true));

        Response res = await Providers.signIn(
          password: passwordController.text,
          param: emailController.text,
        );
        ResponseModel resData = ResponseModel.fromJson(res.data);

        if (resData.status!) {
          SharedPreferences prefs = await SharedPreferences.getInstance();

          UserModel userData = UserModel(
            id: resData.data['user']['id'].toString(),
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

          await prefs.setBool('is_login', true);
          await store.dispatch(SetUserInfo(userInfo: userData));

          await store
              .dispatch(SetCredit(credit: resData.data['user']['credit']));
          // ignore: use_build_context_synchronously
          await LifecycleManager.of(context)?.initData();
          // ignore: use_build_context_synchronously
          Navigator.pushNamedAndRemoveUntil(
              context, "/Layout", (route) => false);
        }
      } catch (e, t) {
        store.dispatch(SetLoading(isLoading: true));
        if (kDebugMode) {
          print(e);
          print(t);
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
