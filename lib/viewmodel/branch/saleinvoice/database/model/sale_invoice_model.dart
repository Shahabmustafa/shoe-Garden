import 'package:hive/hive.dart';

part 'sale_invoice_model.g.dart'; // Hive code generator part file

@HiveType(typeId: 0)
class SaleInvoiceModelLocalStorage extends HiveObject {
  @HiveField(0)
  String? customerId;

  @HiveField(1)
  String? saleMenId;

  @HiveField(2)
  String? subTotal;

  @HiveField(3)
  String? totalAmount;

  @HiveField(4)
  String? invoiceNumber;
  @HiveField(5)
  String? receivedAmount;

  @HiveField(6)
  List<InvoiceProducts>? products;

  SaleInvoiceModelLocalStorage(
      {this.receivedAmount,
      this.customerId,
      this.saleMenId,
      this.subTotal,
      this.totalAmount,
      this.invoiceNumber,
      this.products});

  SaleInvoiceModelLocalStorage.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    saleMenId = json['sale_men_id'];
    subTotal = json['sub_total'];

    receivedAmount = json['received_amount'];
    totalAmount = json['total_amount'];
    invoiceNumber = json['invoice_number'];
    if (json['products'] != null) {
      products = <InvoiceProducts>[];
      json['products'].forEach((v) {
        products!.add(new InvoiceProducts.fromJson(v));
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

    data['received_amount'] = this.receivedAmount;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

@HiveType(typeId: 1)
class InvoiceProducts {
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


  InvoiceProducts(
      {this.productId,
        this.productName,
        this.colorName,
        this.sizeNumber,
      this.companyId,
      this.brandId,
      this.typeId,
      this.colorId,
      this.sizeId,
      this.quantity,
      this.subTotal,
      this.discount,
      this.totalAmount});

  InvoiceProducts.fromJson(Map<String, dynamic> json) {
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
