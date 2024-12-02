import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sofi_shoes/date/response/status.dart';
import 'package:sofi_shoes/res/circularindictor/circularindicator.dart';
import 'package:sofi_shoes/res/responsive.dart';
import 'package:sofi_shoes/res/slidebar/side_menu_warehouse.dart';
import 'package:sofi_shoes/res/widget/general_execption_widget.dart';
import 'package:sofi_shoes/viewmodel/branch/saleinvoice/sale_return_invoice_viewmodel.dart';
import 'package:sofi_shoes/viewmodel/user_preference/session_controller.dart';
import 'package:sofi_shoes/viewmodel/warehouse/report/sale_return_report_viewmodel.dart';

import '../../../../res/imageurl/image.dart';
import '../../../../res/tabletext/table_text.dart';
import '../../../../res/widget/app_boxes.dart';
import '../../../../res/widget/date_time_picker.dart';
import '../../../../res/widget/textfield/app_text_field.dart';
import '../../../Branch/drawer/saleinvoice/export/sale_invoice_export.dart';
import '../../../Manager/drawer/dashboard/dashboard_screen_a.dart';

class WarehouseSaleReturnScreenReport extends StatefulWidget {
  const WarehouseSaleReturnScreenReport({super.key});

  @override
  State<WarehouseSaleReturnScreenReport> createState() =>
      _WarehouseSaleReturnScreenReportState();
}

