class Sender {
  Sender({
    this.id,
    this.name,
    this.picture
  });

  Sender.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    picture = json['picture'];
  }
  num? id;
  String? name;
  String? picture;
  Sender copyWith({  num? id,
    String? name,
    String? picture,
  }) => Sender(  id: id ?? this.id,
    name: name ?? this.name,
    picture: picture ?? this.picture,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['picture'] = picture;
    return map;
  }

}