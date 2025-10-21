import 'Rides.dart';

class Data {
  Data({
      this.rides,});

  Data.fromJson(dynamic json) {
    rides = json['rides'] != null ? Rides.fromJson(json['rides']) : null;
  }
  Rides? rides;
Data copyWith({  Rides? rides,
}) => Data(  rides: rides ?? this.rides,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (rides != null) {
      map['rides'] = rides?.toJson();
    }
    return map;
  }

}