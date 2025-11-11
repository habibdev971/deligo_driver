import 'package:dio/dio.dart';

import '../../core/config/api_endpoints.dart';
import '../../domain/interfaces/ride_history_service_interface.dart';
import 'api/dio_client.dart';

class RideHistoryService implements IRideHistoryService {
  final DioClient dioClient;

  RideHistoryService({required this.dioClient});
  @override
  Future<Response> getRideHistory({required Map<String, dynamic> params}) async => await dioClient.dio
        .get(ApiEndpoints.rideHistory, queryParameters: params);

}
