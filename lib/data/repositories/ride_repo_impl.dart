import 'package:dartz/dartz.dart';
import 'package:deligo_driver/core/errors/failure.dart';
import 'package:deligo_driver/data/models/common_response.dart';
import 'package:deligo_driver/data/repositories/base_repository.dart';
import '../../domain/interfaces/ride_service_interface.dart';
import '../models/order_response/order_detail/order_detail_model.dart';
import '../models/order_response/tip_model/trip_model.dart';
import '../models/request_accept_model/OrderAcceptModel.dart';
import '../models/ride_details_model/RideDetailsModel.dart';
import 'interfaces/ride_repo_interface.dart';

class RideRepoImpl extends BaseRepository implements IRideRepo {
  final IRideService rideService;

  RideRepoImpl({required this.rideService});

  @override
  Future<Either<Failure, OrderDetailModel>> rideOrder({required int orderId, required String status}) async => await safeApiCall(()async{
      final response = await rideService.rideOrder(orderId: orderId, status: status);
      try{
        return OrderDetailModel.fromJson(response.data);
      }catch (e){
        return OrderDetailModel.fromJson(response.data);
      }
    });

  @override
  Future<Either<Failure, OrderDetailModel>> orderDetails({required int orderId}) async => await safeApiCall(()async{
      final response = await rideService.orderDetails(orderId: orderId,);
      try{
        return OrderDetailModel.fromJson(response.data);
      }catch (e){
        return OrderDetailModel.fromJson(response.data);
      }
    });

  @override
  Future<Either<Failure, OrderDetailModel>> saveRideStatus({required int orderId, required String status}) async => await safeApiCall(()async{
      final response = await rideService.saveRideStatus(orderId: orderId, status: status);
      try{
        return OrderDetailModel.fromJson(response.data);
      }catch (e){
        return OrderDetailModel.fromJson(response.data);
      }
    });

  @override
  Future<Either<Failure, CommonResponse>> cancelRide({required int? orderId}) async => await safeApiCall(()async{
      final response = await rideService.cancelRide(orderId: orderId,);
      return CommonResponse.fromJson(response.data);
    });

  @override
  Future<Either<Failure, TripModel>> checkActiveTrip() async => await safeApiCall(() async {
      final response = await rideService.checkActiveTrip();
      try{
        return TripModel.fromJson(response.data);
      }catch(e){
        return TripModel.fromJson(response.data);
      }
    });

  @override
  Future<Either<Failure, OrderAcceptModel>> acceptRejectRide({required int orderId, required String status}) async => await safeApiCall(()async{
      final response = await rideService.acceptRejectRide(orderId: orderId, status: status);
      return OrderAcceptModel.fromJson(response.data);
    });

  @override
  Future<Either<Failure, RideDetailsModel>> rideDetail({required int? orderId})async => safeApiCall(()async{
      final response = await rideService.rideDetail(orderId: orderId);
      return RideDetailsModel.fromJson(response.data);
    });

  @override
  Future<Either<Failure, CommonResponse>> saveOrderStatus({required num? orderId, required String status, bool sendOtherData = false}) async => safeApiCall(()async{
    final response = await rideService.saveOrderStatus(orderId: orderId, status: status, sendOtherData: sendOtherData);
    return CommonResponse.fromJson(response.data);
  });
}
