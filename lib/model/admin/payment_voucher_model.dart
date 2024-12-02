class APaymentVoucherModel {
  bool? success;
  Null error;
  Body? body;

  APaymentVoucherModel({this.success, this.error, this.body});

  APaymentVoucherModel.fromJson(Map<String, dynamic> json) {
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
  List<PaymentVouchers>? paymentVouchers;

  Body({this.paymentVouchers});

  Body.fromJson(Map<String, dynamic> json) {
    if (json['payment_vouchers'] != null) {
      paymentVouchers = <PaymentVouchers>[];
      json['payment_vouchers'].forEach((v) {
        paymentVouchers!.add(new PaymentVouchers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.paymentVouchers != null) {
      data['payment_vouchers'] =
          this.paymentVouchers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PaymentVouchers {
  int? id;
  int? companyId;
  int? amount;
  int? amountSpend;
  String? description;
  String? date;
  Null deletedAt;
  String? createdAt;
  String? updatedAt;
  Company? company;

  PaymentVouchers(
      {this.id,
      this.companyId,
      this.amount,
      this.amountSpend,
      this.description,
      this.date,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.company});

  PaymentVouchers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['company_id'];
    amount = json['amount'];
    amountSpend = json['amount_spend'];
    description = json['description'];
    date = json['date'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    company =
        json['company'] != null ? new Company.fromJson(json['company']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['company_id'] = this.companyId;
    data['amount'] = this.amount;
    data['amount_spend'] = this.amountSpend;
    data['description'] = this.description;
    data['date'] = this.date;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.company != null) {
      data['company'] = this.company!.toJson();
    }
    return data;
  }
}

class Company {
  int? id;
  String? name;
  String? email;
  String? phoneNumber;
  String? address;
  int? openingBalance;
  String? currentDate;
  int? amountSpend;
  Null deletedAt;
  String? createdAt;
  String? updatedAt;

  Company(
      {this.id,
      this.name,
      this.email,
      this.phoneNumber,
      this.address,
      this.openingBalance,
      this.currentDate,
      this.amountSpend,
      this.deletedAt,
      this.createdAt,
      this.updatedAt});

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    address = json['address'];
    openingBalance = json['opening_balance'];
    currentDate = json['current_date'];
    amountSpend = json['amount_spend'];
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
    data['current_date'] = this.currentDate;
    data['amount_spend'] = this.amountSpend;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
