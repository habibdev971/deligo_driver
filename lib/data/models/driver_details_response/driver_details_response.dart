import '../user_model/user_model.dart';

class DriverDetailsResponse {
  DriverDetailsResponse({
    this.message,
    this.data,});

  DriverDetailsResponse.fromJson(dynamic json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? message;
  Data? data;
  DriverDetailsResponse copyWith({  String? message,
    Data? data,
  }) => DriverDetailsResponse(  message: message ?? this.message,
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
    this.user,
    this.token,});

  Data.fromJson(dynamic json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    token = json['token'];
  }
  User? user;
  String? token;
  Data copyWith({  User? user,
    String? token,
  }) => Data(  user: user ?? this.user,
    token: token ?? this.token,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (user != null) {
      map['user'] = user?.toJson();
    }
    map['token'] = token;
    return map;
  }

}

