class ABankEntryModel {
  bool? success;
  Null error;
  Body? body;

  ABankEntryModel({this.success, this.error, this.body});

  ABankEntryModel.fromJson(Map<String, dynamic> json) {
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
  int? totalBalnce;
  List<BankEnteries>? bankEnteries;

  Body({this.totalBalnce, this.bankEnteries});

  Body.fromJson(Map<String, dynamic> json) {
    totalBalnce = json['total_balnce'];
    if (json['bank_enteries'] != null) {
      bankEnteries = <BankEnteries>[];
      json['bank_enteries'].forEach((v) {
        bankEnteries!.add(new BankEnteries.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_balnce'] = this.totalBalnce;
    if (this.bankEnteries != null) {
      data['bank_enteries'] =
          this.bankEnteries!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BankEnteries {
  int? id;
  int? bankHeadId;
  int? type;
  String? description;
  int? deposit;
  int? withdraw;
  String? date;
  Null deletedAt;
  String? createdAt;
  String? updatedAt;
  BankHead? bankHead;

  BankEnteries(
      {this.id,
      this.bankHeadId,
      this.type,
      this.description,
      this.deposit,
      this.withdraw,
      this.date,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.bankHead});

  BankEnteries.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bankHeadId = json['bank_head_id'];
    type = json['type'];
    description = json['description'];
    deposit = json['deposit'];
    withdraw = json['withdraw'];
    date = json['date'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    bankHead = json['bank_head'] != null
        ? new BankHead.fromJson(json['bank_head'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bank_head_id'] = this.bankHeadId;
    data['type'] = this.type;
    data['description'] = this.description;
    data['deposit'] = this.deposit;
    data['withdraw'] = this.withdraw;
    data['date'] = this.date;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.bankHead != null) {
      data['bank_head'] = this.bankHead!.toJson();
    }
    return data;
  }
}

class BankHead {
  int? id;
  String? name;
  String? accountNumber;
  int? balance;
  Null deletedAt;
  String? createdAt;
  String? updatedAt;

  BankHead(
      {this.id,
      this.name,
      this.accountNumber,
      this.balance,
      this.deletedAt,
      this.createdAt,
      this.updatedAt});

  BankHead.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    accountNumber = json['account_number'];
    balance = json['balance'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['account_number'] = this.accountNumber;
    data['balance'] = this.balance;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
