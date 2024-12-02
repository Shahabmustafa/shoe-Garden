import '../admin/brand_model.dart';
import '../admin/color_model.dart';
import '../admin/size_model.dart';

class BStockInventoryModel {
  bool? success;
  Null error;
  Body? body;

  BStockInventoryModel({this.success, this.error, this.body});

  BStockInventoryModel.fromJson(Map<String, dynamic> json) {
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
  List<BranchStocks>? branchStocks;

  Body({this.branchStocks});

  Body.fromJson(Map<String, dynamic> json) {
    if (json['branch_stocks'] != null) {
      branchStocks = <BranchStocks>[];
      json['branch_stocks'].forEach((v) {
        branchStocks!.add(new BranchStocks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.branchStocks != null) {
      data['branch_stocks'] =
          this.branchStocks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BranchStocks {
  int? id;
  String? branchId;
  String? assignedById;
  String? companyId;
  String? brandId;
  String? productId;
  String? typeId;
  String? colorId;
  String? sizeId;
  String? quantity;
  String? status;
  Null deletedAt;
  String? createdAt;
  String? updatedAt;
  String? discount;
  Branch? branch;
  Product? product;
  Company? company;
  Brands? brand;
  Colors? color;
  Sizes? size;
  Branch? assignedBy;
  Type? type;

  BranchStocks(
      {this.id,
      this.branchId,
      this.assignedById,
      this.companyId,
      this.brandId,
      this.productId,
      this.typeId,
      this.colorId,
      this.sizeId,
      this.quantity,
      this.status,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.discount,
      this.branch,
      this.product,
      this.company,
      this.brand,
      this.color,
      this.size,
      this.assignedBy,
      this.type});

  BranchStocks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    branchId = json['branch_id'];
    assignedById = json['assigned_by_id'];
    companyId = json['company_id'];
    brandId = json['brand_id'];
    productId = json['product_id'];
    typeId = json['type_id'];
    colorId = json['color_id'];
    sizeId = json['size_id'];
    quantity = json['quantity'];
    status = json['status'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    discount = json['discount'];
    branch =
        json['branch'] != null ? new Branch.fromJson(json['branch']) : null;
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
    company =
        json['company'] != null ? new Company.fromJson(json['company']) : null;
    brand = json['brand'];
    color = json['color'];
    size = json['size'];
    assignedBy = json['assigned_by'] != null
        ? new Branch.fromJson(json['assigned_by'])
        : null;
    type = json['type'] != null ? new Type.fromJson(json['type']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['branch_id'] = this.branchId;
    data['assigned_by_id'] = this.assignedById;
    data['company_id'] = this.companyId;
    data['brand_id'] = this.brandId;
    data['product_id'] = this.productId;
    data['type_id'] = this.typeId;
    data['color_id'] = this.colorId;
    data['size_id'] = this.sizeId;
    data['quantity'] = this.quantity;
    data['status'] = this.status;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['discount'] = this.discount;
    if (this.branch != null) {
      data['branch'] = this.branch!.toJson();
    }
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    if (this.company != null) {
      data['company'] = this.company!.toJson();
    }
    data['brand'] = this.brand;
    data['color'] = this.color;
    data['size'] = this.size;
    if (this.assignedBy != null) {
      data['assigned_by'] = this.assignedBy!.toJson();
    }
    if (this.type != null) {
      data['type'] = this.type!.toJson();
    }
    return data;
  }
}

class Branch {
  int? id;
  String? name;
  String? email;
  Null emailVerifiedAt;
  String? roleId;
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

class Product {
  int? id;
  String? name;
  String? productCode;
  String? image;
  String? salePrice;
  String? purchasePrice;
  String? status;
  Null deletedAt;
  String? createdAt;
  String? updatedAt;

  Product(
      {this.id,
      this.name,
      this.productCode,
      this.image,
      this.salePrice,
      this.purchasePrice,
      this.status,
      this.deletedAt,
      this.createdAt,
      this.updatedAt});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    productCode = json['product_code'];
    image = json['image'];
    salePrice = json['sale_price'];
    purchasePrice = json['purchase_price'];
    status = json['status'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['product_code'] = this.productCode;
    data['image'] = this.image;
    data['sale_price'] = this.salePrice;
    data['purchase_price'] = this.purchasePrice;
    data['status'] = this.status;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Company {
  int? id;
  String? name;
  String? email;
  String? phoneNumber;
  String? address;
  String? openingBalance;
  String? amountSpend;
  String? currentDate;
  Null deletedAt;
  String? createdAt;
  String? updatedAt;

  Company(
      {this.id,
      this.name,
      this.email,
      this.phoneNumber,
      this.address,
      this.openingBalance,
      this.amountSpend,
      this.currentDate,
      this.deletedAt,
      this.createdAt,
      this.updatedAt});

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    address = json['address'];
    openingBalance = json['opening_balance'];
    amountSpend = json['amount_spend'];
    currentDate = json['current_date'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone_number'] = this.phoneNumber;
    data['address'] = this.address;
    data['opening_balance'] = this.openingBalance;
    data['amount_spend'] = this.amountSpend;
    data['current_date'] = this.currentDate;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Type {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  Type({this.id, this.name, this.createdAt, this.updatedAt});

  Type.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
