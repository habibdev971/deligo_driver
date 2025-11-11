class Ride {
  Ride({
      this.id, 
      this.status, 
      this.actualFare,});

  Ride.fromJson(dynamic json) {
    id = json['id'];
    status = json['status'];
    actualFare = json['actualFare'];
  }
  num? id;
  String? status;
  num? actualFare;
Ride copyWith({  num? id,
  String? status,
  num? actualFare,
}) => Ride(  id: id ?? this.id,
  status: status ?? this.status,
  actualFare: actualFare ?? this.actualFare,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['status'] = status;
    map['actualFare'] = actualFare;
    return map;
  }

}