class AExpenseDetailModel {
  bool? success;
  Null error;
  Body? body;

  AExpenseDetailModel({this.success, this.error, this.body});

  AExpenseDetailModel.fromJson(Map<String, dynamic> json) {
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
  List<GeneralExpenses>? generalExpenses;

  Body({this.generalExpenses});

  Body.fromJson(Map<String, dynamic> json) {
    if (json['general_expenses'] != null) {
      generalExpenses = <GeneralExpenses>[];
      json['general_expenses'].forEach((v) {
        generalExpenses!.add(new GeneralExpenses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.generalExpenses != null) {
      data['general_expenses'] =
          this.generalExpenses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GeneralExpenses {
  int? id;
  int? expenseId;
  String? description;
  int? amount;
  String? date;
  Null deletedAt;
  String? createdAt;
  String? updatedAt;
  Expense? expense;

  GeneralExpenses(
      {this.id,
      this.expenseId,
      this.description,
      this.amount,
      this.date,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.expense});

  GeneralExpenses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    expenseId = json['expense_id'];
    description = json['description'];
    amount = json['amount'];
    date = json['date'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    expense =
        json['expense'] != null ? new Expense.fromJson(json['expense']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['expense_id'] = this.expenseId;
    data['description'] = this.description;
    data['amount'] = this.amount;
    data['date'] = this.date;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.expense != null) {
      data['expense'] = this.expense!.toJson();
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
