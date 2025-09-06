import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:deligo_driver/data/services/local_storage_service.dart';

import '../../../core/routes/app_routes.dart';
import '../../../core/utils/logger.dart';
import '../navigation_service.dart';

class DioInterceptors extends Interceptor {
  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    Logger.log('REQUEST[${options.method}] => PATH: ${options.path}');

    // Token fetch from local storage
    final token = await LocalStorageService().getToken();
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
      await LocalStorageService().clearStorage();

      if (currentContext != null && currentRoute != AppRoutes.login) {
        NavigationService.pushNamedAndRemoveUntil(AppRoutes.login);
      }
    }

    return super.onError(err, handler);
  }

}
