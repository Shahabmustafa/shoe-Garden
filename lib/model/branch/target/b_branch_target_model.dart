class BBranchTargetModel {
  bool? success;
  String? error;
  Body? body;

  BBranchTargetModel({this.success, this.error, this.body});

  BBranchTargetModel.fromJson(Map<String, dynamic> json) {
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
  String? totalTarget;
  double? totalSale;
  List<DateList>? dateList;

  Body({this.totalTarget, this.totalSale, this.dateList});

  Body.fromJson(Map<String, dynamic> json) {
    totalTarget = json['total_target'];
    totalSale = json['total_sale'];
    if (json['dateList'] != null) {
      dateList = <DateList>[];
      json['dateList'].forEach((v) {
        dateList!.add(new DateList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_target'] = this.totalTarget;
    data['total_sale'] = this.totalSale;
    if (this.dateList != null) {
      data['dateList'] = this.dateList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DateList {
  String? date;
  String? targetAmount;
  double? tatalSale;

  DateList({this.date, this.targetAmount, this.tatalSale});

  DateList.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    targetAmount = json['target_amount'];
    tatalSale = json['tatal_sale'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['target_amount'] = this.targetAmount;
    data['tatal_sale'] = this.tatalSale;
    return data;
  }
}
