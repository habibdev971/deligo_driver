import 'package:deligo_driver/domain/interfaces/complaint_service_interface.dart';
import 'package:dio/dio.dart';

import '../../core/config/api_endpoints.dart';
import 'api/dio_client.dart';

class ComplaintService implements IComplaintService {
  final DioClient dioClient;

  ComplaintService({required this.dioClient});

  @override
  Future<Response> getMyComplaintData({required Map<String, dynamic> params}) async => await dioClient.dio.get(ApiEndpoints.getMyComplaint,
        queryParameters: params);

  @override
  Future<Response> createComplaint({required num? orderId, required Map<String, dynamic> data}) async => await dioClient.dio.post('${ApiEndpoints.createComplaint}/$orderId', data: data);

  @override
  Future<Response> getComplaintTypes()async => await dioClient.dio.get(ApiEndpoints.getComplaintTypes,
        queryParameters: {'userType': 'DRIVER'}
    );
}
