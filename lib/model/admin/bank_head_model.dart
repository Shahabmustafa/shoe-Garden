class ABankHeadModel {
  bool? success;
  Null error;
  Body? body;

  ABankHeadModel({this.success, this.error, this.body});

  ABankHeadModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    error = json['error'];
    body = json['body'] != null ? Body.fromJson(json['body']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['error'] = error;
    if (body != null) {
      data['body'] = body!.toJson();
    }
    return data;
  }
}

class Body {
  List<BankHeads>? bankHeads;

  Body({this.bankHeads});

  Body.fromJson(Map<String, dynamic> json) {
    if (json['bank_heads'] != null) {
      bankHeads = <BankHeads>[];
      json['bank_heads'].forEach((v) {
        bankHeads!.add(BankHeads.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (bankHeads != null) {
      data['bank_heads'] = bankHeads!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BankHeads {
  int? id;
  String? name;
  String? accountNumber;
  int? balance;
  Null deletedAt;
  String? createdAt;
  String? updatedAt;

  BankHeads(
      {this.id,
      this.name,
      this.accountNumber,
      this.balance,
      this.deletedAt,
      this.createdAt,
      this.updatedAt});

  BankHeads.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    accountNumber = json['account_number'];
    balance = json['balance'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['account_number'] = accountNumber;
    data['balance'] = balance;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
