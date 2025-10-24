import 'AdditionInfo.dart';

class User {
  User({
      this.id, 
      this.email, 
      this.firstName, 
      this.lastName, 
      this.fullName, 
      this.identityCode, 
      this.userType, 
      this.phoneNumber, 
      this.roleId, 
      this.isVerified, 
      this.lang, 
      this.totalRides, 
      this.averageRating, 
      this.status, 
      this.serviceStatus, 
      this.firebaseUid, 
      this.isNotifyable, 
      this.isSmsNotifyable, 
      this.additionInfo, 
      this.createdAt, 
      this.updatedAt, 
      this.updatedBy,});

  User.fromJson(dynamic json) {
    id = json['id'];
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    fullName = json['fullName'];
    identityCode = json['identityCode'];
    userType = json['userType'];
    phoneNumber = json['phoneNumber'];
    roleId = json['roleId'];
    isVerified = json['isVerified'];
    lang = json['lang'];
    totalRides = json['totalRides'];
    averageRating = json['averageRating'];
    status = json['status'];
    serviceStatus = json['serviceStatus'];
    firebaseUid = json['firebaseUid'];
    isNotifyable = json['isNotifyable'];
    isSmsNotifyable = json['isSmsNotifyable'];
    additionInfo = json['additionInfo'] != null ? AdditionInfo.fromJson(json['additionInfo']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    updatedBy = json['updatedBy'];
  }
  num? id;
  String? email;
  String? firstName;
  String? lastName;
  String? fullName;
  String? identityCode;
  String? userType;
  String? phoneNumber;
  dynamic roleId;
  bool? isVerified;
  String? lang;
  num? totalRides;
  num? averageRating;
  bool? status;
  bool? serviceStatus;
  String? firebaseUid;
  bool? isNotifyable;
  bool? isSmsNotifyable;
  AdditionInfo? additionInfo;
  String? createdAt;
  String? updatedAt;
  num? updatedBy;
User copyWith({  num? id,
  String? email,
  String? firstName,
  String? lastName,
  String? fullName,
  String? identityCode,
  String? userType,
  String? phoneNumber,
  dynamic roleId,
  bool? isVerified,
  String? lang,
  num? totalRides,
  num? averageRating,
  bool? status,
  bool? serviceStatus,
  String? firebaseUid,
  bool? isNotifyable,
  bool? isSmsNotifyable,
  AdditionInfo? additionInfo,
  String? createdAt,
  String? updatedAt,
  num? updatedBy,
}) => User(  id: id ?? this.id,
  email: email ?? this.email,
  firstName: firstName ?? this.firstName,
  lastName: lastName ?? this.lastName,
  fullName: fullName ?? this.fullName,
  identityCode: identityCode ?? this.identityCode,
  userType: userType ?? this.userType,
  phoneNumber: phoneNumber ?? this.phoneNumber,
  roleId: roleId ?? this.roleId,
  isVerified: isVerified ?? this.isVerified,
  lang: lang ?? this.lang,
  totalRides: totalRides ?? this.totalRides,
  averageRating: averageRating ?? this.averageRating,
  status: status ?? this.status,
  serviceStatus: serviceStatus ?? this.serviceStatus,
  firebaseUid: firebaseUid ?? this.firebaseUid,
  isNotifyable: isNotifyable ?? this.isNotifyable,
  isSmsNotifyable: isSmsNotifyable ?? this.isSmsNotifyable,
  additionInfo: additionInfo ?? this.additionInfo,
  createdAt: createdAt ?? this.createdAt,
  updatedAt: updatedAt ?? this.updatedAt,
  updatedBy: updatedBy ?? this.updatedBy,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['email'] = email;
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['fullName'] = fullName;
    map['identityCode'] = identityCode;
    map['userType'] = userType;
    map['phoneNumber'] = phoneNumber;
    map['roleId'] = roleId;
    map['isVerified'] = isVerified;
    map['lang'] = lang;
    map['totalRides'] = totalRides;
    map['averageRating'] = averageRating;
    map['status'] = status;
    map['serviceStatus'] = serviceStatus;
    map['firebaseUid'] = firebaseUid;
    map['isNotifyable'] = isNotifyable;
    map['isSmsNotifyable'] = isSmsNotifyable;
    if (additionInfo != null) {
      map['additionInfo'] = additionInfo?.toJson();
    }
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['updatedBy'] = updatedBy;
    return map;
  }

}