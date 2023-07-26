import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:grid_mobile/redux/actions/main_action.dart';
import 'package:grid_mobile/redux/actions/payments_action.dart';
import 'package:grid_mobile/redux/actions/user_action.dart';
import 'package:redux/redux.dart';
import '../../constants/storage_const.dart';
import '../../models/models.dart';
import '../../providers/providers.dart';
import '../../redux/app_state.dart';
import '../../utils/secure_storage.dart';
import './lifecycle_manager.dart';

abstract class LifecycleManagerViewModel extends State<LifecycleManager> {
  late Store<AppState> store;
  final storage = FlutterSecureStorage(
    iOptions: SecureStorage.getIOSOptions(),
    aOptions: SecureStorage.getAndroidOptions(),
  );

  Future<void> getUserProfile() async {
    try {
      Response res = await Providers.getUserProfile();
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
        await store.dispatch(SetUserInfo(userInfo: userData));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> getUserCredit() async {
    try {
      Response res = await Providers.getUserCredit();
      ResponseModel resData = ResponseModel.fromJson(res.data);

      if (resData.status!) {
        await store.dispatch(SetCredit(credit: resData.data['credit']));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> getTrxHistory() async {
    try {
      Response res = await Providers.getTransactionHistory(orderBy: 'desc');
      ResponseModel resData = ResponseModel.fromJson(res.data);

      if (resData.status!) {
        List<Map<String, dynamic>> rawData =
            List<Map<String, dynamic>>.from(resData.data);
        List<TransactionModel> latestTransactions = rawData
            .map((Map<String, dynamic> e) => TransactionModel.fromJson(e))
            .toList();


        await store.dispatch(SetTransactions(transactions: latestTransactions));
      }
    } catch (e, t) {
      if (kDebugMode) {
        print(t);
        print(e);
      }
    }
  }

  Future<void> initData() async {
    await store.dispatch(SetLoading(isLoading: true));
    await getTrxHistory();
    await getUserProfile();
    await getUserCredit();
    await store.dispatch(SetLoading(isLoading: false));
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      store = StoreProvider.of(context);
      initData();
    });
  }
}
