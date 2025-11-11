import 'package:dartz/dartz.dart';
import '../../../core/errors/failure.dart';
import '../../models/ride_history_response/RideHistoryModel.dart';

abstract class IRideHistoryRepo {
  Future<Either<Failure, RideHistoryModel>> getRideHistory({required Map<String, dynamic> params});
}
