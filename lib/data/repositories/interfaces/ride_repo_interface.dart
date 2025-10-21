import 'package:dartz/dartz.dart';
import 'package:deligo_driver/data/models/order_response/order_detail/order_detail_model.dart';
import 'package:deligo_driver/data/models/ride_details_model/RideDetailsModel.dart';
import '../../../core/errors/failure.dart';
import '../../models/common_response.dart';
import '../../models/order_response/tip_model/trip_model.dart';
import '../../models/request_accept_model/OrderAcceptModel.dart';

abstract class IRideRepo {
  Future<Either<Failure, OrderDetailModel>> rideOrder(
      {required int orderId, required String status});
  Future<Either<Failure, OrderDetailModel>> orderDetails(
      {required int orderId,});
  Future<Either<Failure, OrderDetailModel>> saveRideStatus(
      {required int orderId, required String status});
  Future<Either<Failure, CommonResponse>> cancelRide({required int? orderId});
  Future<Either<Failure, TripModel>> checkActiveTrip();
  Future<Either<Failure, OrderAcceptModel>> acceptRejectRide({required int orderId, required String status});
  Future<Either<Failure, RideDetailsModel>> rideDetail({required int? orderId});
  Future<Either<Failure, CommonResponse>> saveOrderStatus({required num? orderId, required String status, bool sendOtherData = false});

}
