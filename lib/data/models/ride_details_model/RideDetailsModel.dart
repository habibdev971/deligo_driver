class RideDetailsModel {
  RideDetailsModel({
      this.status, 
      this.error, 
      this.message, 
      this.data,});

  RideDetailsModel.fromJson(dynamic json) {
    status = json['status'];
    error = json['error'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? status;
  dynamic error;
  String? message;
  Data? data;
RideDetailsModel copyWith({  String? status,
  dynamic error,
  String? message,
  Data? data,
}) => RideDetailsModel(  status: status ?? this.status,
  error: error ?? this.error,
  message: message ?? this.message,
  data: data ?? this.data,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['error'] = error;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

class Data {
  Data({
      this.rideRequest,});

  Data.fromJson(dynamic json) {
    rideRequest = json['rideRequest'] != null ? RideRequest.fromJson(json['rideRequest']) : null;
  }
  RideRequest? rideRequest;
Data copyWith({  RideRequest? rideRequest,
}) => Data(  rideRequest: rideRequest ?? this.rideRequest,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (rideRequest != null) {
      map['rideRequest'] = rideRequest?.toJson();
    }
    return map;
  }

}

class RideRequest {
  RideRequest({
      this.id, 
      this.status, 
      this.actualDistance, 
      this.duration, 
      this.waitMinutes, 
      this.rideNumber, 
      this.estimatedFare, 
      this.estimatedTime, 
      this.distance, 
      this.points, 
      this.addresses, 
      this.orderTime, 
      this.payMethod, 
      this.subTotal, 
      this.discount, 
      this.payableAmount, 
      this.currency, 
      this.directions, 
      this.service, 
      this.ridePreferences, 
      this.driver, 
      this.rider, 
      this.vehicle,});

  RideRequest.fromJson(dynamic json) {
    id = json['id'];
    status = json['status'];
    actualDistance = json['actual_distance'];
    duration = json['duration'];
    waitMinutes = json['wait_minutes'];
    rideNumber = json['ride_number'];
    estimatedFare = json['estimated_fare'];
    estimatedTime = json['estimated_time'];
    distance = json['distance'];
    points = json['points'] != null ? Points.fromJson(json['points']) : null;
    addresses = json['addresses'] != null ? Addresses.fromJson(json['addresses']) : null;
    orderTime = json['order_time'];
    payMethod = json['pay_method'];
    subTotal = json['sub_total'];
    discount = json['discount'];
    payableAmount = json['payable_amount'];
    currency = json['currency'];
    directions = json['directions'];
    service = json['service'] != null ? Service.fromJson(json['service']) : null;
    if (json['ride_preferences'] != null) {
      ridePreferences = [];
      json['ride_preferences'].forEach((v) {
        ridePreferences?.add(RidePreferences.fromJson(v));
      });
    }
    driver = json['driver'] != null ? Driver.fromJson(json['driver']) : null;
    rider = json['rider'] != null ? Rider.fromJson(json['rider']) : null;
    vehicle = json['vehicle'] != null ? Vehicle.fromJson(json['vehicle']) : null;
  }
  num? id;
  String? status;
  num? actualDistance;
  num? duration;
  num? waitMinutes;
  String? rideNumber;
  num? estimatedFare;
  num? estimatedTime;
  num? distance;
  Points? points;
  Addresses? addresses;
  String? orderTime;
  dynamic payMethod;
  num? subTotal;
  num? discount;
  num? payableAmount;
  String? currency;
  dynamic directions;
  Service? service;
  List<RidePreferences>? ridePreferences;
  Driver? driver;
  Rider? rider;
  Vehicle? vehicle;
RideRequest copyWith({  num? id,
  String? status,
  num? actualDistance,
  num? duration,
  num? waitMinutes,
  String? rideNumber,
  num? estimatedFare,
  num? estimatedTime,
  num? distance,
  Points? points,
  Addresses? addresses,
  String? orderTime,
  dynamic payMethod,
  num? subTotal,
  num? discount,
  num? payableAmount,
  String? currency,
  dynamic directions,
  Service? service,
  List<RidePreferences>? ridePreferences,
  Driver? driver,
  Rider? rider,
  Vehicle? vehicle,
}) => RideRequest(  id: id ?? this.id,
  status: status ?? this.status,
  actualDistance: actualDistance ?? this.actualDistance,
  duration: duration ?? this.duration,
  waitMinutes: waitMinutes ?? this.waitMinutes,
  rideNumber: rideNumber ?? this.rideNumber,
  estimatedFare: estimatedFare ?? this.estimatedFare,
  estimatedTime: estimatedTime ?? this.estimatedTime,
  distance: distance ?? this.distance,
  points: points ?? this.points,
  addresses: addresses ?? this.addresses,
  orderTime: orderTime ?? this.orderTime,
  payMethod: payMethod ?? this.payMethod,
  subTotal: subTotal ?? this.subTotal,
  discount: discount ?? this.discount,
  payableAmount: payableAmount ?? this.payableAmount,
  currency: currency ?? this.currency,
  directions: directions ?? this.directions,
  service: service ?? this.service,
  ridePreferences: ridePreferences ?? this.ridePreferences,
  driver: driver ?? this.driver,
  rider: rider ?? this.rider,
  vehicle: vehicle ?? this.vehicle,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['status'] = status;
    map['actual_distance'] = actualDistance;
    map['duration'] = duration;
    map['wait_minutes'] = waitMinutes;
    map['ride_number'] = rideNumber;
    map['estimated_fare'] = estimatedFare;
    map['estimated_time'] = estimatedTime;
    map['distance'] = distance;
    if (points != null) {
      map['points'] = points?.toJson();
    }
    if (addresses != null) {
      map['addresses'] = addresses?.toJson();
    }
    map['order_time'] = orderTime;
    map['pay_method'] = payMethod;
    map['sub_total'] = subTotal;
    map['discount'] = discount;
    map['payable_amount'] = payableAmount;
    map['currency'] = currency;
    map['directions'] = directions;
    if (service != null) {
      map['service'] = service?.toJson();
    }
    if (ridePreferences != null) {
      map['ride_preferences'] = ridePreferences?.map((v) => v.toJson()).toList();
    }
    if (driver != null) {
      map['driver'] = driver?.toJson();
    }
    if (rider != null) {
      map['rider'] = rider?.toJson();
    }
    if (vehicle != null) {
      map['vehicle'] = vehicle?.toJson();
    }
    return map;
  }

}

class Vehicle {
  Vehicle({
      this.id, 
      this.carColor, 
      this.carModel, 
      this.carPlateNumber, 
      this.carProductionYear, 
      this.direction,});

  Vehicle.fromJson(dynamic json) {
    id = json['id'];
    carColor = json['carColor'];
    carModel = json['carModel'];
    carPlateNumber = json['carPlateNumber'];
    carProductionYear = json['carProductionYear'];
    direction = json['direction'];
  }
  num? id;
  String? carColor;
  String? carModel;
  String? carPlateNumber;
  num? carProductionYear;
  dynamic direction;
Vehicle copyWith({  num? id,
  String? carColor,
  String? carModel,
  String? carPlateNumber,
  num? carProductionYear,
  dynamic direction,
}) => Vehicle(  id: id ?? this.id,
  carColor: carColor ?? this.carColor,
  carModel: carModel ?? this.carModel,
  carPlateNumber: carPlateNumber ?? this.carPlateNumber,
  carProductionYear: carProductionYear ?? this.carProductionYear,
  direction: direction ?? this.direction,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['carColor'] = carColor;
    map['carModel'] = carModel;
    map['carPlateNumber'] = carPlateNumber;
    map['carProductionYear'] = carProductionYear;
    map['direction'] = direction;
    return map;
  }

}

class Rider {
  Rider({
      this.id, 
      this.name, 
      this.email, 
      this.mobile, 
      this.profilePicture, 
      this.totalTrip, 
      this.rating,});

  Rider.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    profilePicture = json['profile_picture'];
    totalTrip = json['total_trip'];
    rating = json['rating'];
  }
  num? id;
  String? name;
  String? email;
  String? mobile;
  String? profilePicture;
  num? totalTrip;
  num? rating;
Rider copyWith({  num? id,
  String? name,
  String? email,
  String? mobile,
  String? profilePicture,
  num? totalTrip,
  num? rating,
}) => Rider(  id: id ?? this.id,
  name: name ?? this.name,
  email: email ?? this.email,
  mobile: mobile ?? this.mobile,
  profilePicture: profilePicture ?? this.profilePicture,
  totalTrip: totalTrip ?? this.totalTrip,
  rating: rating ?? this.rating,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['mobile'] = mobile;
    map['profile_picture'] = profilePicture;
    map['total_trip'] = totalTrip;
    map['rating'] = rating;
    return map;
  }

}

class Driver {
  Driver({
      this.id, 
      this.name, 
      this.email, 
      this.mobile, 
      this.profilePicture, 
      this.rating, 
      this.direction, 
      this.currentLocation, 
      this.totalTrip,});

  Driver.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    profilePicture = json['profile_picture'];
    rating = json['rating'];
    direction = json['direction'];
    currentLocation = json['current_location'];
    totalTrip = json['total_trip'];
  }
  num? id;
  String? name;
  String? email;
  String? mobile;
  String? profilePicture;
  num? rating;
  dynamic direction;
  dynamic currentLocation;
  num? totalTrip;
Driver copyWith({  num? id,
  String? name,
  String? email,
  String? mobile,
  String? profilePicture,
  num? rating,
  dynamic direction,
  dynamic currentLocation,
  num? totalTrip,
}) => Driver(  id: id ?? this.id,
  name: name ?? this.name,
  email: email ?? this.email,
  mobile: mobile ?? this.mobile,
  profilePicture: profilePicture ?? this.profilePicture,
  rating: rating ?? this.rating,
  direction: direction ?? this.direction,
  currentLocation: currentLocation ?? this.currentLocation,
  totalTrip: totalTrip ?? this.totalTrip,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['mobile'] = mobile;
    map['profile_picture'] = profilePicture;
    map['rating'] = rating;
    map['direction'] = direction;
    map['current_location'] = currentLocation;
    map['total_trip'] = totalTrip;
    return map;
  }

}

class RidePreferences {
  RidePreferences({
      this.id, 
      this.name, 
      this.description, 
      this.type, 
      this.additionalFee,});

  RidePreferences.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    type = json['type'] != null ? Type.fromJson(json['type']) : null;
    additionalFee = json['additional_fee'];
  }
  num? id;
  String? name;
  String? description;
  Type? type;
  num? additionalFee;
RidePreferences copyWith({  num? id,
  String? name,
  String? description,
  Type? type,
  num? additionalFee,
}) => RidePreferences(  id: id ?? this.id,
  name: name ?? this.name,
  description: description ?? this.description,
  type: type ?? this.type,
  additionalFee: additionalFee ?? this.additionalFee,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['description'] = description;
    if (type != null) {
      map['type'] = type?.toJson();
    }
    map['additional_fee'] = additionalFee;
    return map;
  }

}

class Type {
  Type({
      this.value, 
      this.label,});

  Type.fromJson(dynamic json) {
    value = json['value'];
    label = json['label'];
  }
  String? value;
  String? label;
Type copyWith({  String? value,
  String? label,
}) => Type(  value: value ?? this.value,
  label: label ?? this.label,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['value'] = value;
    map['label'] = label;
    return map;
  }

}

class Service {
  Service({
      this.id, 
      this.name, 
      this.logo, 
      this.capacity, 
      this.minimumFee, 
      this.baseFare, 
      this.perHundredMeters,});

  Service.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
    capacity = json['capacity'];
    minimumFee = json['minimum_fee'];
    baseFare = json['base_fare'];
    perHundredMeters = json['per_hundred_meters'];
  }
  num? id;
  String? name;
  String? logo;
  num? capacity;
  num? minimumFee;
  num? baseFare;
  String? perHundredMeters;
Service copyWith({  num? id,
  String? name,
  String? logo,
  num? capacity,
  num? minimumFee,
  num? baseFare,
  String? perHundredMeters,
}) => Service(  id: id ?? this.id,
  name: name ?? this.name,
  logo: logo ?? this.logo,
  capacity: capacity ?? this.capacity,
  minimumFee: minimumFee ?? this.minimumFee,
  baseFare: baseFare ?? this.baseFare,
  perHundredMeters: perHundredMeters ?? this.perHundredMeters,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['logo'] = logo;
    map['capacity'] = capacity;
    map['minimum_fee'] = minimumFee;
    map['base_fare'] = baseFare;
    map['per_hundred_meters'] = perHundredMeters;
    return map;
  }

}

