class Sender {
  Sender({
      this.id, 
      this.firstName, 
      this.lastName,});

  Sender.fromJson(dynamic json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
  }
  num? id;
  String? firstName;
  String? lastName;
Sender copyWith({  num? id,
  String? firstName,
  String? lastName,
}) => Sender(  id: id ?? this.id,
  firstName: firstName ?? this.firstName,
  lastName: lastName ?? this.lastName,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    return map;
  }

}