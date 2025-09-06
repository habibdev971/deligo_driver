import 'package:dartz/dartz.dart';
import 'package:deligo_driver/data/models/order_response/order_detail/order_detail_model.dart';
import '../../../core/errors/failure.dart';
import '../../models/common_response.dart';
import '../../models/order_response/tip_model/trip_model.dart';

abstract class IRideRepo {
  Future<Either<Failure, OrderDetailModel>> rideOrder(
      {required int orderId, required String status});
  Future<Either<Failure, OrderDetailModel>> orderDetails(
      {required int orderId,});
  Future<Either<Failure, OrderDetailModel>> saveRideStatus(
      {required int orderId, required String status});
  Future<Either<Failure, CommonResponse>> cancelRide({required int? orderId});
  Future<Either<Failure, TripModel>> checkActiveTrip();

}
