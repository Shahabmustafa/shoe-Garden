import 'package:hive/hive.dart';

part 'purchase_invoice_model.g.dart'; // Hive code generator part file

@HiveType(typeId: 2)
class PurchaseInvoiceLocalStorageModel extends HiveObject {
  @HiveField(0)
  String? companyId;

  @HiveField(1)
  String? subTotal;

  @HiveField(2)
  String? totalAmount;

  @HiveField(3)
  String? invoiceNumber;

  @HiveField(4)
  List<PurchaseModel>? products;

  @HiveField(5)
  String? receivedAmount;

  PurchaseInvoiceLocalStorageModel(
      {this.companyId,
        this.subTotal,
        this.totalAmount,
        this.invoiceNumber,
        this.products,
        this.receivedAmount});

  PurchaseInvoiceLocalStorageModel.fromJson(Map<String, dynamic> json) {
    companyId = json['compay_id'];
    subTotal = json['sub_total'];
    totalAmount = json['total_amount'];

    receivedAmount = json['received_amount'];
    invoiceNumber = json['invoice_number'];
    if (json['products'] != null) {
      products = <PurchaseModel>[];
      json['products'].forEach((v) {
        products!.add(new PurchaseModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['company_id'] = this.companyId;
    data['sub_total'] = this.subTotal;
    data['received_amount'] = this.receivedAmount;
    data['total_amount'] = this.totalAmount;
    data['invoice_number'] = this.invoiceNumber;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

@HiveType(typeId: 3)
class PurchaseModel {
  @HiveField(0)
  String? productId;

  @HiveField(1)
  String? companyId;

  @HiveField(2)
  String? brandId;

  @HiveField(3)
  String? typeId;

  @HiveField(4)
  String? colorId;

  @HiveField(5)
  String? sizeId;

  @HiveField(6)
  String? quantity;

  @HiveField(7)
  String? subTotal;

  @HiveField(8)
  String? discount;

  @HiveField(9)
  String? totalAmount;

  @HiveField(10)
  String? productName;

  @HiveField(11)
  String? colorName;

  @HiveField(12)
  String? sizeNumber;


  PurchaseModel(
      {this.productId,
        this.productName,
        this.sizeNumber,
        this.colorName,
        this.companyId,
        this.brandId,
        this.typeId,
        this.colorId,
        this.sizeId,
        this.quantity,
        this.subTotal,
        this.discount,
        this.totalAmount});

  PurchaseModel.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    companyId = json['company_id'];
    brandId = json['brand_id'];
    productName = json['product_name'];
    colorName = json['color_name'];
    sizeNumber = json['size_number'];

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

    data['product_name'] = this.productName;
    data['color_name'] = this.colorName;
    data['size_number'] = this.sizeNumber;

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