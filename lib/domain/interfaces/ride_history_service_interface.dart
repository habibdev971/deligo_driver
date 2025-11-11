import 'package:dio/dio.dart';

abstract class IRideHistoryService {
  Future<Response> getRideHistory({required Map<String, dynamic> params});
}
