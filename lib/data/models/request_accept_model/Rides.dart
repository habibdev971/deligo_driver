class Rides {
  Rides({
      this.id, 
      this.rideRequestId, 
      this.driverId, 
      this.userId,});

  Rides.fromJson(dynamic json) {
    id = json['id'];
    rideRequestId = json['rideRequestId'];
    driverId = json['driverId'];
    userId = json['userId'];
  }
  String? id;
  String? rideRequestId;
  String? driverId;
  String? userId;
Rides copyWith({  String? id,
  String? rideRequestId,
  String? driverId,
  String? userId,
}) => Rides(  id: id ?? this.id,
  rideRequestId: rideRequestId ?? this.rideRequestId,
  driverId: driverId ?? this.driverId,
  userId: userId ?? this.userId,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['rideRequestId'] = rideRequestId;
    map['driverId'] = driverId;
    map['userId'] = userId;
    return map;
  }

}