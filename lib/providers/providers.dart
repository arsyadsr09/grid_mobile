import 'package:dio/dio.dart';
import 'package:grid_mobile/constants/env/env.dart';

class Providers {
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

  // static Future getUserDetail() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String jwtToken = prefs.getString("jwtToken");

  //   return Dio().get('$BASE_API/users',
  //       options: Options(
  //           headers: {'authorization': basicAuth, 'token': jwtToken},
  //           followRedirects: false,
  //           validateStatus: (status) {
  //             return status < 1000;
  //           }));
  // }
}
