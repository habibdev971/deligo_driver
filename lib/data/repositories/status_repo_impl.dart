import 'package:dartz/dartz.dart';
import 'package:deligo_driver/core/errors/failure.dart';
import 'package:deligo_driver/data/models/driver_radius_update_response/driver_radius_update_response.dart';
import 'package:deligo_driver/data/models/online_status_update_response/online_status_update_response.dart';
import 'package:deligo_driver/data/repositories/base_repository.dart';
import 'package:deligo_driver/data/repositories/interfaces/status_repo_interface.dart';
import 'package:deligo_driver/domain/interfaces/status_service_interface.dart';

class StatusRepoImpl extends BaseRepository implements IStatusRepo {
  final IStatusService statusService;

  StatusRepoImpl({required this.statusService});

  @override
  Future<Either<Failure, OnlineStatusUpdateResponse>> updateOnlineStatus(
      {required bool status}) async => await safeApiCall(() async {
      // final data = status[0].toUpperCase() + status.substring(1);
      final response = await statusService.updateOnlineStatus(status: status);
      return OnlineStatusUpdateResponse.fromJson(response.data);
    });

  @override
  Future<Either<Failure, DriverRadiusUpdateResponse>> updateRadius(
      {required int radius}) async => await safeApiCall(() async {
      final response = await statusService.updateRadius(radius: radius);
      return DriverRadiusUpdateResponse.fromMap(response.data);
    });
}
