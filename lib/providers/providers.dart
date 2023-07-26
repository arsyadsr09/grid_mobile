import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:grid_mobile/constants/env/env.dart';

import '../constants/storage_const.dart';
import '../utils/secure_storage.dart';

class Providers {
  static final storage = FlutterSecureStorage(
    iOptions: SecureStorage.getIOSOptions(),
    aOptions: SecureStorage.getAndroidOptions(),
  );

  static Future signIn(
      {required String param, required String password}) async {
    return Dio().post('${Env.apiEndpoint}/auth/login',
        data: {'param': param, "password": password},
        options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status! < 1000;
            }));
  }

  static Future signUp(
      {required String firstName,
      required String lastName,
      required String email,
      required String phone,
      required String password}) async {
    return Dio().post('${Env.apiEndpoint}/auth/register',
        data: {
          "first_name": firstName,
          "last_name": lastName,
          "email": email,
          "phone": phone,
          "password": password
        },
        options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status! < 1000;
            }));
  }

  static Future submitOtp({String? otp}) async {
    String? token = await storage.read(key: StorageConst.tokenKey);
    return Dio().post('${Env.apiEndpoint}/auth/otp-submit',
        data: {"OTP": otp},
        options: Options(
            headers: {'Authorization': "Bearer $token"},
            followRedirects: false,
            validateStatus: (status) {
              return status! < 1000;
            }));
  }

  static Future resendOtp() async {
    String? token = await storage.read(key: StorageConst.tokenKey);
    return Dio().get('${Env.apiEndpoint}/auth/otp-request',
        options: Options(
            headers: {'Authorization': "Bearer $token"},
            followRedirects: false,
            validateStatus: (status) {
              return status! < 1000;
            }));
  }

  static Future getUserCredit() async {
    String? token = await storage.read(key: StorageConst.tokenKey);
    return Dio().get('${Env.apiEndpoint}/grid/user-cash',
        options: Options(
            headers: {'Authorization': "Bearer $token"},
            followRedirects: false,
            validateStatus: (status) {
              return status! < 1000;
            }));
  }

  static Future getUserProfile() async {
    String? token = await storage.read(key: StorageConst.tokenKey);
    return Dio().get('${Env.apiEndpoint}/auth/user-profile',
        options: Options(
            headers: {'Authorization': "Bearer $token"},
            followRedirects: false,
            validateStatus: (status) {
              return status! < 1000;
            }));
  }

  static Future getTransactionHistory(
      {String? orderBy = 'asc',
      String? limit,
      String? start,
      String? end,
      String? type}) async {
    String? token = await storage.read(key: StorageConst.tokenKey);
    return Dio().post('${Env.apiEndpoint}/grid/trantaction-history',
        data: {
          "order_by": orderBy,
          "limit": limit,
          "start": start,
          "end": end,
          "type": type
        },
        options: Options(
            headers: {'Authorization': "Bearer $token"},
            followRedirects: false,
            validateStatus: (status) {
              return status! < 1000;
            }));
  }
}
