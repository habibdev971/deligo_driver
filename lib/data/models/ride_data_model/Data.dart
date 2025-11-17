import 'Driver.dart';

class Data {
  Data({
      this.driver,});

  Data.fromJson(dynamic json) {
    driver = json['driver'] != null ? RideDataCount.fromJson(json['driver']) : null;
  }
  RideDataCount? driver;
Data copyWith({  RideDataCount? driver,
}) => Data(  driver: driver ?? this.driver,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (driver != null) {
      map['driver'] = driver?.toJson();
    }
    return map;
  }

}