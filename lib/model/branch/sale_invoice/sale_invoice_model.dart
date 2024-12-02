class SaleInvoiceModel {
  String? customerId;
  String? saleMenId;
  String? subTotal;
  String? totalAmount;
  String? invoiceNumber;
  List<ProductModel>? products;

  SaleInvoiceModel(
      {this.customerId,
      this.saleMenId,
      this.subTotal,
      this.totalAmount,
      this.invoiceNumber,
      this.products});

  SaleInvoiceModel.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    saleMenId = json['sale_men_id'];
    subTotal = json['sub_total'];
    totalAmount = json['total_amount'];
    invoiceNumber = json['invoice_number'];
    if (json['products'] != null) {
      products = <ProductModel>[];
      json['products'].forEach((v) {
        products!.add(new ProductModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_id'] = this.customerId;
    data['sale_men_id'] = this.saleMenId;
    data['sub_total'] = this.subTotal;
    data['total_amount'] = this.totalAmount;
    data['invoice_number'] = this.invoiceNumber;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductModel {
  String? productId;
  String? companyId;
  String? brandId;
  String? typeId;
  String? colorId;
  String? sizeId;
  String? quantity;
  String? subTotal;
  String? discount;
  String? totalAmount;

  ProductModel(
      {this.productId,
      this.companyId,
      this.brandId,
      this.typeId,
      this.colorId,
      this.sizeId,
      this.quantity,
      this.subTotal,
      this.discount,
      this.totalAmount});

  ProductModel.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    companyId = json['company_id'];
    brandId = json['brand_id'];
    typeId = json['type_id'];
    colorId = json['color_id'];
    sizeId = json['size_id'];
    quantity = json['quantity'];
    subTotal = json['sub_total'];
    discount = json['discount'];
    totalAmount = json['total_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['company_id'] = this.companyId;
    data['brand_id'] = this.brandId;
    data['type_id'] = this.typeId;
    data['color_id'] = this.colorId;
    data['size_id'] = this.sizeId;
    data['quantity'] = this.quantity;
    data['sub_total'] = this.subTotal;
    data['discount'] = this.discount;
    data['total_amount'] = this.totalAmount;
    return data;
  }
}