class _WarehouseSaleReturnScreenReportState
    extends State<WarehouseSaleReturnScreenReport> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WarehouseSaleReturnInvoiceReportViewModel());
    final isDesktop = Responsive.isDesktop(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Warehouse Sale Return Report"),
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
                              Expanded(
                                child: DateTimePicker(
                                  hintText: 'From Date',
                                  onTap: () {
                                    controller.selectDate(context, true);
                                  },
                                  controller: controller.startDate.value,
                                ),
                              ),
                              const SizedBox(width: 10), // Spacer between the DateTimePickers
                              Expanded(
                                child: DateTimePicker(
                                  hintText: 'To Date',
                                  onTap: () {
                                    controller.selectDate(context, false);
                                  },
                                  controller: controller.endDate.value,
                                ),
                              ),
                              const SizedBox(width: 10), // Spacer between the DateTimePickers
                              ElevatedButton(
                                onPressed: (){
                                  controller.refreshApi();
                                  controller.startDate.value.clear();
                                  controller.endDate.value.clear();
                                },
                                child: Text("Clear"),
                              )
                            ],
                          ),
                        ),
                        Obx(() {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                            child: Row(
                              children: [
                                Flexible(
                                  child: AppBoxes(
                                    title: "Total Quantity",
                                    amount: controller.saleReturnInvoiceList.value.body?.totalQuantity.toString() ?? "0",
                                    imageUrl: TImageUrl.imgProductT,
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Flexible(
                                  child: AppBoxes(
                                    title: "Total Sale Amount",
                                    amount: controller.saleReturnInvoiceList.value.body?.totalReturn.toString() ?? "0",
                                    imageUrl: TImageUrl.imgPurchaseI,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Table(
                            columnWidths: const {
                              0: FlexColumnWidth(1),
                              1: FlexColumnWidth(2),
                              2: FlexColumnWidth(2),
                              3: FlexColumnWidth(2),
                              4: FlexColumnWidth(2),
                              5: FlexColumnWidth(2),
                              6: FlexColumnWidth(2),
                              7: FlexColumnWidth(1),
                              8: FlexColumnWidth(1),
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
                                    text: 'Date',
                                    textColor: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  CustomTableCell(
                                    text: 'Customer',
                                    textColor: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  CustomTableCell(
                                    text: 'Warehouse',
                                    textColor: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  CustomTableCell(
                                    text: 'sub Total',
                                    textColor: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  CustomTableCell(
                                    text: 'Total Amount',
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
                                .body!.saleReturn!.length,
                            itemBuilder: (context, index) {
                              final invoice = controller.saleReturnInvoiceList
                                  .value.body!.saleReturn![index];
                              String dateTimeString =
                                  invoice.createdAt.toString();
                              DateTime dateTime =
                                  DateTime.parse(dateTimeString);
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(dateTime);
                              final invoiceData = InvoiceExport(
                                id: invoice.invoiceNumber.toString(),
                                paymentMethod: "",
                                date: DateTime.now(),
                                saleman: Salesman(
                                    name:
                                        SessionController.user.name ?? 'null'),
                                customer: Customer(
                                    name: invoice.customer != null
                                        ? invoice.customer!.name
                                        : 'null'),
                                total: invoice.totalAmount.toString(),
                                items: invoice.returnProducts!.map((product) {
                                  return InvoiceItem(
                                    product: product.product != null
                                        ? product.product!.name.toString()
                                        : 'null',
                                    salePrice: product.salePrice.toString(),
                                    qty: int.parse(product.quantity.toString()),
                                    dis: product.discount != null
                                        ? "${product.discount}%"
                                        : "Null",
                                    subTotal: product.subTotal != null
                                        ? product.subTotal.toString()
                                        : 'null',
                                    totalAmount: product.totalAmount != null
                                        ? product.totalAmount.toString()
                                        : "Null",
                                  );
                                }).toList(),
                              );

                              if (controller.search.value.text.isEmpty ||
                                  invoiceData.customer!
                                      .toString()
                                      .toLowerCase()
                                      .contains(controller.search.value.text
                                          .trim()
                                          .toLowerCase()) ||
                                  invoiceData.id!
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
                                          5: FlexColumnWidth(2),
                                          6: FlexColumnWidth(2),
                                          7: FlexColumnWidth(1),
                                          8: FlexColumnWidth(1),
                                        },
                                        border: TableBorder.all(
                                          // borderRadius: BorderRadius.circular(5),
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
                                                text: invoice.invoiceNumber != null ? invoice.invoiceNumber.toString() : "Null",
                                                textColor: Colors.black,
                                              ),
                                              CustomTableCell(
                                                text: formattedDate,
                                                textColor: Colors.black,
                                              ),
                                              CustomTableCell(
                                                text: invoice.customer != null ? invoice.customer!.name.toString() : "Null",
                                                textColor: Colors.black,
                                              ),
                                              CustomTableCell(
                                                text: SessionController.user.name ?? 'null',
                                                textColor: Colors.black,
                                              ),
                                              CustomTableCell(
                                                text: invoice.subTotal?.toString() ?? "0",
                                                textColor: Colors.black,
                                              ),
                                              CustomTableCell(
                                                text: invoice.totalAmount?.toString() ?? "0",
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
                                                                    "Invoice : ${invoice.invoiceNumber != null ? invoice.invoiceNumber.toString() : "Null"}",
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
                                                                    invoice.saleman !=
                                                                            null
                                                                        ? invoice
                                                                            .saleman!
                                                                            .name
                                                                            .toString()
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
                                                                  const SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  Text(
                                                                    invoice.customer !=
                                                                            null
                                                                        ? invoice
                                                                            .customer!
                                                                            .name
                                                                            .toString()
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
                                                                MainAxisSize
                                                                    .min,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .end,
                                                            children: [
                                                              SingleChildScrollView(
                                                                scrollDirection:
                                                                    Axis.horizontal,
                                                                child:
                                                                    DataTable(
                                                                  // columnSpacing: 16, // Adjust as needed
                                                                  // dataRowHeight: 60, // Adjust as needed
                                                                  columns: const [
                                                                    DataColumn(
                                                                      label: Text(
                                                                          'Product'),
                                                                      numeric:
                                                                          false, // Adjust based on content
                                                                    ),
                                                                    DataColumn(
                                                                      label: Text(
                                                                          'Color'),
                                                                      numeric:
                                                                          false, // Adjust based on content
                                                                    ),
                                                                    DataColumn(
                                                                      label: Text(
                                                                          'Size'),
                                                                      numeric:
                                                                          false, // Adjust based on content
                                                                    ),
                                                                    DataColumn(
                                                                      label: Text(
                                                                          'Quantity'),
                                                                      numeric:
                                                                          true, // Adjust based on content
                                                                    ),
                                                                    DataColumn(
                                                                      label: Text(
                                                                          'Sale Price'),
                                                                      numeric:
                                                                          true, // Adjust based on content
                                                                    ),
                                                                    DataColumn(
                                                                      label: Text(
                                                                          'Sub Total'),
                                                                      numeric:
                                                                          true, // Adjust based on content
                                                                    ),
                                                                    DataColumn(
                                                                      label: Text(
                                                                          'Discount'),
                                                                      numeric:
                                                                          true, // Adjust based on content
                                                                    ),
                                                                    DataColumn(
                                                                      label: Text(
                                                                          'Total Amount'),
                                                                      numeric:
                                                                          true, // Adjust based on content
                                                                    ),
                                                                  ],
                                                                  rows: invoice
                                                                              .returnProducts !=
                                                                          null
                                                                      ? invoice
                                                                          .returnProducts!
                                                                          .map(
                                                                              (product) {
                                                                          return DataRow(
                                                                            cells: [
                                                                              DataCell(
                                                                                Text(product.product != null ? product.product!.name.toString() : "Null"),
                                                                              ),
                                                                              DataCell(
                                                                                Text(product.color != null ? product.color!.name.toString() : "Null"),
                                                                              ),
                                                                              DataCell(
                                                                                Text(product.size != null ? product.size!.number.toString() : "Null"),
                                                                              ),
                                                                              DataCell(Text(product.quantity != null ? product.quantity.toString() : "Null")),
                                                                              DataCell(Text(product.product!.salePrice != null ? product.product!.salePrice.toString() : "Null")),
                                                                              DataCell(Text(product.subTotal != null ? product.subTotal.toString() : 'null')),
                                                                              DataCell(
                                                                                Text(
                                                                                  product.discount != null ? "${product.discount}%" : "Null", // Display discount percentage or "Null" if discount is null
                                                                                ),
                                                                              ),
                                                                              DataCell(
                                                                                Text(
                                                                                  product.totalAmount != null ? product.totalAmount.toString() : "Null",
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          );
                                                                        }).toList()
                                                                      : [],
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
                                                              )
                                                            ],
                                                          ),
                                                        );
                                                      });
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
