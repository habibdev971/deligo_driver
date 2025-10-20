/// rideRequestId : 21
/// userId : 22
/// pickupLocation : {"address":"ctg, Bangla, City","latitude":"23.810711","longitude":"90.412422"}
/// dropoffLocation : {"address":"murad nagar, feni, Park Ave, City","latitude":"23.750631","longitude":"90.400293"}
/// category : {"id":1,"categoryName":"Car","slug":"cab-car","lnCategoryName":"{\"en\":\"Car\",\"ar\":\"خدمة 2\",\"de\":\"Dienstleistung 2\",\"fr\":\"Service 2\"}","IconMediaId":43,"type":"type-1","serviceId":2,"moreMediaIds":[4,5,6],"baseAmount":12,"maxSeat":4,"minPerUnitCharge":1.5,"maxPerUnitCharge":3.5,"minPermuniteCharge":0.3,"maxPermuniteCharge":1.2,"minPerWeightCharge":0.7,"maxPerWeightCharge":2.3,"cancellationCharge":3,"waitingTimeCharge":0.6,"commissionType":"percentage","commissionRate":6,"createdById":null,"taxId":null,"status":true,"additionInfo":null,"sortOrder":1,"deletedAt":null,"createdAt":"2025-10-18T15:10:45.914Z","updatedAt":"2025-10-18T15:10:45.914Z","updatedBy":0}
/// distance : 6.79
/// estimatedFare : 22.38
/// estimatedTime : 14
/// distanceFromDriver : 4.49
/// user : {"id":22,"firstName":"First22","lastName":"Last22","fullName":"First22 Last22","userInfo":{"picture":"https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?t=st=1757438383~exp=1757441983~hmac=72975912e16e40f389800dcc9616849af4237b1ec9c0683201d8e1f2d03410c2&w=1480","rattings":3}}
/// timestamp : "2025-10-19T14:54:53.320Z"

class PusherRequestOrderModel {
  PusherRequestOrderModel({
      num? rideRequestId, 
      num? userId, 
      PickupLocation? pickupLocation, 
      DropoffLocation? dropoffLocation, 
      Category? category, 
      num? distance, 
      num? estimatedFare, 
      num? estimatedTime, 
      num? distanceFromDriver, 
      User? user, 
      String? timestamp,}){
    _rideRequestId = rideRequestId;
    _userId = userId;
    _pickupLocation = pickupLocation;
    _dropoffLocation = dropoffLocation;
    _category = category;
    _distance = distance;
    _estimatedFare = estimatedFare;
    _estimatedTime = estimatedTime;
    _distanceFromDriver = distanceFromDriver;
    _user = user;
    _timestamp = timestamp;
}

