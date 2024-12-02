import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sofi_shoes/date/response/status.dart';
import 'package:sofi_shoes/res/circularindictor/circularindicator.dart';
import 'package:sofi_shoes/res/responsive.dart';
import 'package:sofi_shoes/res/slidebar/side_menu_warehouse.dart';
import 'package:sofi_shoes/res/widget/general_execption_widget.dart';

import '../../../../res/tabletext/table_text.dart';
import '../../../../res/widget/textfield/app_text_field.dart';
import '../../../../viewmodel/warehouse/purchase invoice/purchase_invoice_viewmodel.dart';
import '../../../Branch/drawer/saleinvoice/export/sale_invoice_export.dart';
import '../../../Manager/drawer/dashboard/dashboard_screen_a.dart';

class WPurchaseInvoiceReport extends StatefulWidget {
  const WPurchaseInvoiceReport({super.key});

  @override
  State<WPurchaseInvoiceReport> createState() => _WPurchaseInvoiceReportState();
}

class _WPurchaseInvoiceReportState extends State<WPurchaseInvoiceReport> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WPurchaseInvoiceViewModel());
    final isDesktop = Responsive.isDesktop(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Purchase Invoice Report"),
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
                          padding: const EdgeInsets.only(
                              left: 10, top: 10, bottom: 5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: AppTextField(
                                  controller: controller.search.value,
                                  labelText: "Search Company Name and Invoice",
                                  prefixIcon: const Icon(Icons.search),
                                  search: true,
                                  onChanged: (value) {
                                    setState(() {});
                                    controller.searchValue.value = value;
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
                              // borderRadius: BorderRadius.circular(5),
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
                                    text: 'Type',
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
                            itemCount: controller.purchaseInvoiceList.value
                                .body!.purchaseInvoices!.length,
                            itemBuilder: (context, index) {
                              final invoice = controller.purchaseInvoiceList
                                  .value.body!.purchaseInvoices![index];
                              String dateTimeString =
                                  invoice.createdAt.toString();
                              DateTime dateTime =
                                  DateTime.parse(dateTimeString);
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(dateTime);
                              final invoiceData = InvoiceExport(
                                paymentMethod: "",
                                id: invoice.invoiceNumber?.toString() ??
                                    "Unknown", // Ensures id is never null
                                date: DateTime.now(), // Uses the current date
                                saleman: Salesman(
                                  name: invoice.user != null
                                      ? invoice.user!.name.toString()
                                      : "Unknown",
                                ),
                                customer: Customer(
                                  name: invoice.company != null
                                      ? invoice.company!.name
                                      : "Unknown",
                                ),
                                total: invoice.totalAmount?.toString() ??
                                    "0", // Handles null totalAmount
                                items: invoice.invoiceProducts?.map((products) {
                                      return InvoiceItem(
                                        product: products.product != null
                                            ? products.product!.name.toString()
                                            : "Unknown Product",
                                        salePrice:
                                            products.salePrice?.toString() ??
                                                "0",
                                        qty: products.quantity != null
                                            ? int.tryParse(products.quantity
                                                    .toString()) ??
                                                0
                                            : 0,
                                        dis: products.discount != null
                                            ? "${products.discount}%"
                                            : "0%",
                                        subTotal:
                                            products.subTotal?.toString() ??
                                                "0",
                                        totalAmount:
                                            products.totalAmount?.toString() ??
                                                "0", // Handles null totalAmount
                                      );
                                    }).toList() ??
                                    [],
                              );
                              var name =
                                  invoice.invoiceNumber?.toString() ?? "Null";
                              var company = invoice.company != null
                                  ? invoice.company!.name
                                  : "Null";
                              if (controller.search.value.text.isEmpty ||
                                  name.toLowerCase().contains(controller
                                      .search.value.text
                                      .trim()
                                      .toLowerCase()) ||
                                  company!.toString().toLowerCase().contains(
                                      controller.search.value.text
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
                                                text: invoice.invoiceNumber
                                                        ?.toString() ??
                                                    "Null", // Handle null
                                                textColor: Colors.black,
                                              ),
                                              CustomTableCell(
                                                text: invoice.company != null
                                                    ? invoice.company!.name
                                                    : "Null", // Handle null
                                                textColor: Colors.black,
                                              ),
                                              CustomTableCell(
                                                text: invoice.user != null
                                                    ? invoice.user!.name
                                                    : "Null", // Handle null
                                                textColor: Colors.black,
                                              ),
                                              CustomTableCell(
                                                text:
                                                    formattedDate, // Assume formattedDate is non-null
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
                                                                  "Invoice: ${invoice.invoiceNumber?.toString() ?? "Null"}",
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
                                                                    height: 10),
                                                                Text(
                                                                  "Date: ${formattedDate ?? "Null"}",
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
                                                                  "User: ${invoice.user != null ? invoice.user!.name : "Null"}",
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
                                                                    height: 10),
                                                                Text(
                                                                  "Company: ${invoice.company != null ? invoice.company!.name : "Null"}",
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
                                                                headingTextStyle:
                                                                    TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                                columns: const [
                                                                  DataColumn(
                                                                    label: Text(
                                                                        'Product'),
                                                                  ),
                                                                  DataColumn(
                                                                    label: Text(
                                                                        'Color'),
                                                                  ),
                                                                  DataColumn(
                                                                    label: Text(
                                                                        'Size'),
                                                                  ),
                                                                  DataColumn(
                                                                    label: Text(
                                                                        'Quantity'),
                                                                  ),
                                                                  DataColumn(
                                                                    label: Text(
                                                                        'Purchase Price'),
                                                                  ),
                                                                  DataColumn(
                                                                      label:
                                                                          Text(
                                                                    'Sub Total',
                                                                  )),
                                                                  DataColumn(
                                                                      label:
                                                                          Text(
                                                                    'Discount',
                                                                  )),
                                                                  DataColumn(
                                                                      label:
                                                                          Text(
                                                                    'Total Amount',
                                                                  )),
                                                                ],
                                                                rows: invoice
                                                                        .invoiceProducts
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
                                                                          DataCell(Text(product.size?.number?.toString() ??
                                                                              "Null")),
                                                                          DataCell(Text(product.quantity?.toString() ??
                                                                              "Null")),
                                                                          DataCell(Text(product.product?.purchasePrice?.toString() ??
                                                                              "Null")),
                                                                          DataCell(Text(product.subTotal?.toString() ??
                                                                              "Null")),
                                                                          DataCell(Text(product.discount != null
                                                                              ? "${product.discount}%"
                                                                              : "Null")),
                                                                          DataCell(Text(product.totalAmount?.toString() ??
                                                                              "Null")),
                                                                        ],
                                                                      );
                                                                    }).toList() ??
                                                                    [], // Handle null product list
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
                                                                  invoice.subTotal
                                                                          ?.toString() ??
                                                                      "Null", // Handle null subTotal
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
                                                                  invoice.totalAmount
                                                                          ?.toString() ??
                                                                      "Null", // Handle null totalAmount
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
                                                                  "Received Amount",
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
                                                                  invoice.receivedAmount
                                                                          ?.toString() ??
                                                                      "Null", // Handle null receivedAmount
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
