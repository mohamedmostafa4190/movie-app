import 'package:dio/dio.dart';

import 'api_const.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConst.baseUrl,
        receiveDataWhenStatusError: true,
        headers: {'Content-Type': 'application/json'},
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 13),
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    return await dio!.get(url, queryParameters: query);
  }

  static Future<Response> postLogin({
    required String url,
    required String email,
    required String password,
  }) async {
    return await dio!.post(url, data: {'email': email, 'password': password});
  }

  static Future<Response> postRegister({
    required String url,
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    String? phone,
    int? avaterId,
  }) async {
    final data = {
      'name': name,
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
      if (phone != null) 'phone': phone,
      if (avaterId != null) 'avaterId': avaterId,
    };

    return await dio!.post(url, data: data);
  }

  static Future<Response> patchResetPassword({
    required String url,
    required String token,
    required String oldPassword,
    required String newPassword,
  }) async {
    return await dio!.patch(
      url,
      data: {'oldPassword': oldPassword, 'newPassword': newPassword},
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }
}
