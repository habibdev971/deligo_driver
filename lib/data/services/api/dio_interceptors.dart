import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:deligo_driver/data/services/local_storage_service.dart';

import '../../../core/config/api_endpoints.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/utils/logger.dart';
import '../navigation_service.dart';

class DioInterceptors extends Interceptor {
  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    String? token;
    final String url = options.uri.path;
    log('-->> request url: $url');
    // Token fetch from local storage
    token = (url.contains(ApiEndpoints.updatePassword) || url.contains(ApiEndpoints.registrationUrl)) ? await LocalStorageService().getRegisterToken() : await LocalStorageService().getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }


  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
    Logger.log(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    Logger.log('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');

    final navigatorKey = NavigationService.navigatorKey;
    final currentContext = navigatorKey.currentContext;
    final currentRoute = currentContext != null ? ModalRoute.of(currentContext)?.settings.name : null;

    if (err.response?.statusCode == 401) {
      await LocalStorageService().clearToken();
      await LocalStorageService().clearRegisterToken();
      await LocalStorageService().clearStorage();

      if (currentContext != null && currentRoute != AppRoutes.loginSignUp) {
        NavigationService.pushNamedAndRemoveUntil(AppRoutes.loginSignUp, arguments: {'isLoginPage': true});
      }
    }

    return super.onError(err, handler);
  }

}
