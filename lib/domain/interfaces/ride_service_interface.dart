import 'package:dio/dio.dart';

abstract class IRideService {
  Future<Response> rideOrder({required int orderId, required String status});
  Future<Response> orderDetails({required int orderId,});
  Future<Response> saveRideStatus({required int orderId, required String status});
  Future<Response> cancelRide({required int? orderId});
  Future<Response> checkActiveTrip();
  Future<Response> acceptRejectRide({required int orderId, required String status});
}
