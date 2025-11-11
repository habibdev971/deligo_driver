import 'package:dartz/dartz.dart';
import 'package:deligo_driver/data/models/complaint_model/ComplaintTypeModel.dart';
import 'package:deligo_driver/data/models/complaint_model/my_complaint_model/MyComplientModel.dart';

import '../../../core/errors/failure.dart';
import '../../models/common_response.dart';

abstract class IComplaintRepo {
  Future<Either<Failure, MyCompliantModel>> getMyComplaintData({required Map<String, dynamic> params});
  Future<Either<Failure, CommonResponse>> createComplaint({ required num? orderId, required Map<String, dynamic> data});
  Future<Either<Failure, ComplaintTypeModel>> getComplaintTypes();
}
