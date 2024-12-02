import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sofi_shoes/res/tabletext/table_text.dart';
import 'package:sofi_shoes/viewmodel/user_preference/session_controller.dart';

import '../../../../date/response/status.dart';
import '../../../../res/circularindictor/circularindicator.dart';
import '../../../../res/responsive.dart';
import '../../../../res/slidebar/side_menu_warehouse.dart';
import '../../../../res/widget/date_time_picker.dart';
import '../../../../res/widget/general_execption_widget.dart';
import '../../../../res/widget/textfield/app_text_field.dart';
import '../../../../viewmodel/branch/saleinvoice/exchange_product_viewmodel.dart';
import '../../../Branch/drawer/saleinvoice/export/sale_invoice_export.dart';
import '../../../Manager/drawer/dashboard/dashboard_screen_a.dart';

class WExchangeProductReport extends StatefulWidget {
  const WExchangeProductReport({super.key});

  @override
  State<WExchangeProductReport> createState() => _WExchangeProductReportState();
}

class _WExchangeProductReportState extends State<WExchangeProductReport> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ExchangeProductViewmodel());
    final isDesktop = Responsive.isDesktop(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Exchange Product Report"),
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
                        // controller.refreshApi();
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
                                    text: 'Customer',
                                    textColor: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  CustomTableCell(
                                    text: 'Salesman',
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
                            itemCount: controller
                                    .exchangeProductList.value.body?.length ??
                                0,
                            itemBuilder: (context, index) {
                              final exchange = controller
                                  .exchangeProductList.value.body![index];

                              // Check for null values
                              String dateTimeString =
                                  exchange.createdAt?.toString() ?? '';
                              DateTime? dateTime = dateTimeString.isNotEmpty
                                  ? DateTime.parse(dateTimeString)
                                  : null;
                              String formattedDate = dateTime != null
                                  ? DateFormat('yyyy-MM-dd').format(dateTime)
                                  : 'Unknown';

                              final invoiceData = InvoiceExport(
                                id: exchange.invoiceNumber?.toString() ?? 'Unknown',
                                paymentMethod: "",
                                date: DateTime.now(),
                                saleman: Salesman(
                                  name:
                                      SessionController.user.name ?? 'Unknown',
                                ),
                                customer: Customer(
                                  name: controller.getCustomerName(
                                          exchange.newCustomerId?.toString() ??
                                              '') ??
                                      'Unknown',
                                ),
                                total: exchange.newTotalAmount?.toString() ??
                                    'Unknown',
                                items: exchange.exchangesProducts
                                        ?.map((product) {
                                      return InvoiceItem(
                                        product: product.newProduct != null
                                            ? product.newProduct!.name
                                                .toString()
                                            : 'Unknown',
                                        salePrice: product.newSalePrice != null
                                            ? product.newSalePrice.toString()
                                            : 'Unknown',
                                        qty: int.tryParse(product.newQuantity
                                                    ?.toString() ??
                                                '0') ??
                                            0,
                                        dis: product.newDiscount != null
                                            ? "${product.newDiscount}%"
                                            : "Null",
                                        subTotal:
                                            product.newSubTotal?.toString() ??
                                                "null",
                                        totalAmount: product.newTotalAmount
                                                ?.toString() ??
                                            "Null",
                                      );
                                    }).toList() ??
                                    [],
                              );

                              if (controller.search.value.text.isEmpty ||
                                  invoiceData.customer?.name
                                          ?.toLowerCase()
                                          .contains(controller.search.value.text
                                              .trim()
                                              .toLowerCase()) ==
                                      true ||
                                  exchange.invoiceNumber
                                          ?.toString()
                                          .toLowerCase()
                                          .contains(controller.search.value.text
                                              .trim()
                                              .toLowerCase()) ==
                                      true) {
                                String saleman =
                                    SessionController.user.name ?? 'Unknown';

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
                                                text: exchange.invoiceNumber
                                                        ?.toString() ??
                                                    "Null",
                                                textColor: Colors.black,
                                              ),
                                              CustomTableCell(
                                                text: controller.getCustomerName(
                                                        exchange.newCustomerId
                                                                ?.toString() ??
                                                            '') ??
                                                    "Null",
                                                textColor: Colors.black,
                                              ),
                                              CustomTableCell(
                                                text: saleman,
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
                                                                  "Invoice : ${exchange.invoiceNumber?.toString() ?? "Null"}",
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
                                                                  "Saleman : $saleman",
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
                                                                  "Customer : ${controller.getCustomerName(exchange.newCustomerId?.toString() ?? '') ?? "Null"}",
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
                                                                          'Quantity')),
                                                                  DataColumn(
                                                                      label: Text(
                                                                          'Sale Price')),
                                                                  DataColumn(
                                                                      label: Text(
                                                                          'Sub Total')),
                                                                  DataColumn(
                                                                      label: Text(
                                                                          'Discount')),
                                                                  DataColumn(
                                                                      label: Text(
                                                                          'Total Amount')),
                                                                ],
                                                                rows: exchange
                                                                        .exchangesProducts
                                                                        ?.map(
                                                                            (product) {
                                                                      return DataRow(
                                                                        cells: [
                                                                          DataCell(Text(product.newProduct != null
                                                                              ? product.newProduct!.name.toString()
                                                                              : "Null")),
                                                                          DataCell(Text(product.newColor != null
                                                                              ? product.newColor!.name.toString()
                                                                              : "Null")),
                                                                          DataCell(Text(product.newSize != null
                                                                              ? product.newSize!.number.toString()
                                                                              : "Null")),
                                                                          DataCell(Text(product.newQuantity?.toString() ??
                                                                              "Null")),
                                                                          DataCell(Text(product.newProduct != null
                                                                              ? product.newProduct!.salePrice.toString()
                                                                              : "Null")),
                                                                          DataCell(Text(product.newSubTotal?.toString() ??
                                                                              'null')),
                                                                          DataCell(Text(product.newDiscount != null
                                                                              ? "${product.newDiscount}%"
                                                                              : "Null")),
                                                                          DataCell(Text(product.newTotalAmount?.toString() ??
                                                                              'null')),
                                                                        ],
                                                                      );
                                                                    }).toList() ??
                                                                    [],
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                height: 30),
                                                            const Divider(color: Colors.grey, thickness: 1),
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
                                                                const SizedBox(
                                                                    width: 30),
                                                                Text(
                                                                  exchange.newSubTotal
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
                                                            const SizedBox(height: 10),
                                                            Row(
                                                              mainAxisSize: MainAxisSize.min,
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
                                                                  exchange.newSubTotal
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
                                                            Row(
                                                              mainAxisSize: MainAxisSize.min,
                                                              children: [
                                                                Text(
                                                                  "Return Amount",
                                                                  style:
                                                                  GoogleFonts.lato(
                                                                    fontSize: 14,
                                                                    fontWeight: FontWeight.w600,
                                                                  ),
                                                                ),
                                                                const SizedBox(width: 30),
                                                                Text(
                                                                  exchange.returnAmount?.toString() ?? "Null",
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
                                                                  exchange.receivedAmount
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