class Addresses {
  Addresses({
      this.pickupAddress, 
      this.dropAddress, 
      this.waitAddress,});

  Addresses.fromJson(dynamic json) {
    pickupAddress = json['pickup_address'];
    dropAddress = json['drop_address'];
    waitAddress = json['wait_address'];
  }
  String? pickupAddress;
  String? dropAddress;
  dynamic waitAddress;
Addresses copyWith({  String? pickupAddress,
  String? dropAddress,
  dynamic waitAddress,
}) => Addresses(  pickupAddress: pickupAddress ?? this.pickupAddress,
  dropAddress: dropAddress ?? this.dropAddress,
  waitAddress: waitAddress ?? this.waitAddress,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['pickup_address'] = pickupAddress;
    map['drop_address'] = dropAddress;
    map['wait_address'] = waitAddress;
    return map;
  }

}

class Points {
  Points({
      this.pickupLocation, 
      this.dropLocation, 
      this.waitLocation,});

  Points.fromJson(dynamic json) {
    pickupLocation = json['pickup_location'] != null ? json['pickup_location'].cast<num>() : [];
    dropLocation = json['drop_location'] != null ? json['drop_location'].cast<num>() : [];
    waitLocation = json['wait_location'];
  }
  List<num>? pickupLocation;
  List<num>? dropLocation;
  dynamic waitLocation;
Points copyWith({  List<num>? pickupLocation,
  List<num>? dropLocation,
  dynamic waitLocation,
}) => Points(  pickupLocation: pickupLocation ?? this.pickupLocation,
  dropLocation: dropLocation ?? this.dropLocation,
  waitLocation: waitLocation ?? this.waitLocation,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['pickup_location'] = pickupLocation;
    map['drop_location'] = dropLocation;
    map['wait_location'] = waitLocation;
    return map;
  }

}