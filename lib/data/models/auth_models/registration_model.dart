/// status : "success"
/// error : null
/// message : "Registration successful. Please verify your phone number"
/// data : {"user":{"id":42,"firstName":"Arina","lastName":"zaman","fullName":"Arina zaman","email":"arina@zaman.com","phoneNumber":"+8801560063093","status":false,"isVerified":true},"token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjQyLCJpYXQiOjE3NTc5NjAzNTAsImV4cCI6MTc4OTQ5NjM1MH0.NJmw1cdFN3iBAc0JP1qIiqWev4-l2Yc5DhDuQhsJ0mk","sessionToken":"74571233-4444-4729-b85c-d3dfa0aa0a4f"}
library;

class RegistrationModel {
  RegistrationModel({
    String? status,
    dynamic error,
    String? message,
    Data? data,}){
    _status = status;
    _error = error;
    _message = message;
    _data = data;
  }

  RegistrationModel.fromJson(dynamic json) {
    _status = json['status'];
    _error = json['error'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? _status;
  dynamic _error;
  String? _message;
  Data? _data;
  RegistrationModel copyWith({  String? status,
    dynamic error,
    String? message,
    Data? data,
  }) => RegistrationModel(  status: status ?? _status,
    error: error ?? _error,
    message: message ?? _message,
    data: data ?? _data,
  );
  String? get status => _status;
  dynamic get error => _error;
  String? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['error'] = _error;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// user : {"id":42,"firstName":"Arina","lastName":"zaman","fullName":"Arina zaman","email":"arina@zaman.com","phoneNumber":"+8801560063093","status":false,"isVerified":true}
/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjQyLCJpYXQiOjE3NTc5NjAzNTAsImV4cCI6MTc4OTQ5NjM1MH0.NJmw1cdFN3iBAc0JP1qIiqWev4-l2Yc5DhDuQhsJ0mk"
/// sessionToken : "74571233-4444-4729-b85c-d3dfa0aa0a4f"

class Data {
  Data({
    User? user,
    String? token,
    String? sessionToken,}){
    _user = user;
    _token = token;
    _sessionToken = sessionToken;
  }

  Data.fromJson(dynamic json) {
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _token = json['token'];
    _sessionToken = json['sessionToken'];
  }
  User? _user;
  String? _token;
  String? _sessionToken;
  Data copyWith({  User? user,
    String? token,
    String? sessionToken,
  }) => Data(  user: user ?? _user,
    token: token ?? _token,
    sessionToken: sessionToken ?? _sessionToken,
  );
  User? get user => _user;
  String? get token => _token;
  String? get sessionToken => _sessionToken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    map['token'] = _token;
    map['sessionToken'] = _sessionToken;
    return map;
  }

}

/// id : 42
/// firstName : "Arina"
/// lastName : "zaman"
/// fullName : "Arina zaman"
/// email : "arina@zaman.com"
/// phoneNumber : "+8801560063093"
/// status : false
/// isVerified : true

class User {
  User({
    num? id,
    String? firstName,
    String? lastName,
    String? fullName,
    String? email,
    String? phoneNumber,
    bool? status,
    bool? isVerified,}){
    _id = id;
    _firstName = firstName;
    _lastName = lastName;
    _fullName = fullName;
    _email = email;
    _phoneNumber = phoneNumber;
    _status = status;
    _isVerified = isVerified;
  }

  User.fromJson(dynamic json) {
    _id = json['id'];
    _firstName = json['firstName'];
    _lastName = json['lastName'];
    _fullName = json['fullName'];
    _email = json['email'];
    _phoneNumber = json['phoneNumber'];
    _status = json['status'];
    _isVerified = json['isVerified'];
  }
  num? _id;
  String? _firstName;
  String? _lastName;
  String? _fullName;
  String? _email;
  String? _phoneNumber;
  bool? _status;
  bool? _isVerified;
  User copyWith({  num? id,
    String? firstName,
    String? lastName,
    String? fullName,
    String? email,
    String? phoneNumber,
    bool? status,
    bool? isVerified,
  }) => User(  id: id ?? _id,
    firstName: firstName ?? _firstName,
    lastName: lastName ?? _lastName,
    fullName: fullName ?? _fullName,
    email: email ?? _email,
    phoneNumber: phoneNumber ?? _phoneNumber,
    status: status ?? _status,
    isVerified: isVerified ?? _isVerified,
  );
  num? get id => _id;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get fullName => _fullName;
  String? get email => _email;
  String? get phoneNumber => _phoneNumber;
  bool? get status => _status;
  bool? get isVerified => _isVerified;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['firstName'] = _firstName;
    map['lastName'] = _lastName;
    map['fullName'] = _fullName;
    map['email'] = _email;
    map['phoneNumber'] = _phoneNumber;
    map['status'] = _status;
    map['isVerified'] = _isVerified;
    return map;
  }

}

// /// info : "OTP for 01774142172: 484447"
// /// message : "Registration initiated. OTP sent to your phone"
// /// userId : 3
//
// class RegistrationModel {
//   RegistrationModel({
//       String? info,
//       String? message,
//       num? userId,}){
//     _info = info;
//     _message = message;
//     _userId = userId;
// }
//
//   RegistrationModel.fromJson(dynamic json) {
//     _info = json['info'];
//     _message = json['message'];
//     _userId = json['userId'];
//   }
//   String? _info;
//   String? _message;
//   num? _userId;
// RegistrationModel copyWith({  String? info,
//   String? message,
//   num? userId,
// }) => RegistrationModel(  info: info ?? _info,
//   message: message ?? _message,
//   userId: userId ?? _userId,
// );
//   String? get info => _info;
//   String? get message => _message;
//   num? get userId => _userId;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['info'] = _info;
//     map['message'] = _message;
//     map['userId'] = _userId;
//     return map;
//   }
//
// }