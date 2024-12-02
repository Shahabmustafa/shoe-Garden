import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sofi_shoes/viewmodel/admin/reports/sale_reports/sale_report_viewmodell.dart';
import '../../../../date/response/status.dart';
import '../../../../res/circularindictor/circularindicator.dart';
import '../../../../res/imageurl/image.dart';
import '../../../../res/responsive.dart';
import '../../../../res/slidebar/side_menu_admin.dart';
import '../../../../res/tabletext/table_text.dart';
import '../../../../res/widget/app_boxes.dart';
import '../../../../res/widget/app_drop_down.dart';
import '../../../../res/widget/date_time_picker.dart';
import '../../../../res/widget/general_execption_widget.dart';
import '../../../Branch/drawer/saleinvoice/export/sale_invoice_export.dart';
import '../../../Manager/drawer/dashboard/dashboard_screen_a.dart';

class AdminAllSaleInvoice extends StatefulWidget {
  const AdminAllSaleInvoice({super.key});

  @override
  State<AdminAllSaleInvoice> createState() => _AdminAllSaleInvoiceState();
}

class _AdminAllSaleInvoiceState extends State<AdminAllSaleInvoice> {
  final controller = Get.put(SaleReportViewModel());

  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Sale Invoice"),
      ),
      drawer: !isDesktop ? const SizedBox(width: 250, child: SideMenuWidgetAdmin()) : null,
      body: Row(
        children: [
          if (isDesktop) const Expanded(flex: 2, child: SideMenuWidgetAdmin()),
          Expanded(
            flex: 8,
            child: Obx(() {
              switch (controller.rxRequestStatus.value) {
                case Status.LOADING:
                  return const Center(child: CircularIndicator.waveSpinkit);
                case Status.ERROR:
                  print(controller.error.toString());
                  return GeneralExceptionWidget(
                    errorMessage: controller.error.value.toString(),
                    onPress: () {
                      controller.refresh();
                    },
                  );
                case Status.COMPLETE:
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: AppDropDown(
                                labelText: "Select Branch",
                                items: controller.dropdownItemsBranch.map<String>((item) => item['name'].toString()).toList(),
                                selectedItem: controller.selectBranchName.isEmpty ? null : controller.selectBranchName.value,
                                onChanged: (branchName) {
                                  controller.selectBranchName.value = branchName.toString();
                                  controller.selectWarehouseName.value = '';
                                  var selectBranch = controller.dropdownItemsBranch.firstWhere((items) => items['name'].toString() == branchName, orElse: () => null,);
                                  if (selectBranch != null) {
                                    controller.selectSpecific.value = selectBranch['id'].toString();
                                    controller.BranchSaleReport();

                                  }
                                },
                              ),
                            ),
                            Flexible(
                              child: AppDropDown(
                                labelText: "Select Warehouse",
                                items: controller.dropdownItemsWarehouse.map<String>((item) => item['name'].toString()).toList(),
                                selectedItem: controller.selectWarehouseName.isEmpty ? null : controller.selectWarehouseName.value,
                                onChanged: (warehouseName) {
                                  controller.selectWarehouseName.value = warehouseName.toString();
                                  controller.selectBranchName.value = '';
                                  var selectWarehouse = controller.dropdownItemsWarehouse.firstWhere((items) => items['name'].toString() == warehouseName, orElse: () => null,);
                                  if (selectWarehouse != null) {
                                    controller.selectSpecific.value = selectWarehouse['id'].toString();
                                    controller.BranchSaleReport();
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        child: Row(
                          children: [
                            Flexible(
                              child: AppBoxes(
                                title: "Total Quantity",
                                amount: controller.allBranchesSaleReport.value.body?.totalQty.toString() ?? "0",
                                imageUrl: TImageUrl.imgProductT,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Flexible(
                              child: AppBoxes(
                                title: "Total Sale",
                                amount: controller.allBranchesSaleReport.value.body!.totalSale?.toStringAsFixed(0) ?? "0",
                                imageUrl: TImageUrl.imgPurchaseI,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: Table(
                          columnWidths: const {
                            0: FlexColumnWidth(1),
                            1: FlexColumnWidth(1.5),
                            2: FlexColumnWidth(2),
                            3: FlexColumnWidth(2),
                            4: FlexColumnWidth(2),
                            5: FlexColumnWidth(2),
                            6: FlexColumnWidth(2),
                            7: FlexColumnWidth(2),
                            8: FlexColumnWidth(2),
                            9: FlexColumnWidth(1),
                            10: FlexColumnWidth(1),
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
                                  text: 'invoice',
                                  textColor: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                CustomTableCell(
                                  text: 'Branch',
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
                                  text: 'Sub Total',
                                  textColor: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                CustomTableCell(
                                  text: 'Total Amount',
                                  textColor: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                CustomTableCell(
                                  text: 'Received Amount',
                                  textColor: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                CustomTableCell(
                                  text: 'Payment Method',
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
                        child: Obx(() {
                          switch (controller.rxRequestStatus.value) {
                            case Status.LOADING:
                              return const Center(
                                  child: CircularIndicator.waveSpinkit);
                            case Status.ERROR:
                              return GeneralExceptionWidget(
                                errorMessage: controller.error.value.toString(),
                                onPress: () {
                                  controller.refresh();
                                },
                              );
                            case Status.COMPLETE:
                              return ListView.builder(
                                itemCount: controller.allBranchesSaleReport.value.body!.invoices!.length,
                                itemBuilder: (context, index) {
                                  var allBranches = controller.allBranchesSaleReport.value.body!.invoices![index];
                                  var branchId = allBranches.branch != null ? allBranches.branch!.id : "Null";
                                  String dateTimeString = allBranches.createdAt.toString();
                                  final invoiceData = InvoiceExport(
                                    paymentMethod: allBranches.paymentMethod ?? "Null",
                                    id: allBranches.invoiceNumber?.toString() ?? "Unknown",
                                    date: DateTime.now(),
                                    saleman: Salesman(name: allBranches.saleman != null ? allBranches.saleman!.name.toString() : "Unknown",),
                                    customer: Customer(name: allBranches.customer != null ? allBranches.customer!.name : "Unknown",),
                                    total: allBranches.totalAmount?.toString() ?? "0",
                                    items: allBranches.invoiceProducts?.map((products) {
                                      return InvoiceItem(
                                        product: products.product != null
                                            ? products.product!.name
                                            .toString()
                                            : "Unknown Product",
                                        salePrice: products.salePrice
                                            ?.toString() ??
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
                                        totalAmount: products.totalAmount
                                            ?.toString() ??
                                            "0", // Handles null totalAmount
                                      );
                                    }).toList() ?? [],
                                  );
                                  DateTime dateTime = DateTime.parse(dateTimeString);
                                  String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                    child: Table(
                                      columnWidths: const {
                                        0: FlexColumnWidth(1),
                                        1: FlexColumnWidth(1.5),
                                        2: FlexColumnWidth(2),
                                        3: FlexColumnWidth(2),
                                        4: FlexColumnWidth(2),
                                        5: FlexColumnWidth(2),
                                        6: FlexColumnWidth(2),
                                        7: FlexColumnWidth(2),
                                        8: FlexColumnWidth(2),
                                        9: FlexColumnWidth(1),
                                        10: FlexColumnWidth(1),
                                      },
                                      border: TableBorder.all(
                                        color: Colors.grey.shade300,
                                      ),
                                      defaultColumnWidth:
                                      const FlexColumnWidth(0.5),
                                      children: [
                                        TableRow(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                          ),
                                          children: [
                                            CustomTableCell(
                                              text: "${index + 1}",
                                              textColor: Colors.black,
                                            ),
                                            CustomTableCell(
                                              text: allBranches.invoiceNumber
                                                  .toString(),
                                              textColor: Colors.black,
                                            ),
                                            CustomTableCell(
                                              text: allBranches.branch != null ? allBranches.branch!.name : "Null",
                                              textColor: Colors.black,
                                            ),
                                            CustomTableCell(
                                              text: allBranches.customer != null ? allBranches.customer!.name : "Null",
                                              textColor: Colors.black,
                                            ),
                                            CustomTableCell(
                                              text: allBranches.saleman != null ? allBranches.saleman!.name : "Null",
                                              textColor: Colors.black,
                                            ),
                                            CustomTableCell(
                                              text: allBranches.subTotal?.toString() ?? "0",
                                              textColor: Colors.black,
                                            ),
                                            CustomTableCell(
                                              text: allBranches.totalAmount?.toString() ?? "0",
                                              textColor: Colors.black,
                                            ),
                                            CustomTableCell(
                                              text: allBranches.receivedAmount?.toString() ?? "0",
                                              textColor: Colors.black,
                                            ),
                                            CustomTableCell(
                                              text: allBranches.paymentMethod?.toString() ?? "Null",
                                              textColor: Colors.black,
                                            ),
                                            CustomIcon(
                                              icons: Icons
                                                  .remove_red_eye_rounded,
                                              color: Colors.green,
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
                                                                "Sale Invoice Report",
                                                                style:
                                                                GoogleFonts
                                                                    .lato(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                  fontSize:
                                                                  20,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 20,
                                                              ),
                                                              Text(
                                                                "Invoice : ${allBranches.invoiceNumber != null ? allBranches.invoiceNumber.toString() : "Null"}",
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
                                                              const SizedBox(
                                                                height: 20,
                                                              ),
                                                              Text(
                                                                "Salesman : ${allBranches.saleman != null ? allBranches.saleman!.name.toString() : "Null"}",
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
                                                                "Customer : ${allBranches.customer != null ? allBranches.customer!.name.toString() : "Null"}",
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
                                                                      'Sale Price'),
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
                                                              rows: allBranches
                                                                  .invoiceProducts !=
                                                                  null
                                                                  ? allBranches
                                                                  .invoiceProducts!
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
                                                                        DataCell(Text(product.quantity != null
                                                                            ? product.quantity.toString()
                                                                            : "Null")),
                                                                        DataCell(Text(product.product != null
                                                                            ? product.product!.salePrice.toString()
                                                                            : "Null")),
                                                                        DataCell(
                                                                          Text(
                                                                            product.subTotal != null ? product.subTotal.toString() : '0',
                                                                          ),
                                                                        ),
                                                                        DataCell(
                                                                          Text(
                                                                            product.discount != null ? "${product.discount}%" : "0",
                                                                          ),
                                                                        ),
                                                                        DataCell(
                                                                          Text(
                                                                            product.totalAmount != null ? product.totalAmount.toString() : "0",
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
                                                                allBranches.subTotal !=
                                                                    null
                                                                    ? allBranches
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
                                                                allBranches.totalAmount !=
                                                                    null
                                                                    ? allBranches
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
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
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
                                                                width: 30,
                                                              ),
                                                              Text(
                                                                allBranches.receivedAmount !=
                                                                    null
                                                                    ? allBranches
                                                                    .receivedAmount
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
                                                  },
                                                );
                                              },
                                            ),
                                            CustomIcon(
                                              icons: Icons.print,
                                              color: Colors.red,
                                              onTap: () async {
                                                await generateInvoice(
                                                    invoiceData);
                                              },
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                          }
                        }),
                      ),
                    ],
                  );
              }
            }),
          ),
        ],
      ),
    );
  }
}
