class AllBranchesSaleReportModel {
  bool? success;
  Null? error;
  Body? body;

  AllBranchesSaleReportModel({this.success, this.error, this.body});

  AllBranchesSaleReportModel.fromJson(Map<String, dynamic> json) {
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
  List<Invoices>? invoices;
  double? totalSale;
  int? totalQty;

  Body({this.invoices, this.totalSale, this.totalQty});

  Body.fromJson(Map<String, dynamic> json) {
    if (json['invoices'] != null) {
      invoices = <Invoices>[];
      json['invoices'].forEach((v) {
        invoices!.add(new Invoices.fromJson(v));
      });
    }
    totalSale = json['total_sale'];
    totalQty = json['total_qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.invoices != null) {
      data['invoices'] = this.invoices!.map((v) => v.toJson()).toList();
    }
    data['total_sale'] = this.totalSale;
    data['total_qty'] = this.totalQty;
    return data;
  }
}

class Invoices {
  int? id;
  int? branchId;
  int? customerId;
  int? saleMenId;
  int? subTotal;
  double? totalAmount;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;
  int? invoiceNumber;
  int? receivedAmount;
  Branch? branch;
  Customer? customer;
  Saleman? saleman;
  String? paymentMethod;
  List<InvoiceProducts>? invoiceProducts;

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
      this.invoiceNumber,
      this.receivedAmount,
      this.branch,
      this.customer,
      this.saleman,
      this.invoiceProducts});

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
    paymentMethod = json['payment_method'];
    receivedAmount = json['received_amount'];
    branch =
        json['branch'] != null ? new Branch.fromJson(json['branch']) : null;
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    saleman =
        json['saleman'] != null ? new Saleman.fromJson(json['saleman']) : null;
    if (json['invoice_products'] != null) {
      invoiceProducts = <InvoiceProducts>[];
      json['invoice_products'].forEach((v) {
        invoiceProducts!.add(new InvoiceProducts.fromJson(v));
      });
    }
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
    data['received_amount'] = this.receivedAmount;
    data['payment_method'] = this.paymentMethod;
    if (this.branch != null) {
      data['branch'] = this.branch!.toJson();
    }
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    if (this.saleman != null) {
      data['saleman'] = this.saleman!.toJson();
    }
    if (this.invoiceProducts != null) {
      data['invoice_products'] =
          this.invoiceProducts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Branch {
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

  Branch(
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

  Branch.fromJson(Map<String, dynamic> json) {
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

class Customer {
  int? id;
  String? name;
  String? email;
  String? phoneNumber;
  String? address;
  int? startingAmount;
  double? openingBalance;
  int? amountSpend;
  String? currentDate;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;

  Customer(
      {this.id,
      this.name,
      this.email,
      this.phoneNumber,
      this.address,
      this.startingAmount,
      this.openingBalance,
      this.amountSpend,
      this.currentDate,
      this.deletedAt,
      this.createdAt,
      this.updatedAt});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    address = json['address'];
    startingAmount = json['starting_amount'];
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
    data['starting_amount'] = this.startingAmount;
    data['opening_balance'] = this.openingBalance;
    data['amount_spend'] = this.amountSpend;
    data['current_date'] = this.currentDate;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Saleman {
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

  Saleman(
      {this.id,
      this.branchId,
      this.name,
      this.phoneNumber,
      this.address,
      this.salary,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.commission});

  Saleman.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}

class InvoiceProducts {
  int? id;
  int? saleInvoiceId;
  int? productId;
  int? companyId;
  int? brandId;
  int? typeId;
  int? colorId;
  int? sizeId;
  int? salePrice;
  int? purchasePrice;
  int? quantity;
  int? subTotal;
  int? discount;
  double? totalAmount;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;
  Product? product;
  Company? company;
  Brand? brand;
  Brand? color;
  Size? size;
  Type? type;

  InvoiceProducts(
      {this.id,
      this.saleInvoiceId,
      this.productId,
      this.companyId,
      this.brandId,
      this.typeId,
      this.colorId,
      this.sizeId,
      this.salePrice,
      this.purchasePrice,
      this.quantity,
      this.subTotal,
      this.discount,
      this.totalAmount,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.product,
      this.company,
      this.brand,
      this.color,
      this.size,
      this.type});

  InvoiceProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    saleInvoiceId = json['sale_invoice_id'];
    productId = json['product_id'];
    companyId = json['company_id'];
    brandId = json['brand_id'];
    typeId = json['type_id'];
    colorId = json['color_id'];
    sizeId = json['size_id'];
    salePrice = json['sale_price'];
    purchasePrice = json['purchase_price'];
    quantity = json['quantity'];
    subTotal = json['sub_total'];
    discount = json['discount'];
    totalAmount = json['total_amount'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
    company =
        json['company'] != null ? new Company.fromJson(json['company']) : null;
    brand = json['brand'] != null ? new Brand.fromJson(json['brand']) : null;
    color = json['color'] != null ? new Brand.fromJson(json['color']) : null;
    size = json['size'] != null ? new Size.fromJson(json['size']) : null;
    type = json['type'] != null ? new Type.fromJson(json['type']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sale_invoice_id'] = this.saleInvoiceId;
    data['product_id'] = this.productId;
    data['company_id'] = this.companyId;
    data['brand_id'] = this.brandId;
    data['type_id'] = this.typeId;
    data['color_id'] = this.colorId;
    data['size_id'] = this.sizeId;
    data['sale_price'] = this.salePrice;
    data['purchase_price'] = this.purchasePrice;
    data['quantity'] = this.quantity;
    data['sub_total'] = this.subTotal;
    data['discount'] = this.discount;
    data['total_amount'] = this.totalAmount;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
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