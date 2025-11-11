import 'Complains.dart';
import 'Pagination.dart';

class Data {
  Data({
      this.complains, 
      this.pagination,});

  Data.fromJson(dynamic json) {
    if (json['complains'] != null) {
      complains = [];
      json['complains'].forEach((v) {
        complains?.add(Complains.fromJson(v));
      });
    }
    pagination = json['pagination'] != null ? Pagination.fromJson(json['pagination']) : null;
  }
  List<Complains>? complains;
  Pagination? pagination;
Data copyWith({  List<Complains>? complains,
  Pagination? pagination,
}) => Data(  complains: complains ?? this.complains,
  pagination: pagination ?? this.pagination,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (complains != null) {
      map['complains'] = complains?.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      map['pagination'] = pagination?.toJson();
    }
    return map;
  }

}