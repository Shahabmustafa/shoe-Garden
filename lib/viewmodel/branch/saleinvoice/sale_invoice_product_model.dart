class SaleInvoiceProductModel {
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

  SaleInvoiceProductModel(
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

  SaleInvoiceProductModel.fromJson(Map<String, dynamic> json) {
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
