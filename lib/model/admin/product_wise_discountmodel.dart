class AProductWiseDiscountModel {
  bool? success;
  Null error;
  Body? body;

  AProductWiseDiscountModel({this.success, this.error, this.body});

  AProductWiseDiscountModel.fromJson(Map<String, dynamic> json) {
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
  List<ProductsDiscount>? productsDiscount;

  Body({this.productsDiscount});

  Body.fromJson(Map<String, dynamic> json) {
    if (json['products_discount'] != null) {
      productsDiscount = <ProductsDiscount>[];
      json['products_discount'].forEach((v) {
        productsDiscount!.add(new ProductsDiscount.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.productsDiscount != null) {
      data['products_discount'] =
          this.productsDiscount!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductsDiscount {
  int? id;
  int? productId;
  int? discount;
  int? status;
  Null deletedAt;
  String? createdAt;
  String? updatedAt;
  Product? product;

  ProductsDiscount(
      {this.id,
      this.productId,
      this.discount,
      this.status,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.product});

  ProductsDiscount.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    discount = json['discount'];
    status = json['status'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['discount'] = this.discount;
    data['status'] = this.status;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
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
