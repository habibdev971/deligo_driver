class ComplaintType {
  ComplaintType({
      this.id, 
      this.title, 
      this.slug, 
      this.description, 
      this.lnTitle, 
      this.lnDescription, 
      this.category, 
      this.priority, 
      this.status, 
      this.sortOrder, 
      this.createdById, 
      this.createdAt, 
      this.updatedAt, 
      this.deletedAt,});

  ComplaintType.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    description = json['description'];
    lnTitle = json['lnTitle'];
    lnDescription = json['lnDescription'];
    category = json['category'];
    priority = json['priority'];
    status = json['status'];
    sortOrder = json['sortOrder'];
    createdById = json['createdById'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
  }
  num? id;
  String? title;
  String? slug;
  String? description;
  String? lnTitle;
  String? lnDescription;
  String? category;
  String? priority;
  bool? status;
  num? sortOrder;
  num? createdById;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
ComplaintType copyWith({  num? id,
  String? title,
  String? slug,
  String? description,
  String? lnTitle,
  String? lnDescription,
  String? category,
  String? priority,
  bool? status,
  num? sortOrder,
  num? createdById,
  String? createdAt,
  String? updatedAt,
  String? deletedAt,
}) => ComplaintType(  id: id ?? this.id,
  title: title ?? this.title,
  slug: slug ?? this.slug,
  description: description ?? this.description,
  lnTitle: lnTitle ?? this.lnTitle,
  lnDescription: lnDescription ?? this.lnDescription,
  category: category ?? this.category,
  priority: priority ?? this.priority,
  status: status ?? this.status,
  sortOrder: sortOrder ?? this.sortOrder,
  createdById: createdById ?? this.createdById,
  createdAt: createdAt ?? this.createdAt,
  updatedAt: updatedAt ?? this.updatedAt,
  deletedAt: deletedAt ?? this.deletedAt,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['slug'] = slug;
    map['description'] = description;
    map['lnTitle'] = lnTitle;
    map['lnDescription'] = lnDescription;
    map['category'] = category;
    map['priority'] = priority;
    map['status'] = status;
    map['sortOrder'] = sortOrder;
    map['createdById'] = createdById;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['deletedAt'] = deletedAt;
    return map;
  }

}