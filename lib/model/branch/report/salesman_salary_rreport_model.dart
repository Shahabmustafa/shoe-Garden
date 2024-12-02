class SalmanSalaryReportModel {
  bool? success;
  Null? error;
  Body? body;

  SalmanSalaryReportModel({this.success, this.error, this.body});

  SalmanSalaryReportModel.fromJson(Map<String, dynamic> json) {
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
  List<SaleMen>? saleMen;

  Body({this.saleMen});

  Body.fromJson(Map<String, dynamic> json) {
    if (json['sale_men'] != null) {
      saleMen = <SaleMen>[];
      json['sale_men'].forEach((v) {
        saleMen!.add(new SaleMen.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.saleMen != null) {
      data['sale_men'] = this.saleMen!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SaleMen {
  int? id;
  int? branchId;
  String? name;
  String? phoneNumber;
  String? address;
  int? salary;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;
  double? commission;
  double? totalSale;
  double? totalCommission;
  double? totalSalary;
  double? totalSalaryWithCommission;

  SaleMen(
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
        this.totalCommission,
        this.totalSalary,
        this.totalSalaryWithCommission});

  SaleMen.fromJson(Map<String, dynamic> json) {
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
    totalCommission = json['total_commission'];
    totalSalary = json['total_salary'];
    totalSalaryWithCommission = json['total_salary_with_commission'];
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
    data['total_commission'] = this.totalCommission;
    data['total_salary'] = this.totalSalary;
    data['total_salary_with_commission'] = this.totalSalaryWithCommission;
    return data;
  }
}
