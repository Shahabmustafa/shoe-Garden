import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/date/response/status.dart';
import 'package:sofi_shoes/res/circularindictor/circularindicator.dart';
import 'package:sofi_shoes/res/widget/general_execption_widget.dart';
import 'package:sofi_shoes/res/widget/textfield/app_text_field.dart';

import '../../../../../res/responsive.dart';
import '../../../../../res/slidebar/side_menu_warehouse.dart';
import '../../../../viewmodel/warehouse/purchase invoice/returned_purchase_invoice_viewmodel.dart';
import '../saleinvoice/saleReturn/w_add_sale_return.dart';

class WAddReturnPurchase extends StatefulWidget {
  const WAddReturnPurchase({
    required this.uid,
    required this.user,
    required this.company,
    required this.invoiceNo,
    required this.products,
    required this.salesmanId,
    required this.companyId,
    super.key,
  });

  final String uid;
  final String user;
  final String company;
  final String invoiceNo;
  final String salesmanId;
  final String companyId;
  final List<WProduct> products;

  @override
  State<WAddReturnPurchase> createState() => _WAddReturnPurchaseState();
}

class _WAddReturnPurchaseState extends State<WAddReturnPurchase> {
  double _subTotalInvoice = 0;
  double _totalAmountInvoice = 0;

  @override
  void initState() {
    super.initState();
    _calculateInvoices();
  }

  void _calculateInvoices() {
    _subTotalInvoice = widget.products.fold(
        0,
        (sum, product) =>
            sum + _calculateSubtotal(product.quantity, product.salePrice));
    _totalAmountInvoice = widget.products.fold(
        0,
        (sum, product) =>
            sum +
            _calculateTotal(
                _calculateSubtotal(product.quantity, product.salePrice),
                product.discount));
  }

  double _calculateTotal(double subtotal, double? discount) {
    if (discount != null) {
      return subtotal * (1 - discount / 100);
    } else {
      return subtotal;
    }
  }

  double _calculateSubtotal(int quantity, double salePrice) {
    return quantity * salePrice;
  }

  void _incrementQuantity(WProduct product, int amount) {
    setState(() {
      product.incrementQuantity();
      _calculateInvoices();
    });
  }

