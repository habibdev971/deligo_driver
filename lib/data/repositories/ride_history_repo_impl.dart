import 'dart:developer';

import 'package:dartz/dartz.dart';

import '../../core/errors/failure.dart';
import '../../domain/interfaces/ride_history_service_interface.dart';
import '../models/ride_history_response/RideHistoryModel.dart';
import 'base_repository.dart';
import 'interfaces/ride_history_repo_interface.dart';

class RideHistoryRepoImpl extends BaseRepository implements IRideHistoryRepo {
  final IRideHistoryService rideHistoryService;

  RideHistoryRepoImpl({required this.rideHistoryService});

  @override
  Future<Either<Failure, RideHistoryModel>> getRideHistory({required Map<String, dynamic> params}) async => await safeApiCall(()async{
      final response = await rideHistoryService.getRideHistory(params: params);
      try {
        return RideHistoryModel.fromJson(response.data);
      } catch (e) {
        log('Error converting: $e');
        throw Exception('Parsing error');
      }

    });}