import 'chat_message_model.dart';

class SendMessageModel {
  SendMessageModel({
    this.status,
    this.message,
    this.data,});

  SendMessageModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? ChatMessage.fromJson(json['data']) : null;
  }
  String? status;
  String? message;
  ChatMessage? data;
  SendMessageModel copyWith({  String? status,
    String? message,
    ChatMessage? data,
  }) => SendMessageModel(  status: status ?? this.status,
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