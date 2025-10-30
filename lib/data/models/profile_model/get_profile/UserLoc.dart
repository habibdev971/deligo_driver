class UserLoc {
  UserLoc({
      this.id, 
      this.userId, 
      this.location, 
      this.createdAt, 
      this.updatedAt,});

  UserLoc.fromJson(dynamic json) {
    id = json['id'];
    userId = json['userId'];
    location = json['location'] != null ? json['location'].cast<String>() : [];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }
  num? id;
  num? userId;
  List<String>? location;
  String? createdAt;
  String? updatedAt;
UserLoc copyWith({  num? id,
  num? userId,
  List<String>? location,
  String? createdAt,
  String? updatedAt,
}) => UserLoc(  id: id ?? this.id,
  userId: userId ?? this.userId,
  location: location ?? this.location,
  createdAt: createdAt ?? this.createdAt,
  updatedAt: updatedAt ?? this.updatedAt,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['userId'] = userId;
    map['location'] = location;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    return map;
  }

}