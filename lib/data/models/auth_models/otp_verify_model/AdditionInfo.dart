class AdditionInfo {
  AdditionInfo({
      this.registeredAt,});

  AdditionInfo.fromJson(dynamic json) {
    registeredAt = json['registeredAt'];
  }
  String? registeredAt;
AdditionInfo copyWith({  String? registeredAt,
}) => AdditionInfo(  registeredAt: registeredAt ?? this.registeredAt,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['registeredAt'] = registeredAt;
    return map;
  }

}