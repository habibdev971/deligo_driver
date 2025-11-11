import 'Data.dart';

class MyCompliantModel {
  MyCompliantModel({
      this.status, 
      this.message, 
      this.data,});

  MyCompliantModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? status;
  String? message;
  Data? data;
MyCompliantModel copyWith({  String? status,
  String? message,
  Data? data,
}) => MyCompliantModel(  status: status ?? this.status,
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