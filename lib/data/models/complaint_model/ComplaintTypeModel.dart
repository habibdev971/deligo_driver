import 'Data.dart';

class ComplaintTypeModel {
  ComplaintTypeModel({
      this.status, 
      this.error, 
      this.message, 
      this.data,});

  ComplaintTypeModel.fromJson(dynamic json) {
    status = json['status'];
    error = json['error'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ComplaintType.fromJson(v));
      });
    }
  }
  String? status;
  dynamic error;
  String? message;
  List<ComplaintType>? data;
ComplaintTypeModel copyWith({  String? status,
  dynamic error,
  String? message,
  List<ComplaintType>? data,
}) => ComplaintTypeModel(  status: status ?? this.status,
  error: error ?? this.error,
  message: message ?? this.message,
  data: data ?? this.data,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['error'] = error;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}