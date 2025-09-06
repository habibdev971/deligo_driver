class OnlineStatusUpdateResponse {
  OnlineStatusUpdateResponse({
    this.message,
    this.data,});

  OnlineStatusUpdateResponse.fromJson(dynamic json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? message;
  Data? data;
  OnlineStatusUpdateResponse copyWith({  String? message,
    Data? data,
  }) => OnlineStatusUpdateResponse(  message: message ?? this.message,
    data: data ?? this.data,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

class Data {
  Data({
    this.status,});

  Data.fromJson(dynamic json) {
    status = json['status'];
  }
  String? status;
  Data copyWith({  String? status,
  }) => Data(  status: status ?? this.status,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    return map;
  }

}