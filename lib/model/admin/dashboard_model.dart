class ADashboardModel {
  bool? success;
  Null error;
  Body? body;

  ADashboardModel({this.success, this.error, this.body});

  ADashboardModel.fromJson(Map<String, dynamic> json) {
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
  int? totalProducts;
  int? totalSaleInvoices;
  int? totalPurchaseInvoices;
  int? totalWarehouses;
  int? totalBranches;
  double? totalSale;
  List<MostRepeatedProducts>? mostRepeatedProducts;

  Body(
      {this.totalProducts,
      this.totalSaleInvoices,
      this.totalPurchaseInvoices,
      this.totalWarehouses,
      this.totalBranches,
      this.totalSale,
      this.mostRepeatedProducts});

  Body.fromJson(Map<String, dynamic> json) {
    totalProducts = json['total_products'];
    totalSaleInvoices = json['total_sale_invoices'];
    totalPurchaseInvoices = json['total_purchase_invoices'];
    totalWarehouses = json['total_warehouses'];
    totalBranches = json['total_branches'];
    totalSale = json['total_sale'];
    if (json['mostRepeatedProducts'] != null) {
      mostRepeatedProducts = <MostRepeatedProducts>[];
      json['mostRepeatedProducts'].forEach((v) {
        mostRepeatedProducts!.add(new MostRepeatedProducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_products'] = this.totalProducts;
    data['total_sale_invoices'] = this.totalSaleInvoices;
    data['total_purchase_invoices'] = this.totalPurchaseInvoices;
    data['total_warehouses'] = this.totalWarehouses;
    data['total_branches'] = this.totalBranches;
    data['total_sale'] = this.totalSale;
    if (this.mostRepeatedProducts != null) {
      data['mostRepeatedProducts'] =
          this.mostRepeatedProducts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MostRepeatedProducts {
  int? productId;
  int? companyId;
  int? brandId;
  int? sizeId;
  int? colorId;
  int? typeId;
  int? count;
  Product? product;
  Company? company;
  Brand? brand;
  Size? size;
  Brand? color;
  Type? type;

  MostRepeatedProducts(
      {this.productId,
      this.companyId,
      this.brandId,
      this.sizeId,
      this.colorId,
      this.typeId,
      this.count,
      this.product,
      this.company,
      this.brand,
      this.size,
      this.color,
      this.type});

  MostRepeatedProducts.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    companyId = json['company_id'];
    brandId = json['brand_id'];
    sizeId = json['size_id'];
    colorId = json['color_id'];
    typeId = json['type_id'];
    count = json['count'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
    company =
        json['company'] != null ? new Company.fromJson(json['company']) : null;
    brand = json['brand'] != null ? new Brand.fromJson(json['brand']) : null;
    size = json['size'] != null ? new Size.fromJson(json['size']) : null;
    color = json['color'] != null ? new Brand.fromJson(json['color']) : null;
    type = json['type'] != null ? new Type.fromJson(json['type']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['company_id'] = this.companyId;
    data['brand_id'] = this.brandId;
    data['size_id'] = this.sizeId;
    data['color_id'] = this.colorId;
    data['type_id'] = this.typeId;
    data['count'] = this.count;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    if (this.company != null) {
      data['company'] = this.company!.toJson();
    }
    if (this.brand != null) {
      data['brand'] = this.brand!.toJson();
    }
    if (this.size != null) {
      data['size'] = this.size!.toJson();
    }
    if (this.color != null) {
      data['color'] = this.color!.toJson();
    }
    if (this.type != null) {
      data['type'] = this.type!.toJson();
    }
    return data;
  }
}

class Product {
  int? id;
  String? name;
  Null productCode;
  String? image;
  int? salePrice;
  int? purchasePrice;
  int? status;
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
  int? openingBalance;
  String? currentDate;
  int? amountSpend;
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

class Brand {
  int? id;
  String? name;
  Null deletedAt;
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
  Null deletedAt;
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
