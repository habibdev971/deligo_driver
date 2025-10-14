/// status : "success"
/// message : "User is now inactive"
/// data : {"id":24,"firstName":"First24","lastName":"Last24","fullName":"First24 Last24","email":"user24@example.com","phoneNumber":"+88015345678923","status":true,"isVerified":true,"serviceStatus":false}
library;

class OnlineStatusUpdateResponse {
  OnlineStatusUpdateResponse({
    String? status,
    String? message,
    Data? data,}){
    _status = status;
    _message = message;
    _data = data;
  }

  OnlineStatusUpdateResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? _status;
  String? _message;
  Data? _data;
  OnlineStatusUpdateResponse copyWith({  String? status,
    String? message,
    Data? data,
  }) => OnlineStatusUpdateResponse(  status: status ?? _status,
    message: message ?? _message,
    data: data ?? _data,
  );
  String? get status => _status;
  String? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// id : 24
/// firstName : "First24"
/// lastName : "Last24"
/// fullName : "First24 Last24"
/// email : "user24@example.com"
/// phoneNumber : "+88015345678923"
/// status : true
/// isVerified : true
/// serviceStatus : false

class Data {
  Data({
    num? id,
    String? firstName,
    String? lastName,
    String? fullName,
    String? email,
    String? phoneNumber,
    bool? status,
    bool? isVerified,
    bool? serviceStatus,}){
    _id = id;
    _firstName = firstName;
    _lastName = lastName;
    _fullName = fullName;
    _email = email;
    _phoneNumber = phoneNumber;
    _status = status;
    _isVerified = isVerified;
    _serviceStatus = serviceStatus;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _firstName = json['firstName'];
    _lastName = json['lastName'];
    _fullName = json['fullName'];
    _email = json['email'];
    _phoneNumber = json['phoneNumber'];
    _status = json['status'];
    _isVerified = json['isVerified'];
    _serviceStatus = json['serviceStatus'];
  }
  num? _id;
  String? _firstName;
  String? _lastName;
  String? _fullName;
  String? _email;
  String? _phoneNumber;
  bool? _status;
  bool? _isVerified;
  bool? _serviceStatus;
  Data copyWith({  num? id,
    String? firstName,
    String? lastName,
    String? fullName,
    String? email,
    String? phoneNumber,
    bool? status,
    bool? isVerified,
    bool? serviceStatus,
  }) => Data(  id: id ?? _id,
    firstName: firstName ?? _firstName,
    lastName: lastName ?? _lastName,
    fullName: fullName ?? _fullName,
    email: email ?? _email,
    phoneNumber: phoneNumber ?? _phoneNumber,
    status: status ?? _status,
    isVerified: isVerified ?? _isVerified,
    serviceStatus: serviceStatus ?? _serviceStatus,
  );
  num? get id => _id;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get fullName => _fullName;
  String? get email => _email;
  String? get phoneNumber => _phoneNumber;
  bool? get status => _status;
  bool? get isVerified => _isVerified;
  bool? get serviceStatus => _serviceStatus;

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
    map['serviceStatus'] = _serviceStatus;
    return map;
  }

}