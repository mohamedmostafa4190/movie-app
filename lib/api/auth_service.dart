import 'package:dio/dio.dart';
import 'package:flutter_application_1/api/api_endpoints.dart';

import 'dio_helper.dart';

class AuthService {
  static Future<Response> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String? phone,
    required int? avaterId,
  }) async {
    final url = ApiEndPoints.register;
    return await DioHelper.postRegister(
      url: url,
      name: name,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      phone: phone,
      avaterId: avaterId,
    );
  }

  static Future<Response> login({
    required String email,
    required String password,
  }) async {
    final url = ApiEndPoints.login;
    return await DioHelper.postLogin(
      url: url,
      email: email,
      password: password,
    );
  }
}
