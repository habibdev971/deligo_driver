class WalletTransactionHistoryModel {
  WalletTransactionHistoryModel({
    this.status,
    this.message,
    this.data,});

  WalletTransactionHistoryModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? status;
  String? message;
  Data? data;
  WalletTransactionHistoryModel copyWith({  String? status,
    String? message,
    Data? data,
  }) => WalletTransactionHistoryModel(  status: status ?? this.status,
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

class Data {
  Data({
    this.disbursementHistory,
    this.pagination,});

  Data.fromJson(dynamic json) {
    if (json['disbursementHistory'] != null) {
      disbursementHistory = [];
      json['disbursementHistory'].forEach((v) {
        disbursementHistory?.add(Transaction.fromJson(v));
      });
    }
    pagination = json['pagination'] != null ? Pagination.fromJson(json['pagination']) : null;
  }
  List<Transaction>? disbursementHistory;
  Pagination? pagination;
  Data copyWith({  List<Transaction>? disbursementHistory,
    Pagination? pagination,
  }) => Data(  disbursementHistory: disbursementHistory ?? this.disbursementHistory,
    pagination: pagination ?? this.pagination,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (disbursementHistory != null) {
      map['disbursementHistory'] = disbursementHistory?.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      map['pagination'] = pagination?.toJson();
    }
    return map;
  }

}

class Transaction {
  Transaction({
    this.id,
    this.fleetManagerId,
    this.driverId,
    this.amount,
    this.notes,
    this.status,
    this.processedAt,
    this.createdAt,
    this.updatedAt,});

  Transaction.fromJson(dynamic json) {
    id = json['id'];
    fleetManagerId = json['fleetManagerId'];
    driverId = json['driverId'];
    amount = json['amount'];
    notes = json['notes'];
    status = json['status'];
    processedAt = json['processedAt'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }
  num? id;
  num? fleetManagerId;
  num? driverId;
  num? amount;
  String? notes;
  String? status;
  String? processedAt;
  String? createdAt;
  String? updatedAt;
  Transaction copyWith({  num? id,
    num? fleetManagerId,
    num? driverId,
    num? amount,
    String? notes,
    String? status,
    String? processedAt,
    String? createdAt,
    String? updatedAt,
  }) => Transaction(  id: id ?? this.id,
    fleetManagerId: fleetManagerId ?? this.fleetManagerId,
    driverId: driverId ?? this.driverId,
    amount: amount ?? this.amount,
    notes: notes ?? this.notes,
    status: status ?? this.status,
    processedAt: processedAt ?? this.processedAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['fleetManagerId'] = fleetManagerId;
    map['driverId'] = driverId;
    map['amount'] = amount;
    map['notes'] = notes;
    map['status'] = status;
    map['processedAt'] = processedAt;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    return map;
  }

}

class Pagination {
  Pagination({
    this.page,
    this.limit,
    this.total,
    this.totalPages,});

  Pagination.fromJson(dynamic json) {
    page = json['page'];
    limit = json['limit'];
    total = json['total'];
    totalPages = json['totalPages'];
  }
  num? page;
  num? limit;
  num? total;
  num? totalPages;
  Pagination copyWith({  num? page,
    num? limit,
    num? total,
    num? totalPages,
  }) => Pagination(  page: page ?? this.page,
    limit: limit ?? this.limit,
    total: total ?? this.total,
    totalPages: totalPages ?? this.totalPages,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['page'] = page;
    map['limit'] = limit;
    map['total'] = total;
    map['totalPages'] = totalPages;
    return map;
  }

}