import 'package:dio/dio.dart';

abstract class IComplaintService {
  Future<Response> getMyComplaintData({required Map<String, dynamic> params});
  Future<Response> createComplaint({ required num? orderId, required Map<String, dynamic> data});
  Future<Response> getComplaintTypes();
}
