class AAllBranchExpenseModel {
  bool? success;
  Null error;
  Body? body;

  AAllBranchExpenseModel({this.success, this.error, this.body});

  AAllBranchExpenseModel.fromJson(Map<String, dynamic> json) {
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
  List<BranchExpenses>? branchExpenses;

  Body({this.branchExpenses});

  Body.fromJson(Map<String, dynamic> json) {
    if (json['branch_expenses'] != null) {
      branchExpenses = <BranchExpenses>[];
      json['branch_expenses'].forEach((v) {
        branchExpenses!.add(new BranchExpenses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.branchExpenses != null) {
      data['branch_expenses'] =
          this.branchExpenses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BranchExpenses {
  int? id;
  int? expenseId;
  int? branchId;
  int? amount;
  String? date;
  Null deletedAt;
  String? createdAt;
  String? updatedAt;
  Expense? expense;
  Branch? branch;

  BranchExpenses(
      {this.id,
      this.expenseId,
      this.branchId,
      this.amount,
      this.date,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.expense,
      this.branch});

  BranchExpenses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    expenseId = json['expense_id'];
    branchId = json['branch_id'];
    amount = json['amount'];
    date = json['date'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    expense =
        json['expense'] != null ? new Expense.fromJson(json['expense']) : null;
    branch =
        json['branch'] != null ? new Branch.fromJson(json['branch']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['expense_id'] = this.expenseId;
    data['branch_id'] = this.branchId;
    data['amount'] = this.amount;
    data['date'] = this.date;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.expense != null) {
      data['expense'] = this.expense!.toJson();
    }
    if (this.branch != null) {
      data['branch'] = this.branch!.toJson();
    }
    return data;
  }
}

class Expense {
  int? id;
  String? name;
  Null deletedAt;
  String? createdAt;
  String? updatedAt;

  Expense({this.id, this.name, this.deletedAt, this.createdAt, this.updatedAt});

  Expense.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
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
