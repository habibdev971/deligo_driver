
class WalletBalanceModel {
  WalletBalanceModel({
    this.status,
    this.message,
    this.data,});

  WalletBalanceModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? WalletBalance.fromJson(json['data']) : null;
  }
  String? status;
  String? message;
  WalletBalance? data;
  WalletBalanceModel copyWith({  String? status,
    String? message,
    WalletBalance? data,
  }) => WalletBalanceModel(  status: status ?? this.status,
    message: message ?? this.message,
    data: data ?? this.data,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

class WalletBalance {
  WalletBalance({
    this.id,
    this.driverId,
    this.currency,
    this.receivedAmount,
    this.paymentWithdraw,
    this.balance,
    this.totalBonusWitdraw,
    this.remarks,
    this.updatedAt,
    this.createdAt,});

  WalletBalance.fromJson(dynamic json) {
    id = json['id'];
    driverId = json['driverId'];
    currency = json['currency'];
    receivedAmount = json['receivedAmount'];
    paymentWithdraw = json['paymentWithdraw'];
    balance = json['balance'];
    totalBonusWitdraw = json['totalBonusWitdraw'];
    remarks = json['remarks'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
  }
  num? id;
  num? driverId;
  String? currency;
  num? receivedAmount;
  num? paymentWithdraw;
  num? balance;
  num? totalBonusWitdraw;
  String? remarks;
  String? updatedAt;
  String? createdAt;
  WalletBalance copyWith({  num? id,
    num? driverId,
    String? currency,
    num? receivedAmount,
    num? paymentWithdraw,
    num? balance,
    num? totalBonusWitdraw,
    String? remarks,
    String? updatedAt,
    String? createdAt,
  }) => WalletBalance(  id: id ?? this.id,
    driverId: driverId ?? this.driverId,
    currency: currency ?? this.currency,
    receivedAmount: receivedAmount ?? this.receivedAmount,
    paymentWithdraw: paymentWithdraw ?? this.paymentWithdraw,
    balance: balance ?? this.balance,
    totalBonusWitdraw: totalBonusWitdraw ?? this.totalBonusWitdraw,
    remarks: remarks ?? this.remarks,
    updatedAt: updatedAt ?? this.updatedAt,
    createdAt: createdAt ?? this.createdAt,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['driverId'] = driverId;
    map['currency'] = currency;
    map['receivedAmount'] = receivedAmount;
    map['paymentWithdraw'] = paymentWithdraw;
    map['balance'] = balance;
    map['totalBonusWitdraw'] = totalBonusWitdraw;
    map['remarks'] = remarks;
    map['updatedAt'] = updatedAt;
    map['createdAt'] = createdAt;
    return map;
  }

}