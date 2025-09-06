import 'package:dartz/dartz.dart';
import 'package:deligo_driver/core/errors/failure.dart';
import 'package:deligo_driver/data/models/car_color_response/car_color_response.dart';
import 'package:deligo_driver/data/models/car_model_response/car_model_response.dart';

abstract class IConfigRepository {
  Future<Either<Failure, CarModelResponse>> getCarModels();
  Future<Either<Failure, CarColorResponse>> getCarColors();
}
