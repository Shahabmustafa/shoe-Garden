class ExchangeProductModel {
  bool? success;
  Null? error;
  List<Body>? body;

  ExchangeProductModel({this.success, this.error, this.body});

  ExchangeProductModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    error = json['error'];
    if (json['body'] != null) {
      body = <Body>[];
      json['body'].forEach((v) {
        body!.add(new Body.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['error'] = this.error;
    if (this.body != null) {
      data['body'] = this.body!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Body {
  int? id;
  int? saleInvoiceId;
  int? previousCustomerId;
  int? previousSaleMenId;
  int? previousSubTotal;
  int? previousTotalAmount;
  int? newCustomerId;
  int? newSaleMenId;
  int? newSubTotal;
  int? newTotalAmount;
  int? receivedAmount;
  int? returnAmount;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;
  int? invoiceNumber;
  Null? paymentMethod;
  List<ExchangesProducts>? exchangesProducts;

  Body(
      {this.id,
        this.saleInvoiceId,
        this.previousCustomerId,
        this.previousSaleMenId,
        this.previousSubTotal,
        this.previousTotalAmount,
        this.newCustomerId,
        this.newSaleMenId,
        this.newSubTotal,
        this.newTotalAmount,
        this.receivedAmount,
        this.returnAmount,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.invoiceNumber,
        this.paymentMethod,
        this.exchangesProducts});

  Body.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    saleInvoiceId = json['sale_invoice_id'];
    previousCustomerId = json['previous_customer_id'];
    previousSaleMenId = json['previous_sale_men_id'];
    previousSubTotal = json['previous_sub_total'];
    previousTotalAmount = json['previous_total_amount'];
    newCustomerId = json['new_customer_id'];
    newSaleMenId = json['new_sale_men_id'];
    newSubTotal = json['new_sub_total'];
    newTotalAmount = json['new_total_amount'];
    receivedAmount = json['received_amount'];
    returnAmount = json['return_amount'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    invoiceNumber = json['invoice_number'];
    paymentMethod = json['payment_method'];
    if (json['exchanges_products'] != null) {
      exchangesProducts = <ExchangesProducts>[];
      json['exchanges_products'].forEach((v) {
        exchangesProducts!.add(new ExchangesProducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sale_invoice_id'] = this.saleInvoiceId;
    data['previous_customer_id'] = this.previousCustomerId;
    data['previous_sale_men_id'] = this.previousSaleMenId;
    data['previous_sub_total'] = this.previousSubTotal;
    data['previous_total_amount'] = this.previousTotalAmount;
    data['new_customer_id'] = this.newCustomerId;
    data['new_sale_men_id'] = this.newSaleMenId;
    data['new_sub_total'] = this.newSubTotal;
    data['new_total_amount'] = this.newTotalAmount;
    data['received_amount'] = this.receivedAmount;
    data['return_amount'] = this.returnAmount;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['invoice_number'] = this.invoiceNumber;
    data['payment_method'] = this.paymentMethod;
    if (this.exchangesProducts != null) {
      data['exchanges_products'] =
          this.exchangesProducts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ExchangesProducts {
  int? id;
  int? exchangeSaleInvoicesId;
  int? previousProductId;
  int? previousCompanyId;
  int? previousBrandId;
  int? previousTypeId;
  int? previousColorId;
  int? previousSizeId;
  int? previousSalePrice;
  int? previousPurchasePrice;
  int? previousQuantity;
  int? previousSubTotal;
  int? previousDiscount;
  int? previousTotalAmount;
  int? newProductId;
  int? newCompanyId;
  int? newBrandId;
  int? newTypeId;
  int? newColorId;
  int? newSizeId;
  int? newSalePrice;
  int? newPurchasePrice;
  int? newQuantity;
  int? newSubTotal;
  int? newDiscount;
  int? newTotalAmount;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;
  PreviousProduct? previousProduct;
  PreviousCompany? previousCompany;
  PreviousBrand? previousBrand;
  PreviousType? previousType;
  PreviousBrand? previousColor;
  PreviousSize? previousSize;
  PreviousProduct? newProduct;
  PreviousCompany? newCompany;
  PreviousBrand? newBrand;
  PreviousType? newType;
  PreviousBrand? newColor;
  PreviousSize? newSize;

  ExchangesProducts(
      {this.id,
        this.exchangeSaleInvoicesId,
        this.previousProductId,
        this.previousCompanyId,
        this.previousBrandId,
        this.previousTypeId,
        this.previousColorId,
        this.previousSizeId,
        this.previousSalePrice,
        this.previousPurchasePrice,
        this.previousQuantity,
        this.previousSubTotal,
        this.previousDiscount,
        this.previousTotalAmount,
        this.newProductId,
        this.newCompanyId,
        this.newBrandId,
        this.newTypeId,
        this.newColorId,
        this.newSizeId,
        this.newSalePrice,
        this.newPurchasePrice,
        this.newQuantity,
        this.newSubTotal,
        this.newDiscount,
        this.newTotalAmount,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.previousProduct,
        this.previousCompany,
        this.previousBrand,
        this.previousType,
        this.previousColor,
        this.previousSize,
        this.newProduct,
        this.newCompany,
        this.newBrand,
        this.newType,
        this.newColor,
        this.newSize});

  ExchangesProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    exchangeSaleInvoicesId = json['exchange_sale_invoices_id'];
    previousProductId = json['previous_product_id'];
    previousCompanyId = json['previous_company_id'];
    previousBrandId = json['previous_brand_id'];
    previousTypeId = json['previous_type_id'];
    previousColorId = json['previous_color_id'];
    previousSizeId = json['previous_size_id'];
    previousSalePrice = json['previous_sale_price'];
    previousPurchasePrice = json['previous_purchase_price'];
    previousQuantity = json['previous_quantity'];
    previousSubTotal = json['previous_sub_total'];
    previousDiscount = json['previous_discount'];
    previousTotalAmount = json['previous_total_amount'];
    newProductId = json['new_product_id'];
    newCompanyId = json['new_company_id'];
    newBrandId = json['new_brand_id'];
    newTypeId = json['new_type_id'];
    newColorId = json['new_color_id'];
    newSizeId = json['new_size_id'];
    newSalePrice = json['new_sale_price'];
    newPurchasePrice = json['new_purchase_price'];
    newQuantity = json['new_quantity'];
    newSubTotal = json['new_sub_total'];
    newDiscount = json['new_discount'];
    newTotalAmount = json['new_total_amount'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    previousProduct = json['previous_product'] != null
        ? new PreviousProduct.fromJson(json['previous_product'])
        : null;
    previousCompany = json['previous_company'] != null
        ? new PreviousCompany.fromJson(json['previous_company'])
        : null;
    previousBrand = json['previous_brand'] != null
        ? new PreviousBrand.fromJson(json['previous_brand'])
        : null;
    previousType = json['previous_type'] != null
        ? new PreviousType.fromJson(json['previous_type'])
        : null;
    previousColor = json['previous_color'] != null
        ? new PreviousBrand.fromJson(json['previous_color'])
        : null;
    previousSize = json['previous_size'] != null
        ? new PreviousSize.fromJson(json['previous_size'])
        : null;
    newProduct = json['new_product'] != null
        ? new PreviousProduct.fromJson(json['new_product'])
        : null;
    newCompany = json['new_company'] != null
        ? new PreviousCompany.fromJson(json['new_company'])
        : null;
    newBrand = json['new_brand'] != null
        ? new PreviousBrand.fromJson(json['new_brand'])
        : null;
    newType = json['new_type'] != null
        ? new PreviousType.fromJson(json['new_type'])
        : null;
    newColor = json['new_color'] != null
        ? new PreviousBrand.fromJson(json['new_color'])
        : null;
    newSize = json['new_size'] != null
        ? new PreviousSize.fromJson(json['new_size'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['exchange_sale_invoices_id'] = this.exchangeSaleInvoicesId;
    data['previous_product_id'] = this.previousProductId;
    data['previous_company_id'] = this.previousCompanyId;
    data['previous_brand_id'] = this.previousBrandId;
    data['previous_type_id'] = this.previousTypeId;
    data['previous_color_id'] = this.previousColorId;
    data['previous_size_id'] = this.previousSizeId;
    data['previous_sale_price'] = this.previousSalePrice;
    data['previous_purchase_price'] = this.previousPurchasePrice;
    data['previous_quantity'] = this.previousQuantity;
    data['previous_sub_total'] = this.previousSubTotal;
    data['previous_discount'] = this.previousDiscount;
    data['previous_total_amount'] = this.previousTotalAmount;
    data['new_product_id'] = this.newProductId;
    data['new_company_id'] = this.newCompanyId;
    data['new_brand_id'] = this.newBrandId;
    data['new_type_id'] = this.newTypeId;
    data['new_color_id'] = this.newColorId;
    data['new_size_id'] = this.newSizeId;
    data['new_sale_price'] = this.newSalePrice;
    data['new_purchase_price'] = this.newPurchasePrice;
    data['new_quantity'] = this.newQuantity;
    data['new_sub_total'] = this.newSubTotal;
    data['new_discount'] = this.newDiscount;
    data['new_total_amount'] = this.newTotalAmount;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.previousProduct != null) {
      data['previous_product'] = this.previousProduct!.toJson();
    }
    if (this.previousCompany != null) {
      data['previous_company'] = this.previousCompany!.toJson();
    }
    if (this.previousBrand != null) {
      data['previous_brand'] = this.previousBrand!.toJson();
    }
    if (this.previousType != null) {
      data['previous_type'] = this.previousType!.toJson();
    }
    if (this.previousColor != null) {
      data['previous_color'] = this.previousColor!.toJson();
    }
    if (this.previousSize != null) {
      data['previous_size'] = this.previousSize!.toJson();
    }
    if (this.newProduct != null) {
      data['new_product'] = this.newProduct!.toJson();
    }
    if (this.newCompany != null) {
      data['new_company'] = this.newCompany!.toJson();
    }
    if (this.newBrand != null) {
      data['new_brand'] = this.newBrand!.toJson();
    }
    if (this.newType != null) {
      data['new_type'] = this.newType!.toJson();
    }
    if (this.newColor != null) {
      data['new_color'] = this.newColor!.toJson();
    }
    if (this.newSize != null) {
      data['new_size'] = this.newSize!.toJson();
    }
    return data;
  }
}

class PreviousProduct {
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

  PreviousProduct(
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

  PreviousProduct.fromJson(Map<String, dynamic> json) {
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

class PreviousCompany {
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

  PreviousCompany(
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

  PreviousCompany.fromJson(Map<String, dynamic> json) {
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

class PreviousBrand {
  int? id;
  String? name;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;

  PreviousBrand(
      {this.id, this.name, this.deletedAt, this.createdAt, this.updatedAt});

  PreviousBrand.fromJson(Map<String, dynamic> json) {
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

class PreviousType {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  PreviousType({this.id, this.name, this.createdAt, this.updatedAt});

  PreviousType.fromJson(Map<String, dynamic> json) {
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

class PreviousSize {
  int? id;
  int? number;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;

  PreviousSize(
      {this.id, this.number, this.deletedAt, this.createdAt, this.updatedAt});

  PreviousSize.fromJson(Map<String, dynamic> json) {
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
