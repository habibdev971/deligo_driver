
import 'package:dartz/dartz.dart';
import 'package:deligo_driver/data/models/dashboard_model/dashboard_model.dart';

import '../../../core/errors/failure.dart';

abstract class IDashboardRepository {
  Future<Either<Failure, DashboardModel>> getDashboard();
}