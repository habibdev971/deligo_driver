import 'package:dio/dio.dart';

import '../../core/config/api_endpoints.dart';
import '../../domain/interfaces/status_service_interface.dart';
import 'api/dio_client.dart';

class StatusService implements IStatusService {
  final DioClient dioClient;

  StatusService({required this.dioClient});
  @override
  Future<Response> updateOnlineStatus({required String status}) async => await dioClient.dio
        .get(ApiEndpoints.onlineOfflineStatusUpdate, queryParameters: {
      'status': status,
    });

  @override
  Future<Response> updateRadius({required int radius}) async => await dioClient.dio
        .post(ApiEndpoints.updateRadius, data: {'radius_in_meter': radius});
}