  void _decrementQuantity(WProduct product, int amount) {
    setState(() {
      product.decrementQuantity();
      _calculateInvoices();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final returnInvoice = Get.put(ReturnedPurchaseInvoiceViewmodel());
    return Scaffold(
      drawer: !isDesktop
          ? const SizedBox(width: 250, child: SideMenuWidgetWarehouse())
          : null,
      body: Row(
        children: [
          isDesktop
              ? const Expanded(flex: 2, child: SideMenuWidgetWarehouse())
              : Container(),
          Expanded(
            flex: 8,
            child: Obx(() {
              switch (returnInvoice.rxRequestStatus.value) {
                case Status.LOADING:
                  return const Center(child: CircularIndicator.waveSpinkit);
                case Status.ERROR:
                  return GeneralExceptionWidget(
                      errorMessage: returnInvoice.error.value.toString(),
                      onPress: () {
                        returnInvoice.refreshApi();
                      });
                case Status.COMPLETE:
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            const Text(
                              'Invoice Number :  ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(widget.invoiceNo),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: AppTextField(
                                controller:
                                    TextEditingController(text: widget.company),
                                labelText: "",
                                enabled: false,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: AppTextField(
                                controller:
                                    TextEditingController(text: widget.user),
                                labelText: "",
                                enabled: false,
                              ),
                            )
                          ],
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: DataTable(
                                  columnSpacing: 70,
                                  columns: const [
                                    DataColumn(label: Text('#')),
                                    DataColumn(label: Text('Product')),
                                    DataColumn(label: Text('Color')),
                                    DataColumn(label: Text('Size')),
                                    DataColumn(label: Text('Purchase Price')),
                                    DataColumn(label: Text('Quantity')),
                                    DataColumn(label: Text('Discount')),
                                    DataColumn(label: Text('Total Amount')),
                                    DataColumn(label: Text('Delete')),
                                  ],
                                  rows: List.generate(
                                    widget.products.length,
                                    (i) {
                                      final product = widget.products[i];
                                      final subTotal = _calculateSubtotal(
                                          product.quantity, product.salePrice);
                                      final totalAmount =
                                          product.discount != null
                                              ? _calculateTotal(
                                                  subTotal, product.discount)
                                              : subTotal;

                                      return DataRow(
                                        color: WidgetStateColor.resolveWith(
                                            (states) => i % 2 == 0
                                                ? Colors.grey[100]!
                                                : Colors.white),
                                        cells: [
                                          DataCell(Text((i + 1).toString())),
                                          DataCell(Text(product.name)),
                                          DataCell(Text(product.color)),
                                          DataCell(Text(product.size)),
                                          DataCell(Text(
                                              product.salePrice.toString())),
                                          DataCell(
                                            Row(
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    _decrementQuantity(
                                                        product, 1);
                                                  },
                                                  icon:
                                                      const Icon(Icons.remove),
                                                ),
                                                Text(product.quantity
                                                    .toString()),
                                                IconButton(
                                                  onPressed: () {
                                                    _incrementQuantity(
                                                        product, 1);
                                                    print(product.quantity);
                                                  },
                                                  icon: const Icon(Icons.add),
                                                ),
                                              ],
                                            ),
                                          ),
                                          DataCell(
                                            Text(product.discount != null
                                                ? '${product.discount.toString()}%'
                                                : 'Null'),
                                          ),
                                          DataCell(
                                            Text(
                                                totalAmount.toStringAsFixed(2)),
                                          ),
                                          DataCell(
                                            IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  widget.products.removeAt(i);
                                                  _calculateInvoices();
                                                });
                                              },
                                              icon: const Icon(Icons.delete),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      minimumSize: const Size(200, 40)),
                                  onPressed: () {
                                    Map<String, dynamic> returns = {
                                      "invoice_id": widget.uid,
                                      // "customer_id": widget.companyId,
                                      // "sale_men_id": widget.salesmanId,
                                      "sub_total":
                                          _subTotalInvoice.toStringAsFixed(2),
                                      "total_amount": _totalAmountInvoice
                                          .toStringAsFixed(2),
                                      "products": widget.products
                                          .map((product) => {
                                                "product_id": product.productId,
                                                "company_id": product.companyId,
                                                "brand_id": product.brandId,
                                                "type_id": product.typeId,
                                                "color_id": product.colorId,
                                                "size_id": product.sizeId,
                                                "quantity":
                                                    product.quantity.toString(),
                                                "sub_total": _calculateSubtotal(
                                                        product.quantity,
                                                        product.salePrice)
                                                    .toStringAsFixed(2),
                                                "discount":
                                                    product.discount != null
                                                        ? product.discount
                                                            .toString()
                                                        : "0",
                                                "total_amount": _calculateTotal(
                                                        _calculateSubtotal(
                                                            product.quantity,
                                                            product.salePrice),
                                                        product.discount)
                                                    .toStringAsFixed(2),
                                              })
                                          .toList(),
                                    };
                                    String jsonString = jsonEncode(returns);

                                    returnInvoice.addReturnInvoice(
                                        context, jsonString);
                                  },
                                  child: const Text("Return Purchase Invoice"),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      minimumSize: const Size(200, 40)),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Cancel"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
              }
            }),
          ),
        ],
      ),
    );
  }
}

// class WProduct {
//   final String brandId;
//   final String colorId;
//   final String typeId;
//   final String sizeId;
//   final String companyId;
//   final String productId;
//   final String productCode;
//   final String name;
//   final String color;
//   final String size;
//   int quantity; // Changed from final to mutable
//   int maxQuantity;
//   final double salePrice;
//   final double? discount;

//   WProduct(
//       {required this.brandId,
//       required this.colorId,
//       required this.typeId,
//       required this.sizeId,
//       required this.companyId,
//       required this.productId,
//       required this.productCode,
//       required this.name,
//       required this.color,
//       required this.size,
//       required this.quantity,
//       required this.salePrice,
//       this.discount,
//       required this.maxQuantity});

//   void incrementQuantity() {
//     if (quantity < maxQuantity) {
//       quantity++;
//     }
//   }

//   void decrementQuantity() {
//     if (quantity > 1) {
//       quantity--;
//     }
//   }
// }
