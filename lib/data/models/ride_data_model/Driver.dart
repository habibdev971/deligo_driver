class RideDataCount {
  RideDataCount({
      this.id, 
      this.userId, 
      this.status, 
      this.rideCount, 
      this.cancelCount, 
      this.averageRating, 
      this.isLicenseVerified, 
      this.fleetManagerId, 
      this.isNotifiable, 
      this.isOnTrip, 
      this.totalDistance, 
      this.createdAt, 
      this.updatedAt,});

  RideDataCount.fromJson(dynamic json) {
    id = json['id'];
    userId = json['userId'];
    status = json['status'];
    rideCount = json['rideCount'];
    cancelCount = json['cancelCount'];
    averageRating = json['averageRating'];
    isLicenseVerified = json['isLicenseVerified'];
    fleetManagerId = json['fleetManagerId'];
    isNotifiable = json['isNotifiable'];
    isOnTrip = json['isOnTrip'];
    totalDistance = json['totalDistance'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }
  num? id;
  num? userId;
  String? status;
  num? rideCount;
  num? cancelCount;
  num? averageRating;
  bool? isLicenseVerified;
  num? fleetManagerId;
  bool? isNotifiable;
  bool? isOnTrip;
  num? totalDistance;
  String? createdAt;
  String? updatedAt;
RideDataCount copyWith({  num? id,
  num? userId,
  String? status,
  num? rideCount,
  num? cancelCount,
  num? averageRating,
  bool? isLicenseVerified,
  num? fleetManagerId,
  bool? isNotifiable,
  bool? isOnTrip,
  num? totalDistance,
  String? createdAt,
  String? updatedAt,
}) => RideDataCount(  id: id ?? this.id,
  userId: userId ?? this.userId,
  status: status ?? this.status,
  rideCount: rideCount ?? this.rideCount,
  cancelCount: cancelCount ?? this.cancelCount,
  averageRating: averageRating ?? this.averageRating,
  isLicenseVerified: isLicenseVerified ?? this.isLicenseVerified,
  fleetManagerId: fleetManagerId ?? this.fleetManagerId,
  isNotifiable: isNotifiable ?? this.isNotifiable,
  isOnTrip: isOnTrip ?? this.isOnTrip,
  totalDistance: totalDistance ?? this.totalDistance,
  createdAt: createdAt ?? this.createdAt,
  updatedAt: updatedAt ?? this.updatedAt,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['userId'] = userId;
    map['status'] = status;
    map['rideCount'] = rideCount;
    map['cancelCount'] = cancelCount;
    map['averageRating'] = averageRating;
    map['isLicenseVerified'] = isLicenseVerified;
    map['fleetManagerId'] = fleetManagerId;
    map['isNotifiable'] = isNotifiable;
    map['isOnTrip'] = isOnTrip;
    map['totalDistance'] = totalDistance;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    return map;
  }

}