  PusherRequestOrderModel.fromJson(dynamic json) {
    _rideRequestId = json['rideRequestId'];
    _userId = json['userId'];
    _pickupLocation = json['pickupLocation'] != null ? PickupLocation.fromJson(json['pickupLocation']) : null;
    _dropoffLocation = json['dropoffLocation'] != null ? DropoffLocation.fromJson(json['dropoffLocation']) : null;
    _category = json['category'] != null ? Category.fromJson(json['category']) : null;
    _distance = json['distance'];
    _estimatedFare = json['estimatedFare'];
    _estimatedTime = json['estimatedTime'];
    _distanceFromDriver = json['distanceFromDriver'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _timestamp = json['timestamp'];
  }
  num? _rideRequestId;
  num? _userId;
  PickupLocation? _pickupLocation;
  DropoffLocation? _dropoffLocation;
  Category? _category;
  num? _distance;
  num? _estimatedFare;
  num? _estimatedTime;
  num? _distanceFromDriver;
  User? _user;
  String? _timestamp;
PusherRequestOrderModel copyWith({  num? rideRequestId,
  num? userId,
  PickupLocation? pickupLocation,
  DropoffLocation? dropoffLocation,
  Category? category,
  num? distance,
  num? estimatedFare,
  num? estimatedTime,
  num? distanceFromDriver,
  User? user,
  String? timestamp,
}) => PusherRequestOrderModel(  rideRequestId: rideRequestId ?? _rideRequestId,
  userId: userId ?? _userId,
  pickupLocation: pickupLocation ?? _pickupLocation,
  dropoffLocation: dropoffLocation ?? _dropoffLocation,
  category: category ?? _category,
  distance: distance ?? _distance,
  estimatedFare: estimatedFare ?? _estimatedFare,
  estimatedTime: estimatedTime ?? _estimatedTime,
  distanceFromDriver: distanceFromDriver ?? _distanceFromDriver,
  user: user ?? _user,
  timestamp: timestamp ?? _timestamp,
);
  num? get rideRequestId => _rideRequestId;
  num? get userId => _userId;
  PickupLocation? get pickupLocation => _pickupLocation;
  DropoffLocation? get dropoffLocation => _dropoffLocation;
  Category? get category => _category;
  num? get distance => _distance;
  num? get estimatedFare => _estimatedFare;
  num? get estimatedTime => _estimatedTime;
  num? get distanceFromDriver => _distanceFromDriver;
  User? get user => _user;
  String? get timestamp => _timestamp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['rideRequestId'] = _rideRequestId;
    map['userId'] = _userId;
    if (_pickupLocation != null) {
      map['pickupLocation'] = _pickupLocation?.toJson();
    }
    if (_dropoffLocation != null) {
      map['dropoffLocation'] = _dropoffLocation?.toJson();
    }
    if (_category != null) {
      map['category'] = _category?.toJson();
    }
    map['distance'] = _distance;
    map['estimatedFare'] = _estimatedFare;
    map['estimatedTime'] = _estimatedTime;
    map['distanceFromDriver'] = _distanceFromDriver;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    map['timestamp'] = _timestamp;
    return map;
  }

}

/// id : 22
/// firstName : "First22"
/// lastName : "Last22"
/// fullName : "First22 Last22"
/// userInfo : {"picture":"https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?t=st=1757438383~exp=1757441983~hmac=72975912e16e40f389800dcc9616849af4237b1ec9c0683201d8e1f2d03410c2&w=1480","rattings":3}

class User {
  User({
      num? id, 
      String? firstName, 
      String? lastName, 
      String? fullName, 
      UserInfo? userInfo,}){
    _id = id;
    _firstName = firstName;
    _lastName = lastName;
    _fullName = fullName;
    _userInfo = userInfo;
}

  User.fromJson(dynamic json) {
    _id = json['id'];
    _firstName = json['firstName'];
    _lastName = json['lastName'];
    _fullName = json['fullName'];
    _userInfo = json['userInfo'] != null ? UserInfo.fromJson(json['userInfo']) : null;
  }
  num? _id;
  String? _firstName;
  String? _lastName;
  String? _fullName;
  UserInfo? _userInfo;
User copyWith({  num? id,
  String? firstName,
  String? lastName,
  String? fullName,
  UserInfo? userInfo,
}) => User(  id: id ?? _id,
  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  fullName: fullName ?? _fullName,
  userInfo: userInfo ?? _userInfo,
);
  num? get id => _id;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get fullName => _fullName;
  UserInfo? get userInfo => _userInfo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['firstName'] = _firstName;
    map['lastName'] = _lastName;
    map['fullName'] = _fullName;
    if (_userInfo != null) {
      map['userInfo'] = _userInfo?.toJson();
    }
    return map;
  }

}

/// picture : "https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?t=st=1757438383~exp=1757441983~hmac=72975912e16e40f389800dcc9616849af4237b1ec9c0683201d8e1f2d03410c2&w=1480"
/// rattings : 3

class UserInfo {
  UserInfo({
      String? picture, 
      num? rattings,}){
    _picture = picture;
    _rattings = rattings;
}

  UserInfo.fromJson(dynamic json) {
    _picture = json['picture'];
    _rattings = json['rattings'];
  }
  String? _picture;
  num? _rattings;
UserInfo copyWith({  String? picture,
  num? rattings,
}) => UserInfo(  picture: picture ?? _picture,
  rattings: rattings ?? _rattings,
);
  String? get picture => _picture;
  num? get rattings => _rattings;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['picture'] = _picture;
    map['rattings'] = _rattings;
    return map;
  }

}

