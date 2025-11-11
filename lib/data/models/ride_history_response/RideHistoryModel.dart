import 'Data.dart';

class RideHistoryModel {
  RideHistoryModel({
      this.status, 
      this.message, 
      this.data,});

  RideHistoryModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? status;
  String? message;
  Data? data;
RideHistoryModel copyWith({  String? status,
  String? message,
  Data? data,
}) => RideHistoryModel(  status: status ?? this.status,
  message: message ?? this.message,
  data: data ?? this.data,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}