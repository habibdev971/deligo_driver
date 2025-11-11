class Pagination {
  Pagination({
      this.page, 
      this.limit, 
      this.total, 
      this.totalPages,});

  Pagination.fromJson(dynamic json) {
    page = json['page'];
    limit = json['limit'];
    total = json['total'];
    totalPages = json['totalPages'];
  }
  num? page;
  num? limit;
  num? total;
  num? totalPages;
Pagination copyWith({  num? page,
  num? limit,
  num? total,
  num? totalPages,
}) => Pagination(  page: page ?? this.page,
  limit: limit ?? this.limit,
  total: total ?? this.total,
  totalPages: totalPages ?? this.totalPages,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['page'] = page;
    map['limit'] = limit;
    map['total'] = total;
    map['totalPages'] = totalPages;
    return map;
  }

}