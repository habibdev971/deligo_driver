

import 'chat_message_model.dart';

class GetMessageModel {
  GetMessageModel({
      this.status, 
      this.message, 
      this.data,});

  GetMessageModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ChatMessage.fromJson(v));
      });
    }
  }
  String? status;
  String? message;
  List<ChatMessage>? data;
GetMessageModel copyWith({  String? status,
  String? message,
  List<ChatMessage>? data,
}) => GetMessageModel(  status: status ?? this.status,
  message: message ?? this.message,
  data: data ?? this.data,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}