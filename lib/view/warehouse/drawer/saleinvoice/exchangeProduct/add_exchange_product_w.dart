import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../res/responsive.dart';
import '../../../../../res/slidebar/side_menu_warehouse.dart';
import '../../../../../res/utils/utils.dart';
import '../../../../../res/widget/app_drop_down.dart';
import '../../../../../res/widget/textfield/app_text_field.dart';
import '../../../../../viewmodel/branch/saleinvoice/exchange_product_viewmodel.dart';
import '../../../../Branch/drawer/saleinvoice/export/sale_invoice_export.dart';
import '../../../../Branch/drawer/saleinvoice/sale_exchange_product_model.dart';

class AddExchangeProductScreenWarehouse extends StatefulWidget {
  const AddExchangeProductScreenWarehouse({
    required this.products,
    required this.customerId,
    required this.salesmanId,
    required this.customerName,
    required this.salesmanName,
    required this.invoiceNo,
    required this.uid,
    required this.productLimit,
    required this.subTotal,
    required this.totalAmount,
    required this.receivedAmount,
    required this.returnAmount,
    super.key,
  });

  final String uid;
  final String invoiceNo;
  final String customerId;
  final String salesmanId;
  final String customerName;
  final String salesmanName;
  final int productLimit;
  final String subTotal;
  final String totalAmount;
  final String receivedAmount;
  final String returnAmount;

  final List<ExchangProductItemModel> products;

  @override
  // ignore: library_private_types_in_public_api
  _AddExchangeProductScreenWarehouseState createState() =>
      _AddExchangeProductScreenWarehouseState();
}

class _AddExchangeProductScreenWarehouseState
    extends State<AddExchangeProductScreenWarehouse> {
  final controller = Get.put(ExchangeProductViewmodel());

  @override
  void initState() {
    super.initState();

    // Initialize with existing products
    controller.exchangeProducts.value = widget.products;
    controller.totalAmountlist.value = double.parse(widget.totalAmount);
    controller.subTotallist.value = double.parse(widget.subTotal);
    controller.barCodeController.value.addListener(onBarcodeScanned);
  }

  void onBarcodeScanned() {
    final barcode = controller.barCodeController.value.text;

    // Check if input is from the scanner gun (ends with Enter or newline)
    if (barcode.isNotEmpty && barcode.endsWith('\n')) {
      // Clean up the barcode (trim newline or extra spaces)
      final cleanedBarcode = barcode.trim();

      // Trigger the method with the scanned barcode
      controller.barcodeMethod(cleanedBarcode);

      // Clear the text field for the next scan
      controller.barCodeController.value.clear();
    }
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isDesktop = Responsive.isDesktop(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Exchange Product"),
      ),
      drawer: !isDesktop
          ? const SizedBox(
        width: 250,
        child: SideMenuWidgetWarehouse(),
      )
          : null,
      body: Row(
        children: [
          isDesktop ? const Expanded(flex: 2, child: SideMenuWidgetWarehouse()) : Container(),
          Expanded(
            flex: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Invoice Number :  ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(widget.invoiceNo),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    children: [
                      Obx(() {
                        return Expanded(
                          child: AppDropDown(
                            labelText: "Select Customer",
                            selectedItem: widget.customerName,
                            enabled: false,
                            items: controller.dropdownCustomer.map((branch) {
                              return branch["name"].toString();
                            }).toList(),
                            onChanged: (customerName) async {
                              var selectCustomer = controller.dropdownCustomer
                                  .firstWhere(
                                      (branch) =>
                                          branch['name'].toString() == customerName,
                                      orElse: () => null);
                              if (selectCustomer != null) {
                                controller.selectedCustomer.value =
                                    selectCustomer['id'].toString();
                              }
                            },
                          ),
                        );
                      }),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(
                        () => Expanded(
                          child: AppTextField(
                            controller: controller.barCodeController.value,
                            labelText: "Bar Code",
                            enabled: true,
                            onFieldSubmitted: (barcode) {
                              controller.barcodeMethod(barcode);
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Obx(() => Expanded(
                            child: AppDropDown(
                              enabled:
                                  controller.barCodeController.value.text.isEmpty,
                              labelText: "Product",
                              items: controller.dropdownProduct
                                  .map((branch) => branch["name"].toString())
                                  .toSet()
                                  .toList(),
                              selectedItem: controller.productN.value.isEmpty
                                  ? null
                                  : controller.productN.value,
                              onChanged: (productName) async {
                                controller.productN.value = productName.toString();
                                print(productName);
                                var selectProduct = controller.dropdownProduct
                                    .firstWhere(
                                        (branch) =>
                                            branch['name'].toString() == productName,
                                        orElse: () => null);
                                if (selectProduct != null) {
                                  controller.saleController.value.text =
                                      selectProduct['sale_price'].toString();

                                  // bar code assign
                                  controller.selectProduct.value =
                                      selectProduct['id'].toString();
                                }
                                controller.getColor();
                              },
                            ),
                          )),
                      const SizedBox(width: 20),
                      Obx(
                        () => Expanded(
                          child: AppDropDown(
                            enabled: controller.barCodeController.value.text.isEmpty,
                            labelText: "Color",
                            items: controller.dropdownItemsColor
                                .map((branch) => branch["name"].toString())
                                // .toSet()
                                .toList(),
                            selectedItem: controller.colorN.value.isEmpty
                                ? null
                                : controller.colorN.value,
                            onChanged: (colorName) async {
                              controller.colorN.value = colorName.toString();
                              var selectColor = controller.dropdownItemsColor
                                  .firstWhere(
                                      (branch) =>
                                          branch['name'].toString() == colorName,
                                      orElse: () => null);
                              if (selectColor != null) {
                                controller.selectColor.value =
                                    selectColor['id'].toString();

                                controller.getSize();
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Obx(
                        () => Expanded(
                          child: AppDropDown(
                            enabled: controller.barCodeController.value.text.isEmpty,
                            labelText: "Size",
                            items: controller.dropdownItemsSize
                                .map((branch) => branch["number"].toString())
                                .toSet()
                                .toList(),
                            selectedItem: controller.sizeN.value.isEmpty
                                ? null
                                : controller.sizeN.value,
                            onChanged: (sizeName) async {
                              controller.sizeN.value = sizeName.toString();
                              var selectSize = controller.dropdownItemsSize
                                  .firstWhere(
                                      (branch) =>
                                          branch['number'].toString() == sizeName,
                                      orElse: () => null);
                              if (selectSize != null) {
                                controller.selectSize.value =
                                    selectSize['id'].toString();
                              }

                              controller.getCompanyBrandTypeId();
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(
                        () => Expanded(
                          child: AppTextField(
                            controller: controller.saleController.value,
                            labelText: "S.Price",
                            enabled: false,
                            onChanged: (value) {
                              controller.saleController.value.text = value;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Obx(
                        () => Expanded(
                          child: AppTextField(
                            controller: controller.totalQuantityController.value,
                            labelText: "T.Quantity",
                            enabled: false,
                            onChanged: (value) {
                              controller.totalQuantityController.value.text = value;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Obx(
                        () => Expanded(
                          child: AppTextField(
                            controller: controller.quantityController.value,
                            labelText: "Quantity",
                            onChanged: (value) {
                              controller.quantity.value = value;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Obx(
                        () => Expanded(
                          child: AppTextField(
                            controller: controller.discountController.value,
                            labelText: "Discount",
                            enabled: true,
                            onChanged: (value) {
                              controller.discountController.value.text = value;
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: DottedBorder(
                    color: Colors.grey,
                    strokeWidth: 1,
                    dashPattern: const [6, 3],
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(5.0),
                    child: GestureDetector(
                      onTap: () async {
                        if (controller.exchangeProducts.length <
                            widget.productLimit) {
                          if (controller.selectProduct.value.isNotEmpty &&
                              controller.selectColor.value.isNotEmpty &&
                              controller.selectSize.value.isNotEmpty) {
                            controller.getSubTotal();
                            controller.addOrUpdateProduct(
                              ExchangProductItemModel(
                                name: controller.productN.toString(),
                                color: controller.colorN.toString(),
                                size: controller.sizeN.toString(),
                                quantity: int.parse(controller.quantity.value),
                                salePrice: double.parse(
                                    controller.saleController.value.text),
                                discount: double.parse(
                                    controller.discountController.value.text),
                                subTotal: controller.subTotal.value.toString(),
                                totalAmount: controller.totalAmount.value.toString(),
                                brandId: controller.selectBrand.toString(),
                                colorId: controller.selectColor.toString(),
                                typeId: controller.selectType.toString(),
                                sizeId: controller.selectSize.toString(),
                                companyId: controller.selectCompany.toString(),
                                productId: controller.selectProduct.toString(),
                                previousProductId: null,

                                // Set other required fields...
                              ),
                            );
                            String jsonData =
                                jsonEncode(controller.exchangeProducts.toJson());
                            print(jsonData);
                            controller.clearFields();
                            // setState(() {});
                          } else {
                            Utils.ErrorToastMessage('please select all field');
                          }
                        } else {
                          Utils.ErrorToastMessage(
                              'Product limit reached. Cannot add more products.');
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        height: size.height * 0.05,
                        color: Colors.white,
                        child: const Center(
                          child: Text(
                            "Add Product",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: DataTable(
                            columnSpacing: 95,
                            columns: const [
                              DataColumn(label: Text('#')),
                              DataColumn(label: Text('Product')),
                              DataColumn(label: Text('Color')),
                              DataColumn(label: Text('Size')),
                              DataColumn(label: Text('Quantity')),
                              DataColumn(label: Text('Sub Total')),
                              DataColumn(label: Text('Total Amount')),
                              DataColumn(label: Text('Delete')),
                            ],
                            rows: List.generate(
                              controller.exchangeProducts.length,
                              (i) {
                                final product = controller.exchangeProducts[i];
                                return DataRow(
                                  color: WidgetStateColor.resolveWith(
                                    (states) =>
                                        i % 2 == 0 ? Colors.grey[100]! : Colors.white,
                                  ),
                                  cells: [
                                    DataCell(Text((i + 1).toString())),
                                    DataCell(Text(product.name)),
                                    DataCell(Text(product.color)),
                                    DataCell(Text(product.size)),
                                    DataCell(Text(product.quantity.toString())),
                                    DataCell(Text(product.subTotal.toString())),
                                    DataCell(Text(product.totalAmount.toString())),
                                    DataCell(
                                      IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () {
                                          // Capture the previousProductId before deletion
                                          final previousProductId =
                                              product.previousProductId;
                                          print(previousProductId);
                                          controller.deleteProduct(i);
                                          print('xxxxxxxxxxxxxxxxxxx');

                                          print(product.previousProductId);
                                        },
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
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(minimumSize: const Size(150, 30)),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context){
                              return AlertDialog(
                                title: Text("Add Amount"),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    AppTextField(
                                      controller: TextEditingController(text: controller.totalAmountlist.value.toString()),
                                      labelText: "New Total Amount",
                                      enabled: false,
                                    ),
                                    SizedBox(height: 5,),
                                    AppTextField(
                                      controller: TextEditingController(text: widget.receivedAmount),
                                      labelText: "Old Received Amount",
                                      enabled: false,
                                    ),
                                    SizedBox(height: 5,),
                                    AppTextField(
                                      controller: TextEditingController(text: (int.parse(controller.totalAmountlist.value.toString()) - int.parse(widget.receivedAmount)).toString()),
                                      labelText: "Pay Received Amount",
                                      enabled: false,
                                    ),
                                    SizedBox(height: 5,),
                                    AppTextField(
                                      controller: controller.receivedAmount.value,
                                      labelText: "Received New Amount",
                                    ),
                                    SizedBox(height: 5,),
                                    AppTextField(
                                      controller: controller.returnAmount.value,
                                      labelText: "Return Amount",
                                    ),
                                    SizedBox(height: 20,),
                                   Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                     children: [
                                       ElevatedButton(
                                         onPressed: (){
                                           Navigator.pop(context);
                                         },
                                         child: Text("Cancel"),
                                       ),
                                       ElevatedButton(
                                         onPressed: (){
                                           Map<String, dynamic> returns = {
                                             "new_customer_id": controller.selectedCustomer.value.isEmpty ? widget.customerId : controller.selectedCustomer.value,
                                             "new_sale_men_id": controller.warehouseId.value,
                                             "new_sub_total": controller.subTotallist.value,
                                             "new_total_amount": controller.totalAmountlist.value,
                                             "received_amount": controller.receivedAmount.value.text,
                                             "return_amount": controller.returnAmount.value.text,
                                             "products": controller.exchangeProducts.map((product) => {
                                               "invoice_product_id": product.previousProductId,
                                               "new_product_id": product.productId,
                                               "new_company_id": product.companyId,
                                               "new_brand_id": product.brandId,
                                               "new_type_id": product.typeId,
                                               "new_color_id": product.colorId,
                                               "new_size_id": product.sizeId,
                                               "new_quantity": product.quantity.toString(),
                                               "new_sub_total": product.subTotal,
                                               "new_discount": product.discount.toString(),
                                               "new_total_amount": product.totalAmount.toString(),
                                             }).toList(),
                                           };
                                           String jsonString = jsonEncode(returns);
                                           controller.addExchangeProduct(jsonString, widget.uid.toString());
                                           print(jsonString);
                                           Get.back();
                                         },
                                         child: Text("Add"),
                                       )
                                     ],
                                   ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: const Text('Exchange Product'),
                      ),
                      Obx(() => Text(
                        'Total: ${controller.totalAmountlist.value}',
                        style: GoogleFonts.lato(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
