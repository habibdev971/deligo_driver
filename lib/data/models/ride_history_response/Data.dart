
import '../ride_details_model/RideDetailsModel.dart';
import 'Pagination.dart';

class Data {
  Data({
      this.rideRequests, 
      this.pagination,});

  Data.fromJson(dynamic json) {
    if (json['rideRequests'] != null) {
      rideRequests = [];
      json['rideRequests'].forEach((v) {
        rideRequests?.add(RideRequest.fromJson(v));
      });
    }
    pagination = json['pagination'] != null ? Pagination.fromJson(json['pagination']) : null;
  }
  List<RideRequest>? rideRequests;
  Pagination? pagination;
Data copyWith({  List<RideRequest>? rideRequests,
  Pagination? pagination,
}) => Data(  rideRequests: rideRequests ?? this.rideRequests,
  pagination: pagination ?? this.pagination,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (rideRequests != null) {
      map['rideRequests'] = rideRequests?.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      map['pagination'] = pagination?.toJson();
    }
    return map;
  }

}