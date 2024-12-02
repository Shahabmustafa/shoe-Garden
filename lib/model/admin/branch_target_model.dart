class BranchTargetModel {
  bool? success;
  Null error;
  Body? body;

  BranchTargetModel({this.success, this.error, this.body});

  BranchTargetModel.fromJson(Map<String, dynamic> json) {
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
  List<BranchsTargets>? branchsTargets;

  Body({this.branchsTargets});

  Body.fromJson(Map<String, dynamic> json) {
    if (json['branchs_targets'] != null) {
      branchsTargets = <BranchsTargets>[];
      json['branchs_targets'].forEach((v) {
        branchsTargets!.add(new BranchsTargets.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.branchsTargets != null) {
      data['branchs_targets'] =
          this.branchsTargets!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BranchsTargets {
  int? id;
  int? branchId;
  String? amount;
  String? startDate;
  String? endDate;
  Null deletedAt;
  String? createdAt;
  String? updatedAt;
  Branch? branch;

  BranchsTargets(
      {this.id,
      this.branchId,
      this.amount,
      this.startDate,
      this.endDate,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.branch});

  BranchsTargets.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    branchId = json['branch_id'];
    amount = json['amount'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    branch =
        json['branch'] != null ? new Branch.fromJson(json['branch']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['branch_id'] = this.branchId;
    data['amount'] = this.amount;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.branch != null) {
      data['branch'] = this.branch!.toJson();
    }
    return data;
  }
}

class Branch {
  int? id;
  String? name;
  String? email;
  Null emailVerifiedAt;
  int? roleId;
  Null deletedAt;
  String? createdAt;
  String? updatedAt;

  Branch(
      {this.id,
      this.name,
      this.email,
      this.emailVerifiedAt,
      this.roleId,
      this.deletedAt,
      this.createdAt,
      this.updatedAt});

  Branch.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    roleId = json['role_id'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['role_id'] = this.roleId;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
