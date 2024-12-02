import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sofi_shoes/date/response/status.dart';
import 'package:sofi_shoes/res/circularindictor/circularindicator.dart';
import 'package:sofi_shoes/res/responsive.dart';
import 'package:sofi_shoes/res/widget/general_execption_widget.dart';

import '../../../../../res/slidebar/side_menu_warehouse.dart';
import '../../../../../res/tabletext/table_text.dart';
import '../../../../res/widget/textfield/app_text_field.dart';
import '../../../../viewmodel/warehouse/purchase invoice/returned_purchase_invoice_viewmodel.dart';
import '../../../Branch/drawer/saleinvoice/export/sale_invoice_export.dart';
import '../../../Manager/drawer/dashboard/dashboard_screen_a.dart';

// ignore: must_be_immutable
class WReturnedPurchaseInvoiceReport extends StatefulWidget {
  const WReturnedPurchaseInvoiceReport({super.key});

  @override
  State<WReturnedPurchaseInvoiceReport> createState() =>
      _WReturnedPurchaseInvoiceReportState();
}

class _WReturnedPurchaseInvoiceReportState
    extends State<WReturnedPurchaseInvoiceReport> {
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
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReturnedPurchaseInvoiceViewmodel());

    final isDesktop = Responsive.isDesktop(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Return Purchase Invoice Report"),
      ),
      drawer: !isDesktop
          ? const SizedBox(
              width: 250,
              child: SideMenuWidgetWarehouse(),
            )
          : null,
      body: Row(
        children: [
          isDesktop
              ? const Expanded(flex: 2, child: SideMenuWidgetWarehouse())
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
                                    text: 'Warehouse',
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
                            itemCount: controller.saleReturnInvoiceList.value
                                .body!.purchaseReturn!.length,
                            itemBuilder: (context, index) {
                              final invoice = controller.saleReturnInvoiceList
                                  .value.body!.purchaseReturn![index];
                              String dateTimeString =
                                  invoice.createdAt.toString();
                              DateTime dateTime =
                                  DateTime.parse(dateTimeString);
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(dateTime);
                              final invoiceData = InvoiceExport(
                                id: invoice.invoiceNumber?.toString() ?? 'N/A',
                                paymentMethod: "",
                                date: DateTime.now(),
                                saleman: Salesman(
                                    name: invoice.user != null
                                        ? invoice.user!.name
                                        : 'Unknown'),
                                customer: Customer(
                                    name: invoice.returnProducts?.first.company
                                            ?.name ??
                                        'Unknown'),
                                total: invoice.totalAmount?.toString() ?? '0',
                                items: invoice.returnProducts?.map((product) {
                                      return InvoiceItem(
                                        product: product.product != null
                                            ? product.product!.name.toString()
                                            : 'Unknown Product',
                                        salePrice:
                                            product.purchasePrice?.toString() ??
                                                '0',
                                        qty: int.tryParse(
                                                product.quantity?.toString() ??
                                                    '0') ??
                                            0,
                                        dis: product.discount != null
                                            ? "${product.discount}%"
                                            : "Null",
                                        subTotal:
                                            product.subTotal?.toString() ?? '0',
                                        totalAmount:
                                            product.totalAmount?.toString() ??
                                                '0',
                                      );
                                    }).toList() ??
                                    [],
                              );

                              if (controller.search.value.text.isEmpty ||
                                  (invoice.invoiceNumber != null &&
                                      invoice.invoiceNumber!
                                          .toString()
                                          .toLowerCase()
                                          .contains(controller.search.value.text
                                              .trim()
                                              .toLowerCase())) ||
                                  (invoice.returnProducts != null &&
                                      invoice.returnProducts!.any((product) =>
                                          product.company?.name
                                              ?.toLowerCase()
                                              .contains(controller
                                                  .search.value.text
                                                  .trim()
                                                  .toLowerCase()) ??
                                          false))) {
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
                                                text: invoice.invoiceNumber
                                                        ?.toString() ??
                                                    "Null",
                                                textColor: Colors.black,
                                              ),
                                              CustomTableCell(
                                                text: invoice.returnProducts
                                                            ?.first.company !=
                                                        null
                                                    ? invoice.returnProducts!
                                                        .first.company!.name
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
                                                text: formattedDate,
                                                textColor: Colors.black,
                                              ),
                                              GestureDetector(
                                                onTap: () {
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
                                                                  "Invoice : ${invoice.invoiceNumber?.toString() ?? "Null"}",
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
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Text(
                                                                  "Date : $formattedDate",
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
                                                                Text(
                                                                  "User : ${invoice.user?.name?.toString() ?? "Null"}",
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
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Text(
                                                                  invoice.returnProducts?.first.company
                                                                              ?.name !=
                                                                          null
                                                                      ? "Company : ${invoice.returnProducts!.first.company!.name.toString()}"
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
                                                                        'Product'),
                                                                    numeric:
                                                                        false,
                                                                  ),
                                                                  DataColumn(
                                                                    label: Text(
                                                                        'Color'),
                                                                    numeric:
                                                                        false,
                                                                  ),
                                                                  DataColumn(
                                                                    label: Text(
                                                                        'Size'),
                                                                    numeric:
                                                                        false,
                                                                  ),
                                                                  DataColumn(
                                                                    label: Text(
                                                                        'Quantity'),
                                                                    numeric:
                                                                        true,
                                                                  ),
                                                                  DataColumn(
                                                                    label: Text(
                                                                        'Purchase Price'),
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
                                                                        'Discount'),
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
                                                                        .returnProducts
                                                                        ?.map(
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
                                                                          DataCell(Text(product.quantity?.toString() ??
                                                                              "Null")),
                                                                          DataCell(Text(product.product?.purchasePrice?.toString() ??
                                                                              "Null")),
                                                                          DataCell(Text(product.subTotal?.toString() ??
                                                                              'Null')),
                                                                          DataCell(Text(product.discount != null
                                                                              ? "${product.discount}%"
                                                                              : "Null")),
                                                                          DataCell(Text(product.totalAmount?.toString() ??
                                                                              "Null")),
                                                                        ],
                                                                      );
                                                                    }).toList() ??
                                                                    [],
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 30,
                                                            ),
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
                                                                  width: 30,
                                                                ),
                                                                Text(
                                                                  invoice.subTotal
                                                                          ?.toString() ??
                                                                      "Null",
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
                                                              height: 10,
                                                            ),
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
                                                                  width: 30,
                                                                ),
                                                                Text(
                                                                  invoice.totalAmount
                                                                          ?.toString() ??
                                                                      "Null",
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
          )
         ],
      ),
    );
  }
}
