class ASalemenSalariesModel {
  bool? success;
  Null error;
  Body? body;

  ASalemenSalariesModel({this.success, this.error, this.body});

  ASalemenSalariesModel.fromJson(Map<String, dynamic> json) {
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
  List<SaleMenSalaries>? saleMenSalaries;

  Body({this.saleMenSalaries});

  Body.fromJson(Map<String, dynamic> json) {
    if (json['sale_men_salaries'] != null) {
      saleMenSalaries = <SaleMenSalaries>[];
      json['sale_men_salaries'].forEach((v) {
        saleMenSalaries!.add(new SaleMenSalaries.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.saleMenSalaries != null) {
      data['sale_men_salaries'] =
          this.saleMenSalaries!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SaleMenSalaries {
  int? id;
  int? branchId;
  String? name;
  String? phoneNumber;
  String? address;
  double? salary;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;
  double? commission;
  double? totalSale;
  double? commissionOnTotalSale;
  double? netSalary;
  List<Invoices>? invoices;

  SaleMenSalaries(
      {this.id,
      this.branchId,
      this.name,
      this.phoneNumber,
      this.address,
      this.salary,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.commission,
      this.totalSale,
      this.commissionOnTotalSale,
      this.netSalary,
      this.invoices});

  SaleMenSalaries.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    branchId = json['branch_id'];
    name = json['name'];
    phoneNumber = json['phone_number'];
    address = json['address'];
    salary = json['salary'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    commission = json['commission'];
    totalSale = json['total_sale'];
    commissionOnTotalSale = json['commission_on_total_sale'];
    netSalary = json['net_salary'];
    if (json['invoices'] != null) {
      invoices = <Invoices>[];
      json['invoices'].forEach((v) {
        invoices!.add(new Invoices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['branch_id'] = this.branchId;
    data['name'] = this.name;
    data['phone_number'] = this.phoneNumber;
    data['address'] = this.address;
    data['salary'] = this.salary;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['commission'] = this.commission;
    data['total_sale'] = this.totalSale;
    data['commission_on_total_sale'] = this.commissionOnTotalSale;
    data['net_salary'] = this.netSalary;
    if (this.invoices != null) {
      data['invoices'] = this.invoices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Invoices {
  int? id;
  int? branchId;
  int? customerId;
  int? saleMenId;
  double? subTotal;
  double? totalAmount;
  Null deletedAt;
  String? createdAt;
  String? updatedAt;
  int? invoiceNumber;

  Invoices(
      {this.id,
      this.branchId,
      this.customerId,
      this.saleMenId,
      this.subTotal,
      this.totalAmount,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.invoiceNumber});

  Invoices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    branchId = json['branch_id'];
    customerId = json['customer_id'];
    saleMenId = json['sale_men_id'];
    subTotal = json['sub_total'];
    totalAmount = json['total_amount'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    invoiceNumber = json['invoice_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['branch_id'] = this.branchId;
    data['customer_id'] = this.customerId;
    data['sale_men_id'] = this.saleMenId;
    data['sub_total'] = this.subTotal;
    data['total_amount'] = this.totalAmount;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['invoice_number'] = this.invoiceNumber;
    return data;
  }
}