/// id : 1
/// categoryName : "Car"
/// slug : "cab-car"
/// lnCategoryName : "{\"en\":\"Car\",\"ar\":\"خدمة 2\",\"de\":\"Dienstleistung 2\",\"fr\":\"Service 2\"}"
/// IconMediaId : 43
/// type : "type-1"
/// serviceId : 2
/// moreMediaIds : [4,5,6]
/// baseAmount : 12
/// maxSeat : 4
/// minPerUnitCharge : 1.5
/// maxPerUnitCharge : 3.5
/// minPermuniteCharge : 0.3
/// maxPermuniteCharge : 1.2
/// minPerWeightCharge : 0.7
/// maxPerWeightCharge : 2.3
/// cancellationCharge : 3
/// waitingTimeCharge : 0.6
/// commissionType : "percentage"
/// commissionRate : 6
/// createdById : null
/// taxId : null
/// status : true
/// additionInfo : null
/// sortOrder : 1
/// deletedAt : null
/// createdAt : "2025-10-18T15:10:45.914Z"
/// updatedAt : "2025-10-18T15:10:45.914Z"
/// updatedBy : 0

class Category {
  Category({
      num? id, 
      String? categoryName, 
      String? slug, 
      String? lnCategoryName, 
      num? iconMediaId, 
      String? type, 
      num? serviceId, 
      List<num>? moreMediaIds, 
      num? baseAmount, 
      num? maxSeat, 
      num? minPerUnitCharge, 
      num? maxPerUnitCharge, 
      num? minPermuniteCharge, 
      num? maxPermuniteCharge, 
      num? minPerWeightCharge, 
      num? maxPerWeightCharge, 
      num? cancellationCharge, 
      num? waitingTimeCharge, 
      String? commissionType, 
      num? commissionRate, 
      dynamic createdById, 
      dynamic taxId, 
      bool? status, 
      dynamic additionInfo, 
      num? sortOrder, 
      dynamic deletedAt, 
      String? createdAt, 
      String? updatedAt, 
      num? updatedBy,}){
    _id = id;
    _categoryName = categoryName;
    _slug = slug;
    _lnCategoryName = lnCategoryName;
    _iconMediaId = iconMediaId;
    _type = type;
    _serviceId = serviceId;
    _moreMediaIds = moreMediaIds;
    _baseAmount = baseAmount;
    _maxSeat = maxSeat;
    _minPerUnitCharge = minPerUnitCharge;
    _maxPerUnitCharge = maxPerUnitCharge;
    _minPermuniteCharge = minPermuniteCharge;
    _maxPermuniteCharge = maxPermuniteCharge;
    _minPerWeightCharge = minPerWeightCharge;
    _maxPerWeightCharge = maxPerWeightCharge;
    _cancellationCharge = cancellationCharge;
    _waitingTimeCharge = waitingTimeCharge;
    _commissionType = commissionType;
    _commissionRate = commissionRate;
    _createdById = createdById;
    _taxId = taxId;
    _status = status;
    _additionInfo = additionInfo;
    _sortOrder = sortOrder;
    _deletedAt = deletedAt;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _updatedBy = updatedBy;
}

