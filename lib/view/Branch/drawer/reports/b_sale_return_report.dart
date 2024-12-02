import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sofi_shoes/date/response/status.dart';
import 'package:sofi_shoes/res/circularindictor/circularindicator.dart';
import 'package:sofi_shoes/res/responsive.dart';
import 'package:sofi_shoes/res/widget/general_execption_widget.dart';
import 'package:sofi_shoes/viewmodel/branch/saleinvoice/sale_return_invoice_viewmodel.dart';

import '../../../../res/imageurl/image.dart';
import '../../../../res/slidebar/side_menu_branch.dart';
import '../../../../res/tabletext/table_text.dart';
import '../../../../res/widget/app_boxes.dart';
import '../../../../res/widget/date_time_picker.dart';
import '../../../../res/widget/textfield/app_text_field.dart';
import '../../../../viewmodel/branch/report/sale_return_invoice_report_viewmodel.dart';
import '../../../Manager/drawer/dashboard/dashboard_screen_a.dart';
import '../saleinvoice/export/sale_invoice_export.dart';

class BSaleReturnReport extends StatefulWidget {
  const BSaleReturnReport({super.key});

  @override
  State<BSaleReturnReport> createState() => _BSaleReturnReportState();
}

class _BSaleReturnReportState extends State<BSaleReturnReport> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SaleReturnInvoiceReportViewModel());
    final isDesktop = Responsive.isDesktop(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Branch Sale Return Report"),
      ),
      drawer: !isDesktop
          ? const SizedBox(
              width: 250,
              child: SideMenuWidgetBranch(),
            )
          : null,
      body: Row(
        children: [
          isDesktop ? const Expanded(flex: 2, child: SideMenuWidgetBranch()) : Container(),
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
                                    amount: controller.saleReturnInvoiceList.value.body!.totalQuantity.toString() ?? "0",
                                    imageUrl: TImageUrl.imgProductT,
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Flexible(
                                  child: AppBoxes(
                                    title: "Total Return Amount",
                                    amount: controller.saleReturnInvoiceList.value.body!.totalReturn.toString() ?? "0",
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
                              9: FlexColumnWidth(1),
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
                                    text: 'Salesman',
                                    textColor: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  CustomTableCell(
                                    text: 'Total Amount',
                                    textColor: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  CustomTableCell(
                                    text: 'Subtotal',
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
                            itemCount: controller.saleReturnInvoiceList.value.body!.saleReturn!.length,
                            itemBuilder: (context, index) {
                              final invoice = controller.saleReturnInvoiceList.value.body!.saleReturn![index];
                              String dateTimeString = invoice.createdAt.toString();
                              DateTime dateTime = DateTime.parse(dateTimeString);
                              String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
                              final invoiceData = InvoiceExport(
                                id: invoice.invoiceNumber.toString(),
                                paymentMethod: "",
                                date: DateTime.now(),
                                saleman: Salesman(name: invoice.saleman != null ? invoice.saleman!.name : 'null'),
                                customer: Customer(name: invoice.customer != null ? invoice.customer!.name : 'null'),
                                total: invoice.totalAmount.toString(),
                                items: invoice.returnProducts!.map((product) {
                                  return InvoiceItem(
                                    product: product.product!.name.toString(),
                                    salePrice: product.salePrice.toString(),
                                    qty: int.parse(product.quantity.toString()),
                                    dis: product.discount != null ? "${product.discount}%" : "Null",
                                    subTotal: product.subTotal != null ? product.subTotal.toString() : 'null',
                                    totalAmount: product.totalAmount != null ? product.totalAmount.toString() : "Null",
                                  );
                                }).toList(),
                              );
                              if (controller.search.value.text.isEmpty || invoiceData.customer!.name.toString().toLowerCase().contains(controller.search.value.text.trim().toLowerCase()) || invoice.invoiceNumber.toString().toLowerCase().contains(controller.search.value.text.trim().toLowerCase())) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
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
                                          9: FlexColumnWidth(1),
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
                                                text: invoice.saleman != null ? invoice.saleman!.name.toString() : "Null",
                                                textColor: Colors.black,
                                              ),
                                              CustomTableCell(
                                                text: invoice.totalAmount?.toString() ?? "0",
                                                textColor: Colors.black,
                                              ),
                                              CustomTableCell(
                                                text: invoice.subTotal?.toString() ?? "0",
                                                textColor: Colors.black,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          title: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Text(
                                                                    "Invoice : ${invoice.invoiceNumber != null ? invoice.invoiceNumber.toString() : "Null"}",
                                                                    style: GoogleFonts.lato(
                                                                      fontWeight: FontWeight.w600,
                                                                      fontSize: 14,
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  Text(
                                                                    "Date : $formattedDate",
                                                                    style: GoogleFonts.lato(
                                                                      fontWeight: FontWeight.w600,
                                                                      fontSize: 14,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Text("Salesman : ${invoice.saleman != null ? invoice.saleman!.name.toString() : "Null"}",
                                                                    style:
                                                                    GoogleFonts.lato(fontWeight:
                                                                    FontWeight.w600, fontSize: 14,
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  Text("Customer : ${invoice.customer != null ? invoice.customer!.name.toString() : "Null"}",
                                                                    style: GoogleFonts.lato(
                                                                      fontWeight: FontWeight.w600,
                                                                      fontSize: 14,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          content: Column(
                                                            mainAxisSize: MainAxisSize.min,
                                                            crossAxisAlignment: CrossAxisAlignment.end,
                                                            children: [
                                                              SingleChildScrollView(
                                                                scrollDirection: Axis.horizontal,
                                                                child:
                                                                DataTable(
                                                                  columns: const [
                                                                    DataColumn(
                                                                      label: Text('Product'),
                                                                      numeric: false,
                                                                    ),
                                                                    DataColumn(
                                                                      label: Text('Color'),
                                                                      numeric: false,
                                                                    ),
                                                                    DataColumn(
                                                                      label: Text('Size'),
                                                                      numeric: false,
                                                                    ),
                                                                    DataColumn(
                                                                      label: Text('Quantity'),
                                                                      numeric: true,
                                                                    ),
                                                                    DataColumn(
                                                                      label: Text('Sale Price'),
                                                                      numeric: true,
                                                                    ),
                                                                    DataColumn(
                                                                      label: Text('Sub Total'),
                                                                      numeric: true,
                                                                    ),
                                                                    DataColumn(
                                                                      label: Text('Discount'),
                                                                      numeric: true,
                                                                    ),
                                                                    DataColumn(
                                                                      label: Text('Total Amount'),
                                                                      numeric: true,
                                                                    ),
                                                                  ],
                                                                  rows: invoice.returnProducts != null ? invoice.returnProducts!.map((product) {
                                                                    return DataRow(
                                                                      cells: [
                                                                        DataCell(Text(product.product != null ? product.product!.name.toString() : "Null"),),
                                                                        DataCell(Text(product.color != null ? product.color!.name.toString() : "Null"),),
                                                                        DataCell(Text(product.size != null ? product.size!.number.toString() : "Null"),),
                                                                        DataCell(Text(product.quantity != null ? product.quantity.toString() : "Null")),
                                                                        DataCell(Text(product.product!.salePrice != null ? product.product!.salePrice.toString() : "Null")),
                                                                        DataCell(Text(product.subTotal != null ? product.subTotal.toString() : 'null')),
                                                                        DataCell(Text(product.discount != null ? "${product.discount}%" : "Null",),),
                                                                        DataCell(Text(product.totalAmount != null ? product.totalAmount.toString() : "Null",),),
                                                                      ],
                                                                    );
                                                                  }).toList() : [],
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 30,
                                                              ),
                                                              const Divider(
                                                                color: Colors.grey,
                                                                thickness: 1,
                                                              ),
                                                              Row(
                                                                mainAxisSize: MainAxisSize.min,
                                                                children: [
                                                                  Text("Sub Total",
                                                                    style:
                                                                    GoogleFonts.lato(
                                                                      fontSize: 14,
                                                                      fontWeight: FontWeight.w600,
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 30,
                                                                  ),
                                                                  Text(
                                                                    invoice.subTotal != null ? invoice.subTotal.toString() : "Null",
                                                                    style: GoogleFonts.lato(
                                                                      fontSize: 14,
                                                                      fontWeight: FontWeight.w500,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
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
                                                                  const SizedBox(
                                                                    width: 30,
                                                                  ),
                                                                  Text(
                                                                    invoice.totalAmount != null ? invoice.totalAmount.toString() : "Null",
                                                                    style: GoogleFonts.lato(
                                                                      fontSize: 14,
                                                                      fontWeight: FontWeight.w500,
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
                                                  await generateInvoice(invoiceData);
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
