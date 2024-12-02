class ExchangProductItemModel {
  late final String brandId;
  String colorId;
  late final String typeId;
  String sizeId;
  late final String companyId;
  String productId;
  late final String name;
  final String color;
  final String size;
  String subTotal;
  String totalAmount;
  int quantity;

  double salePrice;
  late final double? discount;
  int? previousProductId;

  ExchangProductItemModel({
    required this.subTotal,
    required this.totalAmount,
    required this.brandId,
    required this.colorId,
    required this.typeId,
    required this.sizeId,
    required this.companyId,
    required this.productId,
    required this.name,
    required this.color,
    required this.size,
    required this.quantity,
    required this.salePrice,
    this.discount,
    this.previousProductId,
  });
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'color': color,
      'size': size,
      'quantity': quantity,
      'salePrice': salePrice,
      'discount': discount,
      'subTotal': subTotal,
      'totalAmount': totalAmount,
      'brandId': brandId,
      'colorId': colorId,
      'typeId': typeId,
      'sizeId': sizeId,
      'companyId': companyId,
      'productId': productId,
      'previousProductId': previousProductId,
    };
  }

  void incrementQuantity() {
    quantity++;
  }

  void decrementQuantity() {
    if (quantity > 1) {
      quantity--;
    }
  }

  double getSubtotal() {
    return quantity * salePrice;
  }

  double getTotal() {
    return getSubtotal() - (discount ?? 0);
  }
}
