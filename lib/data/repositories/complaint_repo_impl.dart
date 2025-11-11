import 'package:dartz/dartz.dart';
import 'package:deligo_driver/data/models/complaint_model/ComplaintTypeModel.dart';
import 'package:deligo_driver/data/repositories/interfaces/complaint_repo_interface.dart';
import 'package:deligo_driver/domain/interfaces/complaint_service_interface.dart';

import '../../core/errors/failure.dart';
import '../models/common_response.dart';
import '../models/complaint_model/my_complaint_model/MyComplientModel.dart';
import 'base_repository.dart';

class ComplaintRepoImpl extends BaseRepository implements IComplaintRepo {
  final IComplaintService service;

  ComplaintRepoImpl({required this.service});

  @override
  Future<Either<Failure, MyCompliantModel>> getMyComplaintData({required Map<String, dynamic> params}) async => await safeApiCall(()async {
      final response = await service.getMyComplaintData(params: params);
      return MyCompliantModel.fromJson(response.data);
    });

  @override
  Future<Either<Failure, CommonResponse>> createComplaint({required num? orderId, required Map<String, dynamic> data}) async => await safeApiCall(()async{
      final response = await service.createComplaint(data: data, orderId: orderId);
      return CommonResponse.fromJson(response.data);
    });

  @override
  Future<Either<Failure, ComplaintTypeModel>> getComplaintTypes() async => await safeApiCall(()async{
      final response = await service.getComplaintTypes();
      return ComplaintTypeModel.fromJson(response.data);
    });
}
