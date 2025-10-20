import 'package:dio/dio.dart';

import '../../core/config/api_endpoints.dart';
import '../../domain/interfaces/ride_service_interface.dart';
import 'api/dio_client.dart';

class RideService implements IRideService {
  final DioClient dioClient;

  RideService({required this.dioClient});
  @override
  Future<Response> rideOrder({required int orderId, required String status}) async => await dioClient.dio
        .get('${ApiEndpoints.orderRide}/$orderId/$status',);

  @override
  Future<Response> orderDetails({required int orderId}) async => await dioClient.dio
        .get('${ApiEndpoints.rideDetails}/$orderId',);

  @override
  Future<Response> saveRideStatus({required int orderId, required String status}) async => await dioClient.dio
        .get('${ApiEndpoints.orderRide}/$orderId/$status/status',);

  @override
  Future<Response> cancelRide({required int? orderId}) async => await dioClient.dio.get('${ApiEndpoints.cancelRide}/$orderId',);

  @override
  Future<Response> checkActiveTrip() async => await dioClient.dio.get(ApiEndpoints.checkActiveTrip,);
  
  @override
  Future<Response> acceptRejectRide({required int orderId, required String status}) async => await dioClient.dio.put('${ApiEndpoints.acceptRejectUrl}/$orderId/$status' );
}
