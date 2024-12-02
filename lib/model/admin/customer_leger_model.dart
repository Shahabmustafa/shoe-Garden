class ACustomerLedgerReportModel {
  bool? success;
  Null? error;
  Body? body;

  ACustomerLedgerReportModel({this.success, this.error, this.body});

  ACustomerLedgerReportModel.fromJson(Map<String, dynamic> json) {
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
  List<Customers>? customers;
  int? overallFirstBalance;
  double? overallOpeningBalance;

  Body({this.customers, this.overallFirstBalance, this.overallOpeningBalance});

  Body.fromJson(Map<String, dynamic> json) {
    if (json['customers'] != null) {
      customers = <Customers>[];
      json['customers'].forEach((v) {
        customers!.add(new Customers.fromJson(v));
      });
    }
    overallFirstBalance = json['overall_first_balance'];
    overallOpeningBalance = json['overall_opening_balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.customers != null) {
      data['customers'] = this.customers!.map((v) => v.toJson()).toList();
    }
    data['overall_first_balance'] = this.overallFirstBalance;
    data['overall_opening_balance'] = this.overallOpeningBalance;
    return data;
  }
}

class Customers {
  int? id;
  String? name;
  String? email;
  String? address;
  String? phoneNumber;
  int? firstBalance;
  double? openingBalance;
  List<Detail>? detail;

  Customers(
      {this.id,
        this.name,
        this.email,
        this.address,
        this.phoneNumber,
        this.firstBalance,
        this.openingBalance,
        this.detail});

  Customers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    address = json['address'];
    phoneNumber = json['phone_number'];
    firstBalance = json['first_balance'];
    openingBalance = json['opening_balance'];
    if (json['detail'] != null) {
      detail = <Detail>[];
      json['detail'].forEach((v) {
        detail!.add(new Detail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['address'] = this.address;
    data['phone_number'] = this.phoneNumber;
    data['first_balance'] = this.firstBalance;
    data['opening_balance'] = this.openingBalance;
    if (this.detail != null) {
      data['detail'] = this.detail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Detail {
  double? purchase;
  int? payment;
  String? description;
  String? date;
  double? exchangeAmount;
  double? returnAmount;
  String? createdAt;

  Detail(
      {this.purchase,
        this.payment,
        this.description,
        this.date,
        this.exchangeAmount,
        this.returnAmount,
        this.createdAt});

  Detail.fromJson(Map<String, dynamic> json) {
    purchase = json['purchase'];
    payment = json['payment'];
    description = json['description'];
    date = json['date'];
    exchangeAmount = json['exchange_amount'];
    returnAmount = json['return_amount'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['purchase'] = this.purchase;
    data['payment'] = this.payment;
    data['description'] = this.description;
    data['date'] = this.date;
    data['exchange_amount'] = this.exchangeAmount;
    data['return_amount'] = this.returnAmount;
    data['created_at'] = this.createdAt;
    return data;
  }
}
