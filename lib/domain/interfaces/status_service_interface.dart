import 'package:dio/dio.dart';

abstract class IStatusService {
  Future<Response> updateOnlineStatus({required bool status});
  Future<Response> updateRadius({required int radius});
}
