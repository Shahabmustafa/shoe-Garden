import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../date/response/status.dart';
import '../../../../res/circularindictor/circularindicator.dart';
import '../../../../res/responsive.dart';
import '../../../../res/slidebar/side_menu_manager.dart';
import '../../../../res/tabletext/table_text.dart';
import '../../../../res/widget/general_execption_widget.dart';
import '../../../../res/widget/textfield/app_text_field.dart';
import '../../../../viewmodel/warehouse/purchase invoice/purchase_invoice_viewmodel.dart';
import '../../../../viewmodel/warehouse/purchase invoice/returned_purchase_invoice_viewmodel.dart';
import '../../../Branch/drawer/saleinvoice/export/sale_invoice_export.dart';
import '../../../warehouse/drawer/saleinvoice/saleReturn/w_add_sale_return.dart';
import '../dashboard/dashboard_screen_a.dart';
import 'm_add_return_purchase_invoice.dart';

class MReturnPuchaseInvoiceScreen extends StatefulWidget {
  const MReturnPuchaseInvoiceScreen({super.key});

  @override
  State<MReturnPuchaseInvoiceScreen> createState() =>
      _MReturnPuchaseInvoiceScreenState();
}

class _MReturnPuchaseInvoiceScreenState
    extends State<MReturnPuchaseInvoiceScreen> {
  double totalAmount = 0.0;
  double totalDiscount = 0.0;

  double calculateSubtotal(String quantityStr, String salePriceStr) {
    try {
      var quantity = int.parse(quantityStr);
      var salePrice = double.parse(salePriceStr);
      return quantity * salePrice;
    } catch (e) {
      print('Error calculating subtotal: $e');
      return 0.0; // Return default value or handle error case appropriately
    }
  }

// Function to calculate total amount including discount
  double calculateTotal(double subtotal, double? discount) {
    if (discount != null) {
      return subtotal * (1 - discount / 100);
    } else {
      return subtotal;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final controller = Get.put(WPurchaseInvoiceViewModel());
    final controllerR = Get.put(ReturnedPurchaseInvoiceViewmodel());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Return Purchase Invoice"),
      ),
      drawer: !isDesktop
          ? const SizedBox(
              width: 250,
              child: SideMenuWidgetManager(),
            )
          : null,
      body: Row(
        children: [
          isDesktop
              ? const Expanded(flex: 2, child: SideMenuWidgetManager())
              : Container(),
          Expanded(
            flex: 8,
            child: Obx(() {
              switch (controller.rxRequestStatus.value) {
                case Status.LOADING:
                  return const Center(child: CircularIndicator.waveSpinkit);
                case Status.ERROR:
                  return GeneralExceptionWidget(
                      errorMessage: controller.error.value.toString(),
                      onPress: () {
                        controller.refreshApi();
                      });
                case Status.COMPLETE:
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            children: [
                              Flexible(
                                child: AppTextField(
                                  controller: controller.search.value,
                                  labelText: "Search c.name or invoiceNo.",
                                  search: true,
                                  prefixIcon: const Icon(Icons.search),
                                  onChanged: (value) {
                                    setState(() {
                                      controller.searchValue.value = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Table(
                            columnWidths: const {
                              0: FlexColumnWidth(1),
                              1: FlexColumnWidth(2),
                              2: FlexColumnWidth(2),
                              3: FlexColumnWidth(2),
                              4: FlexColumnWidth(2),
                              5: FlexColumnWidth(1),
                              6: FlexColumnWidth(1),
                              7: FlexColumnWidth(1),
                            },
                            border: TableBorder.all(
                              color: Colors.grey.shade300,
                            ),
                            defaultColumnWidth: const FlexColumnWidth(0.5),
                            children: const [
                              TableRow(
                                decoration: BoxDecoration(
                                  color: Color(0xff13132a),
                                ),
                                children: [
                                  CustomTableCell(
                                    text: "#",
                                    textColor: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  CustomTableCell(
                                    text: 'Invoice No',
                                    textColor: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  CustomTableCell(
                                    text: 'Company',
                                    textColor: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  CustomTableCell(
                                    text: 'User',
                                    textColor: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  CustomTableCell(
                                    text: 'Date',
                                    textColor: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  CustomTableCell(
                                    text: 'View',
                                    textColor: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  CustomTableCell(
                                    text: 'Edit',
                                    textColor: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  CustomTableCell(
                                    text: 'Print',
                                    textColor: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: controller.purchaseInvoiceList.value
                                .body!.purchaseInvoices!.length,
                            itemBuilder: (context, index) {
                              final invoice = controller.purchaseInvoiceList
                                  .value.body!.purchaseInvoices![index];
                              String dateTimeString =
                                  invoice.createdAt.toString();
                              DateTime dateTime =
                                  DateTime.tryParse(dateTimeString) ??
                                      DateTime.now();
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(dateTime);
                              final invoiceData = InvoiceExport(
                                paymentMethod: "",
                                id: invoice.invoiceNumber?.toString() ?? "null",
                                date: DateTime
                                    .now(), // It seems you want to use the current date instead of `invoice.createdAt`
                                saleman: Salesman(
                                    name: invoice.user?.name ?? "null"),
                                customer: Customer(
                                    name: invoice.company != null
                                        ? invoice.company!.name
                                        : ""),
                                total: invoice.totalAmount?.toString() ?? "0",
                                items: invoice.invoiceProducts?.map((product) {
                                      return InvoiceItem(
                                        product: product.product != null
                                            ? product.product!.name.toString()
                                            : "null",
                                        salePrice:
                                            product.salePrice?.toString() ??
                                                "0",
                                        qty: int.tryParse(
                                                product.quantity?.toString() ??
                                                    '0') ??
                                            0,
                                        dis: product.discount != null
                                            ? "${product.discount}%"
                                            : "Null",
                                        subTotal:
                                            product.subTotal?.toString() ?? "0",
                                        totalAmount:
                                            product.totalAmount?.toString() ??
                                                '0',
                                      );
                                    }).toList() ??
                                    [],
                              );
                              if (controller.search.value.text.isEmpty ||
                                  invoice.invoiceNumber!
                                      .toString()
                                      .toLowerCase()
                                      .contains(controller.search.value.text
                                          .trim()
                                          .toLowerCase()) ||
                                  invoiceData.customer!.name
                                      .toString()
                                      .toLowerCase()
                                      .contains(controller.search.value.text
                                          .trim()
                                          .toLowerCase())) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: Table(
                                        columnWidths: const {
                                          0: FlexColumnWidth(1),
                                          1: FlexColumnWidth(2),
                                          2: FlexColumnWidth(2),
                                          3: FlexColumnWidth(2),
                                          4: FlexColumnWidth(2),
                                          5: FlexColumnWidth(1),
                                          6: FlexColumnWidth(1),
                                          7: FlexColumnWidth(1),
                                        },
                                        border: TableBorder.all(
                                          color: Colors.grey.shade300,
                                        ),
                                        defaultColumnWidth:
                                            const FlexColumnWidth(0.5),
                                        children: [
                                          TableRow(
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                            ),
                                            children: [
                                              CustomTableCell(
                                                text: "${index + 1}",
                                                textColor: Colors.black,
                                              ),
                                              CustomTableCell(
                                                text: invoice.invoiceNumber !=
                                                        null
                                                    ? invoice.invoiceNumber
                                                        .toString()
                                                    : "Null",
                                                textColor: Colors.black,
                                              ),
                                              CustomTableCell(
                                                text: invoice.company != null
                                                    ? invoice.company!.name
                                                        .toString()
                                                    : "Null",
                                                textColor: Colors.black,
                                              ),
                                              CustomTableCell(
                                                text: invoice.user != null
                                                    ? invoice.user!.name
                                                        .toString()
                                                    : "Null",
                                                textColor: Colors.black,
                                              ),
                                              CustomTableCell(
                                                text: formattedDate ?? "Null",
                                                textColor: Colors.black,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  controllerR
                                                      .getSpecificReturnedInvoice(
                                                          int.parse(invoice.id
                                                              .toString()));
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        title: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  "Purchase Invoice",
                                                                  style:
                                                                      GoogleFonts
                                                                          .lato(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    fontSize:
                                                                        16,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 20,
                                                                ),
                                                                Text(
                                                                  "Invoice: ${invoice.invoiceNumber != null ? invoice.invoiceNumber.toString() : "Null"}",
                                                                  style:
                                                                      GoogleFonts
                                                                          .lato(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        14,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  "Date: $formattedDate",
                                                                  style:
                                                                      GoogleFonts
                                                                          .lato(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        14,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                SizedBox(
                                                                  height: 20,
                                                                ),
                                                                Text(
                                                                  "User: ${invoice.user != null ? invoice.user!.name.toString() : "Null"}",
                                                                  style:
                                                                      GoogleFonts
                                                                          .lato(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        14,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  invoice.company !=
                                                                          null
                                                                      ? "Company: ${invoice.company!.name.toString()}"
                                                                      : "Null",
                                                                  style:
                                                                      GoogleFonts
                                                                          .lato(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        14,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        content: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: [
                                                            SingleChildScrollView(
                                                              scrollDirection:
                                                                  Axis.horizontal,
                                                              child: DataTable(
                                                                columns: const [
                                                                  DataColumn(
                                                                      label: Text(
                                                                          'Product')),
                                                                  DataColumn(
                                                                      label: Text(
                                                                          'Color')),
                                                                  DataColumn(
                                                                      label: Text(
                                                                          'Size')),
                                                                  DataColumn(
                                                                      label: Text(
                                                                          'Quantity'),
                                                                      numeric:
                                                                          true),
                                                                  DataColumn(
                                                                      label: Text(
                                                                          'Purchase Price'),
                                                                      numeric:
                                                                          true),
                                                                  DataColumn(
                                                                    label: Text(
                                                                      'Sale Price',
                                                                    ),
                                                                    numeric:
                                                                        true,
                                                                  ),
                                                                  DataColumn(
                                                                    label: Text(
                                                                        'Sub Total'),
                                                                    numeric:
                                                                        true,
                                                                  ),
                                                                  DataColumn(
                                                                    label: Text(
                                                                      'Discount',
                                                                    ),
                                                                    numeric:
                                                                        true,
                                                                  ),
                                                                  DataColumn(
                                                                    label: Text(
                                                                        'Total Amount'),
                                                                    numeric:
                                                                        true,
                                                                  ),
                                                                ],
                                                                rows: invoice
                                                                            .invoiceProducts !=
                                                                        null
                                                                    ? invoice
                                                                        .invoiceProducts!
                                                                        .map(
                                                                            (product) {
                                                                        return DataRow(
                                                                          cells: [
                                                                            DataCell(Text(product.product != null
                                                                                ? product.product!.name.toString()
                                                                                : "Null")),
                                                                            DataCell(Text(product.color != null
                                                                                ? product.color!.name.toString()
                                                                                : "Null")),
                                                                            DataCell(Text(product.size != null
                                                                                ? product.size!.number.toString()
                                                                                : "Null")),
                                                                            DataCell(Text(product.quantity != null
                                                                                ? product.quantity.toString()
                                                                                : "Null")),
                                                                            DataCell(Text(product.product != null && product.product!.purchasePrice != null
                                                                                ? product.product!.purchasePrice.toString()
                                                                                : "Null")),
                                                                            DataCell(Text(product.product != null && product.product!.salePrice != null
                                                                                ? product.product!.salePrice.toString()
                                                                                : "Null")),
                                                                            DataCell(Text(product.subTotal != null
                                                                                ? product.subTotal.toString()
                                                                                : 'Null')),
                                                                            DataCell(Text(product.discount != null
                                                                                ? "${product.discount}%"
                                                                                : "Null")),
                                                                            DataCell(Text(product.totalAmount != null
                                                                                ? product.totalAmount.toString()
                                                                                : "Null")),
                                                                          ],
                                                                        );
                                                                      }).toList()
                                                                    : [],
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                height: 30),
                                                            const Divider(
                                                              color:
                                                                  Colors.grey,
                                                              thickness: 1,
                                                            ),
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Text(
                                                                  "Sub Total",
                                                                  style:
                                                                      GoogleFonts
                                                                          .lato(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    width: 30),
                                                                Text(
                                                                  invoice.subTotal !=
                                                                          null
                                                                      ? invoice
                                                                          .subTotal
                                                                          .toString()
                                                                      : "Null",
                                                                  style:
                                                                      GoogleFonts
                                                                          .lato(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                                height: 10),
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Text(
                                                                  "Total Amount",
                                                                  style:
                                                                      GoogleFonts
                                                                          .lato(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    width: 30),
                                                                Text(
                                                                  invoice.totalAmount !=
                                                                          null
                                                                      ? invoice
                                                                          .totalAmount
                                                                          .toString()
                                                                      : "Null",
                                                                  style:
                                                                      GoogleFonts
                                                                          .lato(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),

                                                            /// return product
                                                            Obx(() => controllerR
                                                                            .returnSpecific
                                                                            .value
                                                                            .body
                                                                            ?.purchaseReturn ==
                                                                        null ||
                                                                    controllerR
                                                                        .returnSpecific
                                                                        .value
                                                                        .body!
                                                                        .purchaseReturn!
                                                                        .isEmpty
                                                                ? const SizedBox()
                                                                : SingleChildScrollView(
                                                                    scrollDirection:
                                                                        Axis.horizontal,
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Row(
                                                                          children: [
                                                                            Text(
                                                                              "Product Return",
                                                                              style: GoogleFonts.lato(
                                                                                fontWeight: FontWeight.w700,
                                                                                fontSize: 16,
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                        Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.end,
                                                                          children: [
                                                                            DataTable(
                                                                              columns: [
                                                                                DataColumn(
                                                                                    label: Text(
                                                                                  'Product',
                                                                                  style: GoogleFonts.lato(
                                                                                    fontWeight: FontWeight.bold,
                                                                                    fontSize: 14,
                                                                                  ),
                                                                                )),
                                                                                DataColumn(
                                                                                    label: Text(
                                                                                  'Color',
                                                                                  style: GoogleFonts.lato(
                                                                                    fontWeight: FontWeight.bold,
                                                                                    fontSize: 14,
                                                                                  ),
                                                                                )),
                                                                                DataColumn(
                                                                                    label: Text(
                                                                                  'Size',
                                                                                  style: GoogleFonts.lato(
                                                                                    fontWeight: FontWeight.bold,
                                                                                    fontSize: 14,
                                                                                  ),
                                                                                )),
                                                                                DataColumn(
                                                                                  label: Text(
                                                                                    'Quantity',
                                                                                    style: GoogleFonts.lato(
                                                                                      fontWeight: FontWeight.bold,
                                                                                      fontSize: 14,
                                                                                    ),
                                                                                  ),
                                                                                  numeric: true,
                                                                                ),
                                                                                DataColumn(
                                                                                  label: Text(
                                                                                    'Purchase Price',
                                                                                    style: GoogleFonts.lato(
                                                                                      fontWeight: FontWeight.bold,
                                                                                      fontSize: 14,
                                                                                    ),
                                                                                  ),
                                                                                  numeric: true,
                                                                                ),
                                                                                DataColumn(
                                                                                  label: Text(
                                                                                    'Sale Price',
                                                                                    style: GoogleFonts.lato(
                                                                                      fontWeight: FontWeight.bold,
                                                                                      fontSize: 14,
                                                                                    ),
                                                                                  ),
                                                                                  numeric: true,
                                                                                ),
                                                                                DataColumn(
                                                                                  label: Text(
                                                                                    'Sub Total',
                                                                                    style: GoogleFonts.lato(
                                                                                      fontWeight: FontWeight.bold,
                                                                                      fontSize: 14,
                                                                                    ),
                                                                                  ),
                                                                                  numeric: true,
                                                                                ),
                                                                                DataColumn(
                                                                                  label: Text(
                                                                                    'Discount',
                                                                                    style: GoogleFonts.lato(
                                                                                      fontWeight: FontWeight.bold,
                                                                                      fontSize: 14,
                                                                                    ),
                                                                                  ),
                                                                                  numeric: true,
                                                                                ),
                                                                                DataColumn(
                                                                                  label: Text(
                                                                                    'Total Amount',
                                                                                    style: GoogleFonts.lato(
                                                                                      fontWeight: FontWeight.bold,
                                                                                      fontSize: 14,
                                                                                    ),
                                                                                  ),
                                                                                  numeric: true,
                                                                                ),
                                                                              ],
                                                                              rows: controllerR.returnSpecific.value.body!.purchaseReturn!
                                                                                  .expand((product) {
                                                                                    return product.returnProducts != null
                                                                                        ? product.returnProducts!.map((returnProduct) {
                                                                                            return DataRow(
                                                                                              cells: [
                                                                                                DataCell(Text(returnProduct.product != null ? returnProduct.product!.name.toString() : "Null")),
                                                                                                DataCell(Text(returnProduct.color != null ? returnProduct.color!.name.toString() : "Null")),
                                                                                                DataCell(Text(returnProduct.size != null ? returnProduct.size!.number.toString() : "Null")),
                                                                                                DataCell(Text(returnProduct.quantity != null ? returnProduct.quantity.toString() : "Null")),
                                                                                                DataCell(Text(returnProduct.product != null && returnProduct.product!.purchasePrice != null ? returnProduct.product!.purchasePrice.toString() : "Null")),
                                                                                                DataCell(Text(returnProduct.product != null && returnProduct.product!.salePrice != null ? returnProduct.product!.salePrice.toString() : "Null")),
                                                                                                DataCell(Text(returnProduct.subTotal != null ? returnProduct.subTotal.toString() : 'Null')),
                                                                                                DataCell(Text(returnProduct.discount != null ? "${returnProduct.discount}%" : "Null")),
                                                                                                DataCell(Text(returnProduct.totalAmount != null ? returnProduct.totalAmount.toString() : "Null")),
                                                                                              ],
                                                                                            );
                                                                                          }).toList()
                                                                                        : <DataRow>[];
                                                                                  })
                                                                                  .cast<DataRow>()
                                                                                  .toList(),
                                                                            ),
                                                                            const Divider(
                                                                                color: Colors.grey,
                                                                                thickness: 1),
                                                                            Column(
                                                                              children: controllerR.returnSpecific.value.body!.purchaseReturn!.map((product) {
                                                                                return Column(
                                                                                  children: [
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.min,
                                                                                      children: [
                                                                                        Text(
                                                                                          "Sub Total",
                                                                                          style: GoogleFonts.lato(
                                                                                            fontSize: 14,
                                                                                            fontWeight: FontWeight.w600,
                                                                                          ),
                                                                                        ),
                                                                                        const SizedBox(width: 30),
                                                                                        Text(
                                                                                          product.subTotal != null ? product.subTotal.toString() : "Null",
                                                                                          style: GoogleFonts.lato(
                                                                                            fontSize: 14,
                                                                                            fontWeight: FontWeight.w500,
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                    const SizedBox(height: 10),
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.min,
                                                                                      children: [
                                                                                        Text(
                                                                                          "Total Amount",
                                                                                          style: GoogleFonts.lato(
                                                                                            fontSize: 14,
                                                                                            fontWeight: FontWeight.w600,
                                                                                          ),
                                                                                        ),
                                                                                        const SizedBox(width: 30),
                                                                                        Text(
                                                                                          product.totalAmount != null ? product.totalAmount.toString() : "Null",
                                                                                          style: GoogleFonts.lato(
                                                                                            fontSize: 14,
                                                                                            fontWeight: FontWeight.w500,
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ],
                                                                                );
                                                                              }).toList(),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  )),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
                                                child: const CustomIcon(
                                                  icons: Icons.visibility,
                                                  color: Colors.green,
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          MAddReturnPurchase(
                                                        uid: invoice.id
                                                            .toString(),
                                                        company:
                                                            invoice.company !=
                                                                    null
                                                                ? invoice
                                                                    .company!
                                                                    .name
                                                                    .toString()
                                                                : "Unknown",
                                                        user: invoice.user !=
                                                                null
                                                            ? invoice.user!.name
                                                                .toString()
                                                            : "Unknown",
                                                        invoiceNo: invoice
                                                                .invoiceNumber
                                                                ?.toString() ??
                                                            "Unknown",
                                                        companyId:
                                                            invoice.companyId !=
                                                                    null
                                                                ? invoice
                                                                    .companyId
                                                                    .toString()
                                                                : "Unknown",
                                                        salesmanId:
                                                            invoice.userId !=
                                                                    null
                                                                ? invoice.userId
                                                                    .toString()
                                                                : "Unknown",
                                                        products: invoice
                                                                .invoiceProducts
                                                                ?.map(
                                                                    (product) {
                                                              return WProduct(
                                                                maxQuantity: int
                                                                    .parse(product
                                                                            .quantity
                                                                            ?.toString() ??
                                                                        "0"),
                                                                name: product
                                                                            .product !=
                                                                        null
                                                                    ? product
                                                                        .product!
                                                                        .name
                                                                        .toString()
                                                                    : "Unknown",
                                                                color: product
                                                                            .color !=
                                                                        null
                                                                    ? product
                                                                        .color!
                                                                        .name
                                                                        .toString()
                                                                    : "Unknown",
                                                                size: product
                                                                            .size !=
                                                                        null
                                                                    ? product
                                                                        .size!
                                                                        .number
                                                                        .toString()
                                                                    : "Unknown",
                                                                quantity: product
                                                                        .quantity ??
                                                                    0,
                                                                salePrice: product
                                                                            .product !=
                                                                        null
                                                                    ? product
                                                                        .product!
                                                                        .purchasePrice!
                                                                        .toDouble()
                                                                    : 0.0,
                                                                discount: product
                                                                        .discount
                                                                        ?.toDouble() ??
                                                                    0.0,
                                                                productId: product
                                                                        .productId
                                                                        ?.toString() ??
                                                                    "Unknown",
                                                                colorId: product
                                                                        .colorId
                                                                        ?.toString() ??
                                                                    "Unknown",
                                                                sizeId: product
                                                                        .sizeId
                                                                        ?.toString() ??
                                                                    "Unknown",
                                                                typeId: product
                                                                        .typeId
                                                                        ?.toString() ??
                                                                    "Unknown",
                                                                brandId: product
                                                                        .brandId
                                                                        ?.toString() ??
                                                                    "Unknown",
                                                                companyId: product
                                                                        .companyId
                                                                        ?.toString() ??
                                                                    "Unknown",
                                                              );
                                                            }).toList() ??
                                                            [],
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: const CustomIcon(
                                                  icons: Icons.edit,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  await generateInvoice(
                                                      invoiceData);
                                                },
                                                child: const CustomIcon(
                                                  icons: Icons.print,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                return Container();
                              }
                            },
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