  Category.fromJson(dynamic json) {
    _id = json['id'];
    _categoryName = json['categoryName'];
    _slug = json['slug'];
    _lnCategoryName = json['lnCategoryName'];
    _iconMediaId = json['IconMediaId'];
    _type = json['type'];
    _serviceId = json['serviceId'];
    _moreMediaIds = json['moreMediaIds'] != null ? json['moreMediaIds'].cast<num>() : [];
    _baseAmount = json['baseAmount'];
    _maxSeat = json['maxSeat'];
    _minPerUnitCharge = json['minPerUnitCharge'];
    _maxPerUnitCharge = json['maxPerUnitCharge'];
    _minPermuniteCharge = json['minPermuniteCharge'];
    _maxPermuniteCharge = json['maxPermuniteCharge'];
    _minPerWeightCharge = json['minPerWeightCharge'];
    _maxPerWeightCharge = json['maxPerWeightCharge'];
    _cancellationCharge = json['cancellationCharge'];
    _waitingTimeCharge = json['waitingTimeCharge'];
    _commissionType = json['commissionType'];
    _commissionRate = json['commissionRate'];
    _createdById = json['createdById'];
    _taxId = json['taxId'];
    _status = json['status'];
    _additionInfo = json['additionInfo'];
    _sortOrder = json['sortOrder'];
    _deletedAt = json['deletedAt'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _updatedBy = json['updatedBy'];
  }
  num? _id;
  String? _categoryName;
  String? _slug;
  String? _lnCategoryName;
  num? _iconMediaId;
  String? _type;
  num? _serviceId;
  List<num>? _moreMediaIds;
  num? _baseAmount;
  num? _maxSeat;
  num? _minPerUnitCharge;
  num? _maxPerUnitCharge;
  num? _minPermuniteCharge;
  num? _maxPermuniteCharge;
  num? _minPerWeightCharge;
  num? _maxPerWeightCharge;
  num? _cancellationCharge;
  num? _waitingTimeCharge;
  String? _commissionType;
  num? _commissionRate;
  dynamic _createdById;
  dynamic _taxId;
  bool? _status;
  dynamic _additionInfo;
  num? _sortOrder;
  dynamic _deletedAt;
  String? _createdAt;
  String? _updatedAt;
  num? _updatedBy;
Category copyWith({  num? id,
  String? categoryName,
  String? slug,
  String? lnCategoryName,
  num? iconMediaId,
  String? type,
  num? serviceId,
  List<num>? moreMediaIds,
  num? baseAmount,
  num? maxSeat,
  num? minPerUnitCharge,
  num? maxPerUnitCharge,
  num? minPermuniteCharge,
  num? maxPermuniteCharge,
  num? minPerWeightCharge,
  num? maxPerWeightCharge,
  num? cancellationCharge,
  num? waitingTimeCharge,
  String? commissionType,
  num? commissionRate,
  dynamic createdById,
  dynamic taxId,
  bool? status,
  dynamic additionInfo,
  num? sortOrder,
  dynamic deletedAt,
  String? createdAt,
  String? updatedAt,
  num? updatedBy,
}) => Category(  id: id ?? _id,
  categoryName: categoryName ?? _categoryName,
  slug: slug ?? _slug,
  lnCategoryName: lnCategoryName ?? _lnCategoryName,
  iconMediaId: iconMediaId ?? _iconMediaId,
  type: type ?? _type,
  serviceId: serviceId ?? _serviceId,
  moreMediaIds: moreMediaIds ?? _moreMediaIds,
  baseAmount: baseAmount ?? _baseAmount,
  maxSeat: maxSeat ?? _maxSeat,
  minPerUnitCharge: minPerUnitCharge ?? _minPerUnitCharge,
  maxPerUnitCharge: maxPerUnitCharge ?? _maxPerUnitCharge,
  minPermuniteCharge: minPermuniteCharge ?? _minPermuniteCharge,
  maxPermuniteCharge: maxPermuniteCharge ?? _maxPermuniteCharge,
  minPerWeightCharge: minPerWeightCharge ?? _minPerWeightCharge,
  maxPerWeightCharge: maxPerWeightCharge ?? _maxPerWeightCharge,
  cancellationCharge: cancellationCharge ?? _cancellationCharge,
  waitingTimeCharge: waitingTimeCharge ?? _waitingTimeCharge,
  commissionType: commissionType ?? _commissionType,
  commissionRate: commissionRate ?? _commissionRate,
  createdById: createdById ?? _createdById,
  taxId: taxId ?? _taxId,
  status: status ?? _status,
  additionInfo: additionInfo ?? _additionInfo,
  sortOrder: sortOrder ?? _sortOrder,
  deletedAt: deletedAt ?? _deletedAt,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  updatedBy: updatedBy ?? _updatedBy,
);
  num? get id => _id;
  String? get categoryName => _categoryName;
  String? get slug => _slug;
  String? get lnCategoryName => _lnCategoryName;
  num? get iconMediaId => _iconMediaId;
  String? get type => _type;
  num? get serviceId => _serviceId;
  List<num>? get moreMediaIds => _moreMediaIds;
  num? get baseAmount => _baseAmount;
  num? get maxSeat => _maxSeat;
  num? get minPerUnitCharge => _minPerUnitCharge;
  num? get maxPerUnitCharge => _maxPerUnitCharge;
  num? get minPermuniteCharge => _minPermuniteCharge;
  num? get maxPermuniteCharge => _maxPermuniteCharge;
  num? get minPerWeightCharge => _minPerWeightCharge;
  num? get maxPerWeightCharge => _maxPerWeightCharge;
  num? get cancellationCharge => _cancellationCharge;
  num? get waitingTimeCharge => _waitingTimeCharge;
  String? get commissionType => _commissionType;
  num? get commissionRate => _commissionRate;
  dynamic get createdById => _createdById;
  dynamic get taxId => _taxId;
  bool? get status => _status;
  dynamic get additionInfo => _additionInfo;
  num? get sortOrder => _sortOrder;
  dynamic get deletedAt => _deletedAt;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  num? get updatedBy => _updatedBy;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['categoryName'] = _categoryName;
    map['slug'] = _slug;
    map['lnCategoryName'] = _lnCategoryName;
    map['IconMediaId'] = _iconMediaId;
    map['type'] = _type;
    map['serviceId'] = _serviceId;
    map['moreMediaIds'] = _moreMediaIds;
    map['baseAmount'] = _baseAmount;
    map['maxSeat'] = _maxSeat;
    map['minPerUnitCharge'] = _minPerUnitCharge;
    map['maxPerUnitCharge'] = _maxPerUnitCharge;
    map['minPermuniteCharge'] = _minPermuniteCharge;
    map['maxPermuniteCharge'] = _maxPermuniteCharge;
    map['minPerWeightCharge'] = _minPerWeightCharge;
    map['maxPerWeightCharge'] = _maxPerWeightCharge;
    map['cancellationCharge'] = _cancellationCharge;
    map['waitingTimeCharge'] = _waitingTimeCharge;
    map['commissionType'] = _commissionType;
    map['commissionRate'] = _commissionRate;
    map['createdById'] = _createdById;
    map['taxId'] = _taxId;
    map['status'] = _status;
    map['additionInfo'] = _additionInfo;
    map['sortOrder'] = _sortOrder;
    map['deletedAt'] = _deletedAt;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['updatedBy'] = _updatedBy;
    return map;
  }

}

