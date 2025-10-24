import 'User.dart';

class Data {
  Data({
      this.user, 
      this.token, 
      this.refreshToken,});

  Data.fromJson(dynamic json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    token = json['token'];
    refreshToken = json['refreshToken'];
  }
  User? user;
  String? token;
  String? refreshToken;
Data copyWith({  User? user,
  String? token,
  String? refreshToken,
}) => Data(  user: user ?? this.user,
  token: token ?? this.token,
  refreshToken: refreshToken ?? this.refreshToken,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (user != null) {
      map['user'] = user?.toJson();
    }
    map['token'] = token;
    map['refreshToken'] = refreshToken;
    return map;
  }

}