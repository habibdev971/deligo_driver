import 'Complain.dart';
import 'Ride.dart';

class Complains {
  Complains({
      this.id, 
      this.rideId, 
      this.complainId, 
      this.userId, 
      this.driverId, 
      this.message, 
      this.status, 
      this.priority, 
      this.createdById, 
      this.createdAt, 
      this.updatedAt, 
      this.deletedAt, 
      this.complain, 
      this.ride,});

  Complains.fromJson(dynamic json) {
    id = json['id'];
    rideId = json['rideId'];
    complainId = json['complainId'];
    userId = json['userId'];
    driverId = json['driverId'];
    message = json['message'];
    status = json['status'];
    priority = json['priority'];
    createdById = json['createdById'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    complain = json['complain'] != null ? Complain.fromJson(json['complain']) : null;
    ride = json['ride'] != null ? Ride.fromJson(json['ride']) : null;
  }
  num? id;
  num? rideId;
  num? complainId;
  num? userId;
  num? driverId;
  String? message;
  String? status;
  String? priority;
  num? createdById;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  Complain? complain;
  Ride? ride;
Complains copyWith({  num? id,
  num? rideId,
  num? complainId,
  num? userId,
  num? driverId,
  String? message,
  String? status,
  String? priority,
  num? createdById,
  String? createdAt,
  String? updatedAt,
  String? deletedAt,
  Complain? complain,
  Ride? ride,
}) => Complains(  id: id ?? this.id,
  rideId: rideId ?? this.rideId,
  complainId: complainId ?? this.complainId,
  userId: userId ?? this.userId,
  driverId: driverId ?? this.driverId,
  message: message ?? this.message,
  status: status ?? this.status,
  priority: priority ?? this.priority,
  createdById: createdById ?? this.createdById,
  createdAt: createdAt ?? this.createdAt,
  updatedAt: updatedAt ?? this.updatedAt,
  deletedAt: deletedAt ?? this.deletedAt,
  complain: complain ?? this.complain,
  ride: ride ?? this.ride,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['rideId'] = rideId;
    map['complainId'] = complainId;
    map['userId'] = userId;
    map['driverId'] = driverId;
    map['message'] = message;
    map['status'] = status;
    map['priority'] = priority;
    map['createdById'] = createdById;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['deletedAt'] = deletedAt;
    if (complain != null) {
      map['complain'] = complain?.toJson();
    }
    if (ride != null) {
      map['ride'] = ride?.toJson();
    }
    return map;
  }

}