import 'package:dio/dio.dart';
import 'package:deligo_driver/data/services/api/dio_client.dart';
import 'package:deligo_driver/domain/interfaces/dashboard_service_interface.dart';

import '../../core/config/api_endpoints.dart';

class DashboardServiceImpl implements IDashboardService {
  final DioClient dioClient;

  DashboardServiceImpl({required this.dioClient});
  @override
  Future<Response> getDashboard() async => await dioClient.dio.post(ApiEndpoints.dashboard);

}
