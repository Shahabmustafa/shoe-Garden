class ASetSaleModel {
  bool? success;
  Null error;
  Body? body;

  ASetSaleModel({this.success, this.error, this.body});

  ASetSaleModel.fromJson(Map<String, dynamic> json) {
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
  Commission? commission;

  Body({this.commission});

  Body.fromJson(Map<String, dynamic> json) {
    commission = json['commission'] != null
        ? Commission.fromJson(json['commission'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (commission != null) {
      data['commission'] = commission!.toJson();
    }
    return data;
  }
}

class Commission {
  int? id;
  String? commissionPercentage;
  String? date;
  String? createdAt;
  String? updatedAt;

  Commission(
      {this.id,
      this.commissionPercentage,
      this.date,
      this.createdAt,
      this.updatedAt});

  Commission.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    commissionPercentage = json['commission_percentage'];
    date = json['date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['commission_percentage'] = commissionPercentage;
    data['date'] = date;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