/// address : "murad nagar, feni, Park Ave, City"
/// latitude : "23.750631"
/// longitude : "90.400293"

class DropoffLocation {
  DropoffLocation({
      String? address, 
      String? latitude, 
      String? longitude,}){
    _address = address;
    _latitude = latitude;
    _longitude = longitude;
}

  DropoffLocation.fromJson(dynamic json) {
    _address = json['address'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
  }
  String? _address;
  String? _latitude;
  String? _longitude;
DropoffLocation copyWith({  String? address,
  String? latitude,
  String? longitude,
}) => DropoffLocation(  address: address ?? _address,
  latitude: latitude ?? _latitude,
  longitude: longitude ?? _longitude,
);
  String? get address => _address;
  String? get latitude => _latitude;
  String? get longitude => _longitude;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['address'] = _address;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    return map;
  }

}

/// address : "ctg, Bangla, City"
/// latitude : "23.810711"
/// longitude : "90.412422"

class PickupLocation {
  PickupLocation({
      String? address, 
      String? latitude, 
      String? longitude,}){
    _address = address;
    _latitude = latitude;
    _longitude = longitude;
}

  PickupLocation.fromJson(dynamic json) {
    _address = json['address'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
  }
  String? _address;
  String? _latitude;
  String? _longitude;
PickupLocation copyWith({  String? address,
  String? latitude,
  String? longitude,
}) => PickupLocation(  address: address ?? _address,
  latitude: latitude ?? _latitude,
  longitude: longitude ?? _longitude,
);
  String? get address => _address;
  String? get latitude => _latitude;
  String? get longitude => _longitude;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['address'] = _address;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    return map;
  }

}