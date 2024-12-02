class ACashVoucherModel {
  bool? success;
  String? error;
  Body? body;

  ACashVoucherModel({this.success, this.error, this.body});

  ACashVoucherModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    error = json['error'];
    body = json['body'] != null ? new Body.fromJson(json['body']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['error'] = this.error;
    if (this.body != null) {
      data['body'] = this.body!.toJson();
    }
    return data;
  }
}

class Body {
  List<CashVouchers>? cashVouchers;

  Body({this.cashVouchers});

  Body.fromJson(Map<String, dynamic> json) {
    if (json['cash_vouchers'] != null) {
      cashVouchers = <CashVouchers>[];
      json['cash_vouchers'].forEach((v) {
        cashVouchers!.add(new CashVouchers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cashVouchers != null) {
      data['cash_vouchers'] =
          this.cashVouchers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CashVouchers {
  int? id;
  int? customerId;
  int? amount;
  String? description;
  String? date;
  Null deletedAt;
  String? createdAt;
  String? updatedAt;
  Customer? customer;

  CashVouchers(
      {this.id,
      this.customerId,
      this.amount,
      this.description,
      this.date,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.customer});

  CashVouchers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    amount = json['amount'];
    description = json['description'];
    date = json['date'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['amount'] = this.amount;
    data['description'] = this.description;
    data['date'] = this.date;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    return data;
  }
}

class Customer {
  int? id;
  String? name;
  String? email;
  String? phoneNumber;
  String? address;
  int? openingBalance;
  int? amountSpend;
  String? currentDate;
  Null deletedAt;
  String? createdAt;
  String? updatedAt;

  Customer(
      {this.id,
      this.name,
      this.email,
      this.phoneNumber,
      this.address,
      this.openingBalance,
      this.amountSpend,
      this.currentDate,
      this.deletedAt,
      this.createdAt,
      this.updatedAt});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    address = json['address'];
    openingBalance = json['opening_balance'];
    amountSpend = json['amount_spend'];
    currentDate = json['current_date'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone_number'] = this.phoneNumber;
    data['address'] = this.address;
    data['opening_balance'] = this.openingBalance;
    data['amount_spend'] = this.amountSpend;
    data['current_date'] = this.currentDate;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
