class SaleInvoiceBarcodeModel {
  bool? success;
  Null error;
  Body? body;

  SaleInvoiceBarcodeModel({this.success, this.error, this.body});

  SaleInvoiceBarcodeModel.fromJson(Map<String, dynamic> json) {
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
  Product? product;
  Companies? companies;
  Brands? brands;
  Colors? colors;
  Sizes? sizes;
  Types? types;
  int? totalQuantity;

  Body(
      {this.product,
      this.companies,
      this.brands,
      this.colors,
      this.sizes,
      this.types,
      this.totalQuantity});

  Body.fromJson(Map<String, dynamic> json) {
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
    companies = json['companies'] != null
        ? new Companies.fromJson(json['companies'])
        : null;
    brands =
        json['brands'] != null ? new Brands.fromJson(json['brands']) : null;
    colors =
        json['colors'] != null ? new Colors.fromJson(json['colors']) : null;
    sizes = json['sizes'] != null ? new Sizes.fromJson(json['sizes']) : null;
    types = json['types'] != null ? new Types.fromJson(json['types']) : null;
    totalQuantity = json['total_quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    if (this.companies != null) {
      data['companies'] = this.companies!.toJson();
    }
    if (this.brands != null) {
      data['brands'] = this.brands!.toJson();
    }
    if (this.colors != null) {
      data['colors'] = this.colors!.toJson();
    }
    if (this.sizes != null) {
      data['sizes'] = this.sizes!.toJson();
    }
    if (this.types != null) {
      data['types'] = this.types!.toJson();
    }
    data['total_quantity'] = this.totalQuantity;
    return data;
  }
}

class Product {
  int? id;
  String? name;
  int? salePrice;
  int? purchasePrice;
  int? status;
  Null deletedAt;
  String? createdAt;
  String? updatedAt;
  int? discount;

  Product(
      {this.id,
      this.name,
      this.salePrice,
      this.purchasePrice,
      this.status,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.discount});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    salePrice = json['sale_price'];
    purchasePrice = json['purchase_price'];
    status = json['status'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    discount = json['discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['sale_price'] = this.salePrice;
    data['purchase_price'] = this.purchasePrice;
    data['status'] = this.status;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['discount'] = this.discount;
    return data;
  }
}

class Companies {
  int? id;
  String? name;
  String? email;
  String? phoneNumber;
  String? address;
  int? openingBalance;
  String? currentDate;
  int? amountSpend;
  Null deletedAt;
  String? createdAt;
  String? updatedAt;

  Companies(
      {this.id,
      this.name,
      this.email,
      this.phoneNumber,
      this.address,
      this.openingBalance,
      this.currentDate,
      this.amountSpend,
      this.deletedAt,
      this.createdAt,
      this.updatedAt});

  Companies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    address = json['address'];
    openingBalance = json['opening_balance'];
    currentDate = json['current_date'];
    amountSpend = json['amount_spend'];
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
    data['current_date'] = this.currentDate;
    data['amount_spend'] = this.amountSpend;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Brands {
  int? id;
  String? name;
  Null deletedAt;
  String? createdAt;
  String? updatedAt;

  Brands({this.id, this.name, this.deletedAt, this.createdAt, this.updatedAt});

  Brands.fromJson(Map<String, dynamic> json) {
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

class Colors {
  int? id;
  String? name;
  Null deletedAt;
  String? createdAt;
  String? updatedAt;

  Colors({this.id, this.name, this.deletedAt, this.createdAt, this.updatedAt});

  Colors.fromJson(Map<String, dynamic> json) {
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

class Sizes {
  int? id;
  int? number;
  Null deletedAt;
  String? createdAt;
  String? updatedAt;

  Sizes({this.id, this.number, this.deletedAt, this.createdAt, this.updatedAt});

  Sizes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    number = json['number'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['number'] = this.number;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Types {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  Types({this.id, this.name, this.createdAt, this.updatedAt});

  Types.fromJson(Map<String, dynamic> json) {
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