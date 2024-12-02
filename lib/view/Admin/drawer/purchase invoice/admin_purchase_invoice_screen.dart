import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:sofi_shoes/res/widget/app_drop_down.dart';

import '../../../../../res/responsive.dart';
import '../../../../../res/utils/utils.dart';
import '../../../../../res/widget/textfield/app_text_field.dart';
import '../../../../res/slidebar/side_menu_admin.dart';
import '../../../../viewmodel/warehouse/purchase invoice/purchase_invoice_viewmodel.dart';

class AdminPurchaseInvoiceScreen extends StatefulWidget {
  const AdminPurchaseInvoiceScreen({super.key});

  @override
  State<AdminPurchaseInvoiceScreen> createState() =>
      _AdminPurchaseInvoiceScreenState();
}

class _AdminPurchaseInvoiceScreenState
    extends State<AdminPurchaseInvoiceScreen> {
  final controller = Get.put(WPurchaseInvoiceViewModel());
  void onBarcodeScanned() {
    final barcode = controller.barCodeController.value.text;

    // Handle the scanned barcode
    print('Barcode scanned: $barcode');
    // Clear the text field for the next scan
    // Call a method with the scanned barcode
    controller.barcodeMethod(barcode);
  }

  void simulateBarcodeScan(String barcode) {
    controller.barCodeController.value.text = barcode;
    // Manually trigger the listener
    onBarcodeScanned();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Purchase Invoice"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(padding: EdgeInsets.all(10)),
              onPressed: () async {
                await controller.createNewInvoice();
              },
              label: const Text("New Invoice"),
              icon: const Icon(Icons.add),
            ),
          ),
        ],
      ),
      drawer: !isDesktop
          ? const SizedBox(
              width: 250,
              child: SideMenuWidgetAdmin(),
            )
          : null,
      body: Row(
        children: [
          isDesktop
              ? const Expanded(flex: 2, child: SideMenuWidgetAdmin())
              : Container(),
          Expanded(
            flex: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(
                  () => controller.loading.value == true
                      ? const Center(child: SizedBox())
                      : controller.invoices.isEmpty
                          ? const SizedBox.shrink()
                          : Expanded(
                              child: MyWidget(
                                controller: controller,
                              ),
                            ),
                ),
                Obx(
                  () => controller.invoices.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 50,
                            ),
                            const Center(
                              child: Icon(
                                Icons.production_quantity_limits_sharp,
                                color: Colors.black,
                                size: 80,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Please Create a Invoice",
                              style: GoogleFonts.lato(
                                fontWeight: FontWeight.w700,
                                fontSize: 24,
                              ),
                            ),
                          ],
                        )
                      : controller.loading.value
                          ? const SizedBox.shrink()
                          : NumberPaginator(
                              numberPages: controller.invoices.length,
                              config: NumberPaginatorUIConfig(
                                buttonSelectedBackgroundColor: Colors.green,
                                buttonUnselectedBackgroundColor: Colors.grey,
                                buttonSelectedForegroundColor: Colors.white,
                                buttonUnselectedForegroundColor: Colors.white,
                                buttonTextStyle: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                                buttonPadding: EdgeInsets.zero,
                                buttonShape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      5.0), // Adjust the radius for roundness
                                ),
                                height: 40,
                              ),
                              onPageChange: (int index) async {
                                print(index);
                                controller.currentPageIndex.value = index;
                                controller.recievedAmountController.value
                                    .clear();
                                controller.recievedAmount.value = 0.0;
                                controller.fetchedInvoice.value =
                                    (await controller.getInvoiceByNumber(
                                  controller.invoices[index].invoiceNumber
                                      .toString(),
                                ))!;
                                // print(
                                //     controller.fetchedInvoice.value.invoiceNumber);
                                controller.invoiceNumber.value = controller
                                    .fetchedInvoice.value.invoiceNumber
                                    .toString();
                                controller.invoiceIndex.value = index;
                                setState(() {});
                              },
                              showPrevButton: true,
                              showNextButton: true,
                              nextButtonBuilder: (context) => TextButton(
                                onPressed: controller.currentPageIndex.value <
                                        controller.invoices.length - 1
                                    ? () => controller
                                        .numberPaginatorController.value
                                        .next()
                                    : null,
                                child: const Row(
                                  children: [
                                    Text(
                                      "Next",
                                      style: TextStyle(
                                        color: Colors.blue,
                                      ),
                                    ),
                                    Icon(
                                      Icons.chevron_right,
                                      color: Colors.blue,
                                    ),
                                  ],
                                ),
                              ),
                              nextButtonContent:
                                  const Icon(Icons.chevron_right),
                              prevButtonBuilder: (context) => TextButton(
                                onPressed: controller.currentPageIndex.value > 0
                                    ? () => controller
                                        .numberPaginatorController.value
                                        .prev()
                                    : null,
                                child: const Row(
                                  children: [
                                    Icon(
                                      Icons.chevron_left,
                                      color: Colors.red,
                                    ),
                                    Text(
                                      "Previous",
                                      style: TextStyle(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              controller:
                                  controller.numberPaginatorController.value,
                            ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  final WPurchaseInvoiceViewModel controller;
  // final SaleInvoiceModel invoice;

  const MyWidget({
    super.key,
    required this.controller,
  });

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Obx(
      () => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Invoice Number :  ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Obx(() => Text(widget
                            .controller.fetchedInvoice.value.invoiceNumber
                            .toString())),
                      ],
                    ),
                    IconButton(
                      onPressed: () async {
                        setState(() {});
                        await widget.controller.deleteInvoice(
                            widget.controller.currentPageIndex.value);
                        widget.controller.loadInvoices();
                        widget.controller.getInvoiceByNumber(widget
                            .controller
                            .invoices[widget.controller.currentPageIndex.value]
                            .invoiceNumber
                            .toString());
                        widget.controller.currentPageIndex.value > 0
                            ? widget.controller.numberPaginatorController.value
                                .prev()
                            : null;
                        // .navigateToPage(
                        //     widget.controller.currentPageIndex.value - 1);
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() {
                      return Expanded(
                        child: AppDropDown(
                          labelText: "Select Company",
                          items: widget.controller.dropdownCompany
                              .map((branch) {
                                return branch["name"].toString();
                              })
                              .toSet()
                              .toList(),
                          selectedItem: widget.controller.getCompanyName(widget
                              .controller.fetchedInvoice.value.companyId
                              .toString()),
                          onChanged: (customerName) async {
                            var selectCustomer =
                                widget.controller.dropdownCompany.firstWhere(
                                    (branch) =>
                                        branch['name'].toString() ==
                                        customerName,
                                    orElse: () => null);
                            if (selectCustomer != null) {
                              widget.controller.selectCompanyDropdown.value =
                                  selectCustomer['id'].toString();
                              widget.controller.companyBalance.value =
                                  selectCustomer['opening_balance'];
                              widget.controller.getSubTotal();

                              widget.controller.fetchedInvoice.value.companyId =
                                  widget.controller.selectCompanyDropdown.value
                                      .toString();
                            }
                          },
                        ),
                      );
                    }),
                    const SizedBox(
                      width: 20,
                    ),
                    Obx(
                          () => Expanded(
                        child: AppTextField(
                          controller: widget.controller.barCodeController.value,
                          labelText: "Bar Code",
                          enabled: true,
                          onChanged: (value){
                            if(value.isEmpty){
                              widget.controller.barCodeController.value.clear();
                              setState(() {

                              });
                            }
                          },
                          onFieldSubmitted: (barcode) {
                            widget.controller.barcodeMethod(barcode);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Obx(() => Expanded(
                          child: AppDropDown(
                            enabled: widget.controller.barCodeController.value
                                .text.isEmpty,
                            labelText: "Product",
                            items: widget.controller.dropdownProduct
                                .map((branch) => branch["name"].toString())
                                .toSet()
                                .toList(),
                            selectedItem:
                                widget.controller.productN.value.isEmpty
                                    ? null
                                    : widget.controller.productN.value,
                            onChanged: (productName) async {
                              widget.controller.productN.value =
                                  productName.toString();
                              var selectProduct =
                                  widget.controller.dropdownProduct.firstWhere(
                                      (branch) =>
                                          branch['name'].toString() ==
                                          productName,
                                      orElse: () => null);
                              if (selectProduct != null) {
                                widget.controller.purchaseController.value
                                        .text =
                                    selectProduct['purchase_price'].toString();

                                // bar code assign

                                widget.controller.selectProduct.value =
                                    selectProduct['id'].toString();
                              }
                              widget.controller.getColor();
                            },
                          ),
                        )),
                    const SizedBox(width: 20),
                    Obx(
                      () => Expanded(
                        child: AppDropDown(
                          enabled: widget
                              .controller.barCodeController.value.text.isEmpty,
                          labelText: "Color",
                          items: widget.controller.dropdownItemsColor
                              .map((branch) => branch["name"].toString())
                              .toSet()
                              .toList(),
                          selectedItem: widget.controller.colorN.value.isEmpty
                              ? null
                              : widget.controller.colorN.value,
                          onChanged: (colorName) async {
                            widget.controller.colorN.value =
                                colorName.toString();
                            var selectColor =
                                widget.controller.dropdownItemsColor.firstWhere(
                                    (branch) =>
                                        branch['name'].toString() == colorName,
                                    orElse: () => null);
                            if (selectColor != null) {
                              widget.controller.selectColor.value =
                                  selectColor['id'].toString();

                              widget.controller.getSize();
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                      () => Expanded(
                        child: AppDropDown(
                          enabled: widget
                              .controller.barCodeController.value.text.isEmpty,
                          labelText: "Size",
                          items: widget.controller.dropdownItemsSize
                              .map((branch) => branch["number"].toString())
                              .toSet()
                              .toList(),
                          selectedItem: widget.controller.sizeN.value.isEmpty
                              ? null
                              : widget.controller.sizeN.value,
                          onChanged: (sizeName) async {
                            widget.controller.sizeN.value = sizeName.toString();
                            var selectSize = widget.controller.dropdownItemsSize
                                .firstWhere(
                                    (branch) =>
                                        branch['number'].toString() == sizeName,
                                    orElse: () => null);
                            if (selectSize != null) {
                              widget.controller.selectSize.value =
                                  selectSize['id'].toString();
                            }

                            widget.controller.getCompanyBrandTypeId();
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Obx(
                      () => Expanded(
                        child: SizedBox(
                          height: 55,
                          child: AppTextField(
                            controller:
                                widget.controller.purchaseController.value,
                            labelText: "P.Price",
                            enabled: false,
                            onChanged: (value) {
                              widget.controller.purchaseController.value.text =
                                  value;
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Obx(
                      () => Expanded(
                        child: SizedBox(
                          height: 55,
                          child: AppTextField(
                            controller:
                                widget.controller.quantityController.value,
                            onlyNumerical: true,
                            labelText: "Quantity",
                            onChanged: (value) {
                              widget.controller.quantity.value = value;
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: DottedBorder(
                          color: Colors.green,
                          strokeWidth: 1,
                          dashPattern: [6, 3],
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(5.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {});
                              if (widget.controller.fetchedInvoice.value
                                  .invoiceNumber!.isNotEmpty) {
                                widget.controller.addOrUpdateInvoice();
                              } else {
                                Utils.ErrorToastMessage(
                                    'Please select all field');
                              }
                            },
                            child: Container(
                              width: double.infinity,
                              height: size.height * 0.05,
                              color: Colors.green,
                              child: const Center(
                                child: Text(
                                  "Add Product",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Obx(
            () => widget.controller.fetchedInvoice.value.products?.isEmpty ??
                    true
                ? Center(
                    child: Text(
                      "Products is Empty",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: DataTable(
                            columnSpacing: 97,
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
                              widget.controller.fetchedInvoice.value.products!
                                  .length,
                              (i) {
                                final product = widget.controller.fetchedInvoice
                                    .value.products![i];
                                return DataRow(
                                  color: WidgetStateColor.resolveWith(
                                    (states) => i % 2 == 0
                                        ? Colors.grey[100]!
                                        : Colors.white,
                                  ),
                                  cells: [
                                    DataCell(Text((i + 1).toString())),
                                    DataCell(
                                        Text(product.productName ?? 'Unknown')),
                                    DataCell(
                                        Text(product.colorName ?? 'Unknown')),
                                    DataCell(
                                        Text(product.sizeNumber ?? 'Unknown')),
                                    DataCell(Text(product.quantity.toString())),
                                    DataCell(Text(product.subTotal.toString())),
                                    DataCell(
                                        Text(product.totalAmount.toString())),
                                    DataCell(
                                      IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () async {
                                          await widget.controller
                                              .deleteProductFromInvoice(
                                            widget.controller.fetchedInvoice
                                                .value.invoiceNumber
                                                .toString(),
                                            product.productId.toString(),
                                            product.colorId.toString(),
                                            product.sizeId.toString(),
                                          );
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
          widget.controller.fetchedInvoice.value.products?.isEmpty ?? true
              ? const SizedBox.shrink()
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: SizedBox(
                    width: double.infinity,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(150, 30)),
                              onPressed: () {
                                widget.controller.getSubTotal();

                                widget.controller.balance.value =
                                    widget.controller.companyTotalBalance.value;
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text("Summary"),
                                      content: Obx(
                                        () => Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            AppTextField(
                                              labelText: "Sub Total",
                                              onlyNumerical: true,
                                              controller: TextEditingController(
                                                  text: widget
                                                      .controller
                                                      .fetchedInvoice
                                                      .value
                                                      .subTotal),
                                              enabled: false,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            AppTextField(
                                              labelText: "Discount Amount",
                                              onlyNumerical: true,
                                              controller: TextEditingController(
                                                  text: widget
                                                      .controller
                                                      .fetchedInvoice
                                                      .value
                                                      .totalAmount),
                                              enabled: false,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            AppTextField(
                                              labelText: "Previous Balance",
                                              controller: TextEditingController(
                                                  text: widget.controller
                                                      .companyBalance.value
                                                      .toString()),
                                              enabled: false,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            AppTextField(
                                              labelText: "Total Balance",
                                              onlyNumerical: true,
                                              controller: TextEditingController(
                                                  text: widget.controller
                                                      .companyTotalBalance.value
                                                      .toString()),
                                              enabled: false,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            AppTextField(
                                              labelText: "Balance",
                                              onlyNumerical: true,
                                              colors: widget.controller.balance
                                                          .value <
                                                      0
                                                  ? Colors.red
                                                  : Colors.black,
                                              controller: TextEditingController(
                                                  text: widget
                                                      .controller.balance
                                                      .toString()),
                                              enabled: false,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            AppTextField(
                                              labelText: "Received Amount",
                                              onlyNumerical: true,
                                              controller: widget
                                                  .controller
                                                  .recievedAmountController
                                                  .value,
                                              enabled: true,
                                              onChanged: (value) {
                                                widget.controller
                                                    .setRecievedAmount(value);
                                                widget.controller.fetchedInvoice
                                                        .value.receivedAmount =
                                                    widget.controller
                                                        .recievedAmount.value
                                                        .toString();
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("Cancel"),
                                            ),
                                            ElevatedButton(
                                              onPressed: () async {
                                                if (widget
                                                        .controller
                                                        .selectCompanyDropdown
                                                        .value
                                                        .isNotEmpty &&
                                                    widget
                                                        .controller
                                                        .fetchedInvoice
                                                        .value
                                                        .invoiceNumber!
                                                        .isNotEmpty &&
                                                    widget
                                                        .controller
                                                        .fetchedInvoice
                                                        .value
                                                        .receivedAmount!
                                                        .isNotEmpty) {
                                                  await widget.controller
                                                      .addPurchaseInvoice()
                                                      .then((value) {
                                                    // widget
                                                    //         .controller
                                                    //         .fetchedInvoice
                                                    //         .value =
                                                    //     '' as SaleInvoiceModel;
                                                    // widget.controller
                                                    //     .loadInvoices();
                                                    if (widget
                                                            .controller
                                                            .invoices
                                                            .isNotEmpty &&
                                                        widget
                                                                .controller
                                                                .currentPageIndex
                                                                .value >
                                                            0) {
                                                      widget.controller
                                                          .getInvoiceByNumber(widget
                                                              .controller
                                                              .invoices[widget
                                                                  .controller
                                                                  .currentPageIndex
                                                                  .value]
                                                              .invoiceNumber
                                                              .toString());

                                                      widget
                                                          .controller
                                                          .currentPageIndex
                                                          .value--;
                                                      widget
                                                          .controller
                                                          .numberPaginatorController
                                                          .value
                                                          .navigateToPage(widget
                                                              .controller
                                                              .currentPageIndex
                                                              .value);

                                                      // Navigator.pop(context);
                                                    } else if (widget
                                                            .controller
                                                            .invoices
                                                            .isNotEmpty &&
                                                        widget
                                                                .controller
                                                                .currentPageIndex
                                                                .value ==
                                                            0) {
                                                      widget.controller
                                                          .getInvoiceByNumber(widget
                                                              .controller
                                                              .invoices[widget
                                                                  .controller
                                                                  .currentPageIndex
                                                                  .value]
                                                              .invoiceNumber
                                                              .toString());
                                                      widget
                                                          .controller
                                                          .numberPaginatorController
                                                          .value
                                                          .next();
                                                    }
                                                  });

                                                  Navigator.pop(context);
                                                } else {
                                                  Navigator.pop(context);
                                                  Utils.ErrorToastMessage(
                                                      'Please select Company');
                                                }
                                              },
                                              child: const Text("Add Purchase"),
                                            )
                                          ],
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: const Text("Purchase Product"),
                            ),
                            Text(
                              'Total: ${widget.controller.fetchedInvoice.value.totalAmount}',
                              style: GoogleFonts.lato(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
