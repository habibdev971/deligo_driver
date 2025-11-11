class Pagination {
  Pagination({
      this.total, 
      this.page, 
      this.limit, 
      this.pages,});

  Pagination.fromJson(dynamic json) {
    total = json['total'];
    page = json['page'];
    limit = json['limit'];
    pages = json['pages'];
  }
  num? total;
  num? page;
  num? limit;
  num? pages;
Pagination copyWith({  num? total,
  num? page,
  num? limit,
  num? pages,
}) => Pagination(  total: total ?? this.total,
  page: page ?? this.page,
  limit: limit ?? this.limit,
  pages: pages ?? this.pages,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total'] = total;
    map['page'] = page;
    map['limit'] = limit;
    map['pages'] = pages;
    return map;
  }

}