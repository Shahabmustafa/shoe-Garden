class MyWarehouseStockModel {
  bool? success;
  Null? error;
  Body? body;

  MyWarehouseStockModel({this.success, this.error, this.body});

  MyWarehouseStockModel.fromJson(Map<String, dynamic> json) {
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
  List<WarehouseStocks>? warehouseStocks;
  int? sumOfSalePrice;
  int? sumOfPurchasePrice;
  int? sumOfQuantity;

  Body(
      {this.warehouseStocks,
        this.sumOfSalePrice,
        this.sumOfPurchasePrice,
        this.sumOfQuantity});

  Body.fromJson(Map<String, dynamic> json) {
    if (json['warehouse_stocks'] != null) {
      warehouseStocks = <WarehouseStocks>[];
      json['warehouse_stocks'].forEach((v) {
        warehouseStocks!.add(new WarehouseStocks.fromJson(v));
      });
    }
    sumOfSalePrice = json['sum_of_sale_price'];
    sumOfPurchasePrice = json['sum_of_purchase_price'];
    sumOfQuantity = json['sum_of_quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.warehouseStocks != null) {
      data['warehouse_stocks'] =
          this.warehouseStocks!.map((v) => v.toJson()).toList();
    }
    data['sum_of_sale_price'] = this.sumOfSalePrice;
    data['sum_of_purchase_price'] = this.sumOfPurchasePrice;
    data['sum_of_quantity'] = this.sumOfQuantity;
    return data;
  }
}

class WarehouseStocks {
  int? warehouseId;
  int? productId;
  int? companyId;
  int? brandId;
  int? colorId;
  int? sizeId;
  int? typeId;
  String? quantity;
  int? remainingQuantity;
  int? totalSalePrice;
  int? totalPurchasePrice;
  Product? product;
  Company? company;
  Brand? brand;
  Brand? color;
  Size? size;
  Type? type;
  Warehouse? warehouse;

  WarehouseStocks(
      {this.warehouseId,
        this.productId,
        this.companyId,
        this.brandId,
        this.colorId,
        this.sizeId,
        this.typeId,
        this.quantity,
        this.remainingQuantity,
        this.totalSalePrice,
        this.totalPurchasePrice,
        this.product,
        this.company,
        this.brand,
        this.color,
        this.size,
        this.type,
        this.warehouse});

  WarehouseStocks.fromJson(Map<String, dynamic> json) {
    warehouseId = json['warehouse_id'];
    productId = json['product_id'];
    companyId = json['company_id'];
    brandId = json['brand_id'];
    colorId = json['color_id'];
    sizeId = json['size_id'];
    typeId = json['type_id'];
    quantity = json['quantity'];
    remainingQuantity = json['remaining_quantity'];
    totalSalePrice = json['total_sale_price'];
    totalPurchasePrice = json['total_purchase_price'];
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
    company =
    json['company'] != null ? new Company.fromJson(json['company']) : null;
    brand = json['brand'] != null ? new Brand.fromJson(json['brand']) : null;
    color = json['color'] != null ? new Brand.fromJson(json['color']) : null;
    size = json['size'] != null ? new Size.fromJson(json['size']) : null;
    type = json['type'] != null ? new Type.fromJson(json['type']) : null;
    warehouse = json['warehouse'] != null
        ? new Warehouse.fromJson(json['warehouse'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['warehouse_id'] = this.warehouseId;
    data['product_id'] = this.productId;
    data['company_id'] = this.companyId;
    data['brand_id'] = this.brandId;
    data['color_id'] = this.colorId;
    data['size_id'] = this.sizeId;
    data['type_id'] = this.typeId;
    data['quantity'] = this.quantity;
    data['remaining_quantity'] = this.remainingQuantity;
    data['total_sale_price'] = this.totalSalePrice;
    data['total_purchase_price'] = this.totalPurchasePrice;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    if (this.company != null) {
      data['company'] = this.company!.toJson();
    }
    if (this.brand != null) {
      data['brand'] = this.brand!.toJson();
    }
    if (this.color != null) {
      data['color'] = this.color!.toJson();
    }
    if (this.size != null) {
      data['size'] = this.size!.toJson();
    }
    if (this.type != null) {
      data['type'] = this.type!.toJson();
    }
    if (this.warehouse != null) {
      data['warehouse'] = this.warehouse!.toJson();
    }
    return data;
  }
}

class Product {
  int? id;
  String? name;
  Null? productCode;
  String? image;
  int? salePrice;
  int? purchasePrice;
  int? status;
  Null? deletedAt;
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
  int? startingAmount;
  int? openingBalance;
  String? currentDate;
  int? amountSpend;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;

  Company(
      {this.id,
        this.name,
        this.email,
        this.phoneNumber,
        this.address,
        this.startingAmount,
        this.openingBalance,
        this.currentDate,
        this.amountSpend,
        this.deletedAt,
        this.createdAt,
        this.updatedAt});

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    address = json['address'];
    startingAmount = json['starting_amount'];
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
    data['starting_amount'] = this.startingAmount;
    data['opening_balance'] = this.openingBalance;
    data['current_date'] = this.currentDate;
    data['amount_spend'] = this.amountSpend;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Brand {
  int? id;
  String? name;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;

  Brand({this.id, this.name, this.deletedAt, this.createdAt, this.updatedAt});

  Brand.fromJson(Map<String, dynamic> json) {
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

class Size {
  int? id;
  int? number;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;

  Size({this.id, this.number, this.deletedAt, this.createdAt, this.updatedAt});

  Size.fromJson(Map<String, dynamic> json) {
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

class Warehouse {
  int? id;
  String? name;
  String? email;
  Null? emailVerifiedAt;
  int? roleId;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;
  String? phoneNumber;
  String? address;

  Warehouse(
      {this.id,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.roleId,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.phoneNumber,
        this.address});

  Warehouse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    roleId = json['role_id'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    phoneNumber = json['phone_number'];
    address = json['address'];
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
    data['phone_number'] = this.phoneNumber;
    data['address'] = this.address;
    return data;
  }
}
