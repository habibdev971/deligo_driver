import 'sender.dart';

class ChatMessage {
  ChatMessage({
      this.id, 
      this.rideId, 
      this.senderId, 
      this.message, 
      this.createdAt, 
      this.sender, 
      this.senderRole,});

  ChatMessage.fromJson(dynamic json) {
    id = json['id'];
    rideId = json['rideId'];
    senderId = json['senderId'];
    message = json['message'];
    createdAt = json['createdAt'];
    sender = json['sender'] != null ? Sender.fromJson(json['sender']) : null;
    senderRole = json['senderRole'];
  }
  num? id;
  num? rideId;
  num? senderId;
  String? message;
  String? createdAt;
  Sender? sender;
  String? senderRole;
ChatMessage copyWith({  num? id,
  num? rideId,
  num? senderId,
  String? message,
  String? createdAt,
  Sender? sender,
  String? senderRole,
}) => ChatMessage(  id: id ?? this.id,
  rideId: rideId ?? this.rideId,
  senderId: senderId ?? this.senderId,
  message: message ?? this.message,
  createdAt: createdAt ?? this.createdAt,
  sender: sender ?? this.sender,
  senderRole: senderRole ?? this.senderRole,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['rideId'] = rideId;
    map['senderId'] = senderId;
    map['message'] = message;
    map['createdAt'] = createdAt;
    if (sender != null) {
      map['sender'] = sender?.toJson();
    }
    map['senderRole'] = senderRole;
    return map;
  }

}