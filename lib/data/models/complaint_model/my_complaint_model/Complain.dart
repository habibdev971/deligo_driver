class Complain {
  Complain({
      this.id, 
      this.title, 
      this.category, 
      this.priority,});

  Complain.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    category = json['category'];
    priority = json['priority'];
  }
  num? id;
  String? title;
  String? category;
  String? priority;
Complain copyWith({  num? id,
  String? title,
  String? category,
  String? priority,
}) => Complain(  id: id ?? this.id,
  title: title ?? this.title,
  category: category ?? this.category,
  priority: priority ?? this.priority,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['category'] = category;
    map['priority'] = priority;
    return map;
  }

}