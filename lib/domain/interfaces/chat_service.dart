import 'package:dio/dio.dart';

abstract class IChatService {
  Future<Response> getMessage();
  Future<Response> sendMessage({required String message,});
}
