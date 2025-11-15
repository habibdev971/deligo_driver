
class UserExistenceModel {
  UserExistenceModel({
      String? status, 
      dynamic error, 
      String? message, 
      ExistenceData? data,}){
    _status = status;
    _error = error;
    _message = message;
    _data = data;
}

  UserExistenceModel.fromJson(dynamic json) {
    _status = json['status'];
    _error = json['error'];
    _message = json['message'];
    _data = json['data'] != null ? ExistenceData.fromJson(json['data']) : null;
  }
  String? _status;
  dynamic _error;
  String? _message;
  ExistenceData? _data;
UserExistenceModel copyWith({  String? status,
  dynamic error,
  String? message,
  ExistenceData? data,
}) => UserExistenceModel(  status: status ?? _status,
  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  String? get status => _status;
  dynamic get error => _error;
  String? get message => _message;
  ExistenceData? get data => _data;

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

class ExistenceData {
  ExistenceData({
      bool? isNew,
      bool? isDriver,
      bool? isLicenseVerified,
      User? user,}){
    _isNew = isNew;
    _isDriver = isDriver;
    _isLicenseVerified = isLicenseVerified;
    _user = user;
}

  ExistenceData.fromJson(dynamic json) {
    _isNew = json['isNew'];
    _isDriver = json['isDriver'];
    _isLicenseVerified = json['isLicenseVerified'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  bool? _isNew;
  bool? _isDriver;
  bool? _isLicenseVerified;
  User? _user;
ExistenceData copyWith({  bool? isNew,
  bool? isDriver,
  bool? isLicenseVerified,
  User? user,
}) => ExistenceData(  isNew: isNew ?? _isNew,
  isDriver: isDriver ?? _isDriver,
  isLicenseVerified: isLicenseVerified ?? _isLicenseVerified,
  user: user ?? _user,
);
  bool? get isNew => _isNew;
  bool? get isDriver => _isDriver;
  bool? get isLicenseVerified => _isLicenseVerified;
  User? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['isNew'] = _isNew;
    map['isDriver'] = _isDriver;
    map['isLicenseVerified'] = _isLicenseVerified;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }

}

class User {
  User({
      num? id, 
      String? email, 
      String? firstName, 
      String? lastName, 
      String? fullName, 
      String? identityCode, 
      String? userType, 
      String? phoneNumber, 
      String? password, 
      bool? isVerified, 
      String? lang, 
      num? totalRides, 
      num? averageRating, 
      bool? status, 
      bool? serviceStatus, 
      dynamic firebaseUid, 
      AdditionInfo? additionInfo, 
      String? deletedAt, 
      String? createdAt, 
      String? updatedAt, 
      num? updatedBy,}){
    _id = id;
    _email = email;
    _firstName = firstName;
    _lastName = lastName;
    _fullName = fullName;
    _identityCode = identityCode;
    _userType = userType;
    _phoneNumber = phoneNumber;
    _password = password;
    _isVerified = isVerified;
    _lang = lang;
    _totalRides = totalRides;
    _averageRating = averageRating;
    _status = status;
    _serviceStatus = serviceStatus;
    _firebaseUid = firebaseUid;
    _additionInfo = additionInfo;
    _deletedAt = deletedAt;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _updatedBy = updatedBy;
}

  User.fromJson(dynamic json) {
    _id = json['id'];
    _email = json['email'];
    _firstName = json['firstName'];
    _lastName = json['lastName'];
    _fullName = json['fullName'];
    _identityCode = json['identityCode'];
    _userType = json['userType'];
    _phoneNumber = json['phoneNumber'];
    _password = json['password'];
    _isVerified = json['isVerified'];
    _lang = json['lang'];
    _totalRides = json['totalRides'];
    _averageRating = json['averageRating'];
    _status = json['status'];
    _serviceStatus = json['serviceStatus'];
    _firebaseUid = json['firebaseUid'];
    _additionInfo = json['additionInfo'] != null ? AdditionInfo.fromJson(json['additionInfo']) : null;
    _deletedAt = json['deletedAt'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _updatedBy = json['updatedBy'];
  }
  num? _id;
  String? _email;
  String? _firstName;
  String? _lastName;
  String? _fullName;
  String? _identityCode;
  String? _userType;
  String? _phoneNumber;
  String? _password;
  bool? _isVerified;
  String? _lang;
  num? _totalRides;
  num? _averageRating;
  bool? _status;
  bool? _serviceStatus;
  dynamic _firebaseUid;
  AdditionInfo? _additionInfo;
  String? _deletedAt;
  String? _createdAt;
  String? _updatedAt;
  num? _updatedBy;
User copyWith({  num? id,
  String? email,
  String? firstName,
  String? lastName,
  String? fullName,
  String? identityCode,
  String? userType,
  String? phoneNumber,
  String? password,
  bool? isVerified,
  String? lang,
  num? totalRides,
  num? averageRating,
  bool? status,
  bool? serviceStatus,
  dynamic firebaseUid,
  AdditionInfo? additionInfo,
  String? deletedAt,
  String? createdAt,
  String? updatedAt,
  num? updatedBy,
}) => User(  id: id ?? _id,
  email: email ?? _email,
  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  fullName: fullName ?? _fullName,
  identityCode: identityCode ?? _identityCode,
  userType: userType ?? _userType,
  phoneNumber: phoneNumber ?? _phoneNumber,
  password: password ?? _password,
  isVerified: isVerified ?? _isVerified,
  lang: lang ?? _lang,
  totalRides: totalRides ?? _totalRides,
  averageRating: averageRating ?? _averageRating,
  status: status ?? _status,
  serviceStatus: serviceStatus ?? _serviceStatus,
  firebaseUid: firebaseUid ?? _firebaseUid,
  additionInfo: additionInfo ?? _additionInfo,
  deletedAt: deletedAt ?? _deletedAt,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  updatedBy: updatedBy ?? _updatedBy,
);
  num? get id => _id;
  String? get email => _email;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get fullName => _fullName;
  String? get identityCode => _identityCode;
  String? get userType => _userType;
  String? get phoneNumber => _phoneNumber;
  String? get password => _password;
  bool? get isVerified => _isVerified;
  String? get lang => _lang;
  num? get totalRides => _totalRides;
  num? get averageRating => _averageRating;
  bool? get status => _status;
  bool? get serviceStatus => _serviceStatus;
  dynamic get firebaseUid => _firebaseUid;
  AdditionInfo? get additionInfo => _additionInfo;
  String? get deletedAt => _deletedAt;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  num? get updatedBy => _updatedBy;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['email'] = _email;
    map['firstName'] = _firstName;
    map['lastName'] = _lastName;
    map['fullName'] = _fullName;
    map['identityCode'] = _identityCode;
    map['userType'] = _userType;
    map['phoneNumber'] = _phoneNumber;
    map['password'] = _password;
    map['isVerified'] = _isVerified;
    map['lang'] = _lang;
    map['totalRides'] = _totalRides;
    map['averageRating'] = _averageRating;
    map['status'] = _status;
    map['serviceStatus'] = _serviceStatus;
    map['firebaseUid'] = _firebaseUid;
    if (_additionInfo != null) {
      map['additionInfo'] = _additionInfo?.toJson();
    }
    map['deletedAt'] = _deletedAt;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['updatedBy'] = _updatedBy;
    return map;
  }

}


class AdditionInfo {
  AdditionInfo({
      String? deviceType, 
      String? deviceToken, 
      String? referralCode, 
      String? preferredLanguage,}){
    _deviceType = deviceType;
    _deviceToken = deviceToken;
    _referralCode = referralCode;
    _preferredLanguage = preferredLanguage;
}

  AdditionInfo.fromJson(dynamic json) {
    _deviceType = json['deviceType'];
    _deviceToken = json['deviceToken'];
    _referralCode = json['referralCode'];
    _preferredLanguage = json['preferredLanguage'];
  }
  String? _deviceType;
  String? _deviceToken;
  String? _referralCode;
  String? _preferredLanguage;
AdditionInfo copyWith({  String? deviceType,
  String? deviceToken,
  String? referralCode,
  String? preferredLanguage,
}) => AdditionInfo(  deviceType: deviceType ?? _deviceType,
  deviceToken: deviceToken ?? _deviceToken,
  referralCode: referralCode ?? _referralCode,
  preferredLanguage: preferredLanguage ?? _preferredLanguage,
);
  String? get deviceType => _deviceType;
  String? get deviceToken => _deviceToken;
  String? get referralCode => _referralCode;
  String? get preferredLanguage => _preferredLanguage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['deviceType'] = _deviceType;
    map['deviceToken'] = _deviceToken;
    map['referralCode'] = _referralCode;
    map['preferredLanguage'] = _preferredLanguage;
    return map;
  }

}