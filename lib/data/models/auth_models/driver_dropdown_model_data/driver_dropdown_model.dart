/// status : "success"
/// error : null
/// message : "Dropdown data retrieved"
/// data : {"vehicleTypes":[{"id":24,"categoryName":"Auto","slug":"ambulance-auto","IconMediaId":4,"status":true,"categoryImage":"178.128.59.117:3001/uploads/media/car-wash-thumbnail.png"},{"id":22,"categoryName":"Prime Car","slug":"ambulance-prime-car","IconMediaId":59,"status":true,"categoryImage":"178.128.59.117:3001/uploads/media/car-wash-thumbnail.png"},{"id":14,"categoryName":"Car","slug":"freight-car","IconMediaId":66,"status":true,"categoryImage":"178.128.59.117:3001/uploads/media/red-sports-car-png-1.png"},{"id":16,"categoryName":"Truck","slug":"freight-truck","IconMediaId":57,"status":true,"categoryImage":"178.128.59.117:3001/uploads/media/car-blue-thumbnail.png"},{"id":17,"categoryName":"Bus","slug":"freight-bus","IconMediaId":14,"status":true,"categoryImage":"178.128.59.117:3001/uploads/media/red-sports-car-png-1.png"},{"id":19,"categoryName":"Bike","slug":"ambulance-bike","IconMediaId":18,"status":true,"categoryImage":"178.128.59.117:3001/uploads/media/car-blue-thumbnail.png"}],"paymentMethods":[{"id":4,"name":"Nagad"},{"id":2,"name":"PayPal"},{"id":1,"name":"Stripe"},{"id":3,"name":"bKash"}],"vehicleBrands":[{"id":1,"name":"Toyota"},{"id":2,"name":"Honda"},{"id":3,"name":"Ford"},{"id":4,"name":"Chevrolet"},{"id":5,"name":"Nissan"},{"id":6,"name":"BMW"},{"id":7,"name":"Mercedes-Benz"},{"id":8,"name":"Audi"},{"id":9,"name":"Volkswagen"},{"id":10,"name":"Hyundai"},{"id":11,"name":"Kia"},{"id":12,"name":"Mazda"},{"id":13,"name":"Subaru"},{"id":14,"name":"Jeep"},{"id":15,"name":"Lexus"},{"id":16,"name":"Tesla"},{"id":17,"name":"Volvo"},{"id":18,"name":"Renault"},{"id":19,"name":"Peugeot"},{"id":20,"name":"Fiat"},{"id":21,"name":"Land Rover"},{"id":22,"name":"Porsche"},{"id":23,"name":"Jaguar"},{"id":24,"name":"Mini"},{"id":25,"name":"Mitsubishi"},{"id":26,"name":"Skoda"},{"id":27,"name":"Suzuki"},{"id":28,"name":"Tata"},{"id":29,"name":"Mahindra"},{"id":30,"name":"Maruti Suzuki"},{"id":31,"name":"Ashok Leyland"},{"id":32,"name":"Eicher"},{"id":33,"name":"Force Motors"},{"id":34,"name":"Isuzu"},{"id":35,"name":"Datsun"},{"id":36,"name":"Buick"},{"id":37,"name":"Chrysler"},{"id":38,"name":"Dodge"},{"id":39,"name":"GMC"},{"id":40,"name":"Genesis"},{"id":41,"name":"Infiniti"},{"id":42,"name":"Lincoln"},{"id":43,"name":"Ram"},{"id":44,"name":"Acura"},{"id":45,"name":"Alfa Romeo"},{"id":46,"name":"Bentley"},{"id":47,"name":"Bugatti"},{"id":48,"name":"Ferrari"},{"id":49,"name":"Lamborghini"},{"id":50,"name":"Maserati"},{"id":51,"name":"Rolls-Royce"},{"id":52,"name":"Hero"},{"id":53,"name":"Bajaj"},{"id":54,"name":"TVS"},{"id":55,"name":"Royal Enfield"},{"id":56,"name":"Yamaha"},{"id":57,"name":"KTM"},{"id":58,"name":"Harley-Davidson"},{"id":59,"name":"Ducati"},{"id":60,"name":"Suzuki (Motorcycles)"},{"id":61,"name":"Kawasaki"},{"id":62,"name":"Aprilia"},{"id":63,"name":"Piaggio"},{"id":64,"name":"Benelli"},{"id":65,"name":"Triumph"},{"id":66,"name":"MV Agusta"},{"id":67,"name":"Husqvarna"},{"id":68,"name":"Ather"},{"id":69,"name":"Ola Electric"},{"id":70,"name":"Revolt"},{"id":71,"name":"Ultraviolette"}],"colors":[{"id":1,"name":"Red"},{"id":2,"name":"Blue"},{"id":3,"name":"Green"},{"id":4,"name":"Yellow"},{"id":5,"name":"Orange"},{"id":6,"name":"Purple"},{"id":7,"name":"Pink"},{"id":8,"name":"Brown"},{"id":9,"name":"Black"},{"id":10,"name":"White"},{"id":11,"name":"Gray"},{"id":12,"name":"Silver"},{"id":13,"name":"Gold"},{"id":14,"name":"Beige"},{"id":15,"name":"Maroon"},{"id":16,"name":"Navy"},{"id":17,"name":"Teal"},{"id":18,"name":"Cyan"},{"id":19,"name":"Magenta"},{"id":20,"name":"Olive"},{"id":21,"name":"Lime"},{"id":22,"name":"Turquoise"},{"id":23,"name":"Indigo"},{"id":24,"name":"Violet"},{"id":25,"name":"Charcoal"},{"id":26,"name":"Coral"},{"id":27,"name":"Crimson"},{"id":28,"name":"Ivory"},{"id":29,"name":"Lavender"},{"id":30,"name":"Mint"},{"id":31,"name":"Mustard"},{"id":32,"name":"Peach"},{"id":33,"name":"Plum"},{"id":34,"name":"Rose"},{"id":35,"name":"Salmon"},{"id":36,"name":"Sky Blue"},{"id":37,"name":"Tan"},{"id":38,"name":"Amber"},{"id":39,"name":"Chocolate"},{"id":40,"name":"Emerald"},{"id":41,"name":"Fuchsia"},{"id":42,"name":"Khaki"},{"id":43,"name":"Lilac"},{"id":44,"name":"Pearl"},{"id":45,"name":"Rust"},{"id":46,"name":"Sand"},{"id":47,"name":"Sapphire"},{"id":48,"name":"Slate"},{"id":49,"name":"Steel Blue"}],"fuelTypes":[{"id":1,"name":"Petrol"},{"id":2,"name":"Diesel"},{"id":3,"name":"CNG"},{"id":4,"name":"LPG"},{"id":5,"name":"Electric"},{"id":6,"name":"Hybrid"},{"id":7,"name":"Hydrogen"}],"gearTypes":[{"id":1,"name":"Manual"},{"id":2,"name":"Automatic"},{"id":3,"name":"Semi-Automatic"},{"id":4,"name":"CVT (Continuously Variable Transmission)"}]}
library;

class DriverDropdownModel {
  DriverDropdownModel({
      String? status, 
      dynamic error, 
      String? message, 
      DriverDropdownData? data,}){
    _status = status;
    _error = error;
    _message = message;
    _data = data;
}

  DriverDropdownModel.fromJson(dynamic json) {
    _status = json['status'];
    _error = json['error'];
    _message = json['message'];
    _data = json['data'] != null ? DriverDropdownData.fromJson(json['data']) : null;
  }
  String? _status;
  dynamic _error;
  String? _message;
  DriverDropdownData? _data;
DriverDropdownModel copyWith({  String? status,
  dynamic error,
  String? message,
  DriverDropdownData? data,
}) => DriverDropdownModel(  status: status ?? _status,
  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  String? get status => _status;
  dynamic get error => _error;
  String? get message => _message;
  DriverDropdownData? get data => _data;

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

/// vehicleTypes : [{"id":24,"categoryName":"Auto","slug":"ambulance-auto","IconMediaId":4,"status":true,"categoryImage":"178.128.59.117:3001/uploads/media/car-wash-thumbnail.png"},{"id":22,"categoryName":"Prime Car","slug":"ambulance-prime-car","IconMediaId":59,"status":true,"categoryImage":"178.128.59.117:3001/uploads/media/car-wash-thumbnail.png"},{"id":14,"categoryName":"Car","slug":"freight-car","IconMediaId":66,"status":true,"categoryImage":"178.128.59.117:3001/uploads/media/red-sports-car-png-1.png"},{"id":16,"categoryName":"Truck","slug":"freight-truck","IconMediaId":57,"status":true,"categoryImage":"178.128.59.117:3001/uploads/media/car-blue-thumbnail.png"},{"id":17,"categoryName":"Bus","slug":"freight-bus","IconMediaId":14,"status":true,"categoryImage":"178.128.59.117:3001/uploads/media/red-sports-car-png-1.png"},{"id":19,"categoryName":"Bike","slug":"ambulance-bike","IconMediaId":18,"status":true,"categoryImage":"178.128.59.117:3001/uploads/media/car-blue-thumbnail.png"}]
/// paymentMethods : [{"id":4,"name":"Nagad"},{"id":2,"name":"PayPal"},{"id":1,"name":"Stripe"},{"id":3,"name":"bKash"}]
/// vehicleBrands : [{"id":1,"name":"Toyota"},{"id":2,"name":"Honda"},{"id":3,"name":"Ford"},{"id":4,"name":"Chevrolet"},{"id":5,"name":"Nissan"},{"id":6,"name":"BMW"},{"id":7,"name":"Mercedes-Benz"},{"id":8,"name":"Audi"},{"id":9,"name":"Volkswagen"},{"id":10,"name":"Hyundai"},{"id":11,"name":"Kia"},{"id":12,"name":"Mazda"},{"id":13,"name":"Subaru"},{"id":14,"name":"Jeep"},{"id":15,"name":"Lexus"},{"id":16,"name":"Tesla"},{"id":17,"name":"Volvo"},{"id":18,"name":"Renault"},{"id":19,"name":"Peugeot"},{"id":20,"name":"Fiat"},{"id":21,"name":"Land Rover"},{"id":22,"name":"Porsche"},{"id":23,"name":"Jaguar"},{"id":24,"name":"Mini"},{"id":25,"name":"Mitsubishi"},{"id":26,"name":"Skoda"},{"id":27,"name":"Suzuki"},{"id":28,"name":"Tata"},{"id":29,"name":"Mahindra"},{"id":30,"name":"Maruti Suzuki"},{"id":31,"name":"Ashok Leyland"},{"id":32,"name":"Eicher"},{"id":33,"name":"Force Motors"},{"id":34,"name":"Isuzu"},{"id":35,"name":"Datsun"},{"id":36,"name":"Buick"},{"id":37,"name":"Chrysler"},{"id":38,"name":"Dodge"},{"id":39,"name":"GMC"},{"id":40,"name":"Genesis"},{"id":41,"name":"Infiniti"},{"id":42,"name":"Lincoln"},{"id":43,"name":"Ram"},{"id":44,"name":"Acura"},{"id":45,"name":"Alfa Romeo"},{"id":46,"name":"Bentley"},{"id":47,"name":"Bugatti"},{"id":48,"name":"Ferrari"},{"id":49,"name":"Lamborghini"},{"id":50,"name":"Maserati"},{"id":51,"name":"Rolls-Royce"},{"id":52,"name":"Hero"},{"id":53,"name":"Bajaj"},{"id":54,"name":"TVS"},{"id":55,"name":"Royal Enfield"},{"id":56,"name":"Yamaha"},{"id":57,"name":"KTM"},{"id":58,"name":"Harley-Davidson"},{"id":59,"name":"Ducati"},{"id":60,"name":"Suzuki (Motorcycles)"},{"id":61,"name":"Kawasaki"},{"id":62,"name":"Aprilia"},{"id":63,"name":"Piaggio"},{"id":64,"name":"Benelli"},{"id":65,"name":"Triumph"},{"id":66,"name":"MV Agusta"},{"id":67,"name":"Husqvarna"},{"id":68,"name":"Ather"},{"id":69,"name":"Ola Electric"},{"id":70,"name":"Revolt"},{"id":71,"name":"Ultraviolette"}]
/// colors : [{"id":1,"name":"Red"},{"id":2,"name":"Blue"},{"id":3,"name":"Green"},{"id":4,"name":"Yellow"},{"id":5,"name":"Orange"},{"id":6,"name":"Purple"},{"id":7,"name":"Pink"},{"id":8,"name":"Brown"},{"id":9,"name":"Black"},{"id":10,"name":"White"},{"id":11,"name":"Gray"},{"id":12,"name":"Silver"},{"id":13,"name":"Gold"},{"id":14,"name":"Beige"},{"id":15,"name":"Maroon"},{"id":16,"name":"Navy"},{"id":17,"name":"Teal"},{"id":18,"name":"Cyan"},{"id":19,"name":"Magenta"},{"id":20,"name":"Olive"},{"id":21,"name":"Lime"},{"id":22,"name":"Turquoise"},{"id":23,"name":"Indigo"},{"id":24,"name":"Violet"},{"id":25,"name":"Charcoal"},{"id":26,"name":"Coral"},{"id":27,"name":"Crimson"},{"id":28,"name":"Ivory"},{"id":29,"name":"Lavender"},{"id":30,"name":"Mint"},{"id":31,"name":"Mustard"},{"id":32,"name":"Peach"},{"id":33,"name":"Plum"},{"id":34,"name":"Rose"},{"id":35,"name":"Salmon"},{"id":36,"name":"Sky Blue"},{"id":37,"name":"Tan"},{"id":38,"name":"Amber"},{"id":39,"name":"Chocolate"},{"id":40,"name":"Emerald"},{"id":41,"name":"Fuchsia"},{"id":42,"name":"Khaki"},{"id":43,"name":"Lilac"},{"id":44,"name":"Pearl"},{"id":45,"name":"Rust"},{"id":46,"name":"Sand"},{"id":47,"name":"Sapphire"},{"id":48,"name":"Slate"},{"id":49,"name":"Steel Blue"}]
/// fuelTypes : [{"id":1,"name":"Petrol"},{"id":2,"name":"Diesel"},{"id":3,"name":"CNG"},{"id":4,"name":"LPG"},{"id":5,"name":"Electric"},{"id":6,"name":"Hybrid"},{"id":7,"name":"Hydrogen"}]
/// gearTypes : [{"id":1,"name":"Manual"},{"id":2,"name":"Automatic"},{"id":3,"name":"Semi-Automatic"},{"id":4,"name":"CVT (Continuously Variable Transmission)"}]

class DriverDropdownData {
  DriverDropdownData({
      List<VehicleTypes>? vehicleTypes, 
      List<PaymentMethods>? paymentMethods, 
      List<VehicleBrands>? vehicleBrands, 
      List<VehicleColors>? colors, 
      List<FuelTypes>? fuelTypes, 
      List<GearTypes>? gearTypes,}){
    _vehicleTypes = vehicleTypes;
    _paymentMethods = paymentMethods;
    _vehicleBrands = vehicleBrands;
    _colors = colors;
    _fuelTypes = fuelTypes;
    _gearTypes = gearTypes;
}

  DriverDropdownData.fromJson(dynamic json) {
    if (json['vehicleTypes'] != null) {
      _vehicleTypes = [];
      json['vehicleTypes'].forEach((v) {
        _vehicleTypes?.add(VehicleTypes.fromJson(v));
      });
    }
    if (json['paymentMethods'] != null) {
      _paymentMethods = [];
      json['paymentMethods'].forEach((v) {
        _paymentMethods?.add(PaymentMethods.fromJson(v));
      });
    }
    if (json['vehicleBrands'] != null) {
      _vehicleBrands = [];
      json['vehicleBrands'].forEach((v) {
        _vehicleBrands?.add(VehicleBrands.fromJson(v));
      });
    }
    if (json['colors'] != null) {
      _colors = [];
      json['colors'].forEach((v) {
        _colors?.add(VehicleColors.fromJson(v));
      });
    }
    if (json['fuelTypes'] != null) {
      _fuelTypes = [];
      json['fuelTypes'].forEach((v) {
        _fuelTypes?.add(FuelTypes.fromJson(v));
      });
    }
    if (json['gearTypes'] != null) {
      _gearTypes = [];
      json['gearTypes'].forEach((v) {
        _gearTypes?.add(GearTypes.fromJson(v));
      });
    }
  }
  List<VehicleTypes>? _vehicleTypes;
  List<PaymentMethods>? _paymentMethods;
  List<VehicleBrands>? _vehicleBrands;
  List<VehicleColors>? _colors;
  List<FuelTypes>? _fuelTypes;
  List<GearTypes>? _gearTypes;
DriverDropdownData copyWith({  List<VehicleTypes>? vehicleTypes,
  List<PaymentMethods>? paymentMethods,
  List<VehicleBrands>? vehicleBrands,
  List<VehicleColors>? colors,
  List<FuelTypes>? fuelTypes,
  List<GearTypes>? gearTypes,
}) => DriverDropdownData(  vehicleTypes: vehicleTypes ?? _vehicleTypes,
  paymentMethods: paymentMethods ?? _paymentMethods,
  vehicleBrands: vehicleBrands ?? _vehicleBrands,
  colors: colors ?? _colors,
  fuelTypes: fuelTypes ?? _fuelTypes,
  gearTypes: gearTypes ?? _gearTypes,
);
  List<VehicleTypes>? get vehicleTypes => _vehicleTypes;
  List<PaymentMethods>? get paymentMethods => _paymentMethods;
  List<VehicleBrands>? get vehicleBrands => _vehicleBrands;
  List<VehicleColors>? get colors => _colors;
  List<FuelTypes>? get fuelTypes => _fuelTypes;
  List<GearTypes>? get gearTypes => _gearTypes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_vehicleTypes != null) {
      map['vehicleTypes'] = _vehicleTypes?.map((v) => v.toJson()).toList();
    }
    if (_paymentMethods != null) {
      map['paymentMethods'] = _paymentMethods?.map((v) => v.toJson()).toList();
    }
    if (_vehicleBrands != null) {
      map['vehicleBrands'] = _vehicleBrands?.map((v) => v.toJson()).toList();
    }
    if (_colors != null) {
      map['colors'] = _colors?.map((v) => v.toJson()).toList();
    }
    if (_fuelTypes != null) {
      map['fuelTypes'] = _fuelTypes?.map((v) => v.toJson()).toList();
    }
    if (_gearTypes != null) {
      map['gearTypes'] = _gearTypes?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 1
/// name : "Manual"

class GearTypes {
  GearTypes({
      num? id, 
      String? name,}){
    _id = id;
    _name = name;
}

  GearTypes.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  num? _id;
  String? _name;
GearTypes copyWith({  num? id,
  String? name,
}) => GearTypes(  id: id ?? _id,
  name: name ?? _name,
);
  num? get id => _id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }

}

/// id : 1
/// name : "Petrol"

class FuelTypes {
  FuelTypes({
      num? id, 
      String? name,}){
    _id = id;
    _name = name;
}

  FuelTypes.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  num? _id;
  String? _name;
FuelTypes copyWith({  num? id,
  String? name,
}) => FuelTypes(  id: id ?? _id,
  name: name ?? _name,
);
  num? get id => _id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }

}

/// id : 1
/// name : "Red"

class VehicleColors {
  VehicleColors({
      num? id, 
      String? name,}){
    _id = id;
    _name = name;
}

  VehicleColors.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  num? _id;
  String? _name;
VehicleColors copyWith({  num? id,
  String? name,
}) => VehicleColors(  id: id ?? _id,
  name: name ?? _name,
);
  num? get id => _id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }

}

/// id : 1
/// name : "Toyota"

class VehicleBrands {
  VehicleBrands({
      num? id, 
      String? name,}){
    _id = id;
    _name = name;
}

  VehicleBrands.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  num? _id;
  String? _name;
VehicleBrands copyWith({  num? id,
  String? name,
}) => VehicleBrands(  id: id ?? _id,
  name: name ?? _name,
);
  num? get id => _id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }

}

/// id : 4
/// name : "Nagad"

class PaymentMethods {
  PaymentMethods({
      num? id, 
      String? name,
      String? logo,
  }){
    _id = id;
    _name = name;
    _logo = logo;
}

  PaymentMethods.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _logo = json['gatewayImage'];
  }
  num? _id;
  String? _name;
  String? _logo;
PaymentMethods copyWith({  num? id,
  String? name,
  String? logo,
}) => PaymentMethods(  id: id ?? _id,
  name: name ?? _name,
  logo: logo ?? _logo,
);
  num? get id => _id;
  String? get name => _name;
  String? get logo => _logo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['gatewayImage'] = _logo;
    return map;
  }

}

/// id : 24
/// categoryName : "Auto"
/// slug : "ambulance-auto"
/// IconMediaId : 4
/// status : true
/// categoryImage : "178.128.59.117:3001/uploads/media/car-wash-thumbnail.png"

class VehicleTypes {
  VehicleTypes({
      num? id, 
      String? categoryName, 
      String? slug, 
      num? iconMediaId, 
      bool? status, 
      String? categoryImage,}){
    _id = id;
    _categoryName = categoryName;
    _slug = slug;
    _iconMediaId = iconMediaId;
    _status = status;
    _categoryImage = categoryImage;
}

  VehicleTypes.fromJson(dynamic json) {
    _id = json['id'];
    _categoryName = json['categoryName'];
    _slug = json['slug'];
    _iconMediaId = json['IconMediaId'];
    _status = json['status'];
    _categoryImage = json['categoryImage'];
  }
  num? _id;
  String? _categoryName;
  String? _slug;
  num? _iconMediaId;
  bool? _status;
  String? _categoryImage;
VehicleTypes copyWith({  num? id,
  String? categoryName,
  String? slug,
  num? iconMediaId,
  bool? status,
  String? categoryImage,
}) => VehicleTypes(  id: id ?? _id,
  categoryName: categoryName ?? _categoryName,
  slug: slug ?? _slug,
  iconMediaId: iconMediaId ?? _iconMediaId,
  status: status ?? _status,
  categoryImage: categoryImage ?? _categoryImage,
);
  num? get id => _id;
  String? get categoryName => _categoryName;
  String? get slug => _slug;
  num? get iconMediaId => _iconMediaId;
  bool? get status => _status;
  String? get categoryImage => _categoryImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['categoryName'] = _categoryName;
    map['slug'] = _slug;
    map['IconMediaId'] = _iconMediaId;
    map['status'] = _status;
    map['categoryImage'] = _categoryImage;
    return map;
  }

}