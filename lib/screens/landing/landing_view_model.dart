import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:grid_mobile/redux/app_state.dart';
import 'package:grid_mobile/utils/secure_storage.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/storage_const.dart';
import '../../models/models.dart';
import '../../redux/actions/main_action.dart';
import './landing.dart';

abstract class LandingViewModel extends State<Landing> {
  late Store<AppState> store;
  final storage = FlutterSecureStorage(
    iOptions: SecureStorage.getIOSOptions(),
    aOptions: SecureStorage.getAndroidOptions(),
  );

  Future<void> onSignInWithGoogle() async {
    try {
      store.dispatch(SetLoading(isLoading: true));
      GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: [
          'email',
          'openid',
          'profile',
        ],
      );
      await googleSignIn.signIn();

      GoogleSignInAccount? googleUser = googleSignIn.currentUser;

      if (googleUser != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        UserModel userData = UserModel(
            id: googleUser.id,
            displayName: googleUser.displayName,
            email: googleUser.email,
            photoURL: googleUser.photoUrl,
            serverAuthCode: googleUser.serverAuthCode);

        Map userDataJson = userData.toJson();

        await prefs.setBool('is_login', true);
        await storage.write(
          key: StorageConst.userDataKey,
          value: jsonEncode(userDataJson),
        );

        await store.dispatch(SetLoading(isLoading: false));
        // ignore: use_build_context_synchronously
        Navigator.pushNamedAndRemoveUntil(context, "/Layout", (route) => false);
      }
    } catch (error) {
      debugPrint(error.toString());
    } finally {
      store.dispatch(SetLoading(isLoading: false));
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
