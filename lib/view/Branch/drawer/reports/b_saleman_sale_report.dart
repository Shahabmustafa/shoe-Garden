import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sofi_shoes/date/response/status.dart';
import 'package:sofi_shoes/res/circularindictor/circularindicator.dart';
import 'package:sofi_shoes/res/color/app_color.dart';
import 'package:sofi_shoes/res/responsive.dart';
import 'package:sofi_shoes/res/slidebar/side_menu_branch.dart';
import 'package:sofi_shoes/res/widget/general_execption_widget.dart';

import '../../../../res/tabletext/table_text.dart';
import '../../../../res/widget/app_drop_down.dart';
import '../../../../res/widget/date_time_picker.dart';
import '../../../../viewmodel/branch/report/salesman_report_viewmodel.dart';

class BSalesmanSaleReport extends StatefulWidget {
  const BSalesmanSaleReport({super.key});

  @override
  State<BSalesmanSaleReport> createState() => _BSalesmanSaleReportState();
}

class _BSalesmanSaleReportState extends State<BSalesmanSaleReport> {
  @override
  void initState() {
    super.initState();
    Get.put(SalesmanReportViewmodel()).getSalesmanSaleReport();
  }
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final controller = Get.put(SalesmanReportViewmodel());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Salman Sale Report"),
      ),
      drawer: !isDesktop ? const SizedBox(width: 250, child: SideMenuWidgetBranch(),) : null,
      body: Row(
        children: [
          isDesktop ? const Expanded(flex: 2, child: SideMenuWidgetBranch()) : Container(),
          Expanded(
            flex: 8,
            child: Column(
              children: [
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: DateTimePicker(
                          hintText: 'From Date',
                          onTap: () {
                            controller.salesmanSaleReportSelectDate(context, true);
                          },
                          controller: controller.startDate.value,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: DateTimePicker(
                          hintText: 'To Date',
                          onTap: () {
                            controller.salesmanSaleReportSelectDate(context, false);
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
                        child: Obx(() {
                          return AppDropDown(
                            labelText: "Select Salesman",
                            items: controller.salesmanDropdown.map<String>((item) => item['name'].toString()).toSet().toList(),
                            onChanged: (branchName) {
                              var selectbranch = controller.salesmanDropdown.firstWhere((items) => items['name'].toString() == branchName, orElse: () => null,);
                              if (selectbranch != null) {
                                controller.selectSalesman.value = selectbranch['id'].toString();
                                controller.salesmanSaleReportRefresh();
                              }
                            },
                          );
                        }),
                      ),
                      ElevatedButton(
                        onPressed: (){
                          controller.salesmanSaleReportRefresh();
                        },
                        child: Text("Clear"),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Obx(() {
                    switch (controller.rxRequestStatus.value) {
                      case Status.LOADING:
                        return const Center(child: CircularIndicator.waveSpinkit);
                      case Status.ERROR:
                        return GeneralExceptionWidget(
                          errorMessage: controller.error.value.toString(),
                          onPress: () {
                            controller.salesmanSaleReportRefresh();
                          },
                        );
                      case Status.COMPLETE:
                        return ListView.builder(
                          itemCount: controller.salesmanReportList.value.body?.invoices?.length ?? 00,
                          itemBuilder: (context, index) {
                            var data = controller.salesmanReportList.value.body?.invoices?[index];
                            DateTime dateTime = DateTime.parse(data!.createdAt.toString());
                            DateFormat formatter = DateFormat('dd-MM-yyyy hh:mm a');
                            String formattedDate = formatter.format(dateTime.toLocal());
                            return Padding(
                              padding: const EdgeInsets.all(5),
                              child: Card(
                                elevation: 5,
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Invoice No : ${data.invoiceNumber?.toString() ?? "0"}",style: GoogleFonts.lato(fontSize: 14, fontWeight: FontWeight.bold)),
                                          Text("Salesman : ${data.saleman?.name?.toString() ?? "null"}",style: GoogleFonts.lato(fontSize: 14, fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Date : ${formattedDate}",style: GoogleFonts.lato(fontSize: 14, fontWeight: FontWeight.bold)),
                                          Text("Branch : ${data.branch?.name.toString() ?? ""}",style: GoogleFonts.lato(fontSize: 14, fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: DataTable(
                                          columnSpacing: 75,
                                          headingRowHeight: 40,
                                          headingRowColor: MaterialStateProperty.all<Color>(Colors.grey.shade200),
                                          headingTextStyle: GoogleFonts.lato(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                          columns: [
                                            DataColumn(label: Text('#',)),
                                            DataColumn(label: Text('Product',)),
                                            DataColumn(label: Text('Color',)),
                                            DataColumn(label: Text('Size', )),
                                            DataColumn(label: Text('Quantity', )),
                                            DataColumn(label: Text('Sale Price', )),
                                            DataColumn(label: Text('Sub Total')),
                                            DataColumn(label: Text('Discount', )),
                                            DataColumn(label: Text('Total Amount')),
                                          ],
                                          rows: data.invoiceProducts != null ?
                                          List<DataRow>.generate(data.invoiceProducts?.length ?? 0, (i) {
                                            var product = data.invoiceProducts![i];
                                            return DataRow(
                                              cells: [
                                                DataCell(Text("${i + 1}")),
                                                DataCell(Text(product.product?.name ?? "Null")),
                                                DataCell(Text(product.color?.name ?? "Null")),
                                                DataCell(Text(product.size?.number.toString() ?? "Null")),
                                                DataCell(Text(product.quantity?.toString() ?? "Null")),
                                                DataCell(Text(product.product?.salePrice.toString() ?? "Null")),
                                                DataCell(Text(product.subTotal?.toString() ?? '0')),
                                                DataCell(Text(product.discount.toString() ?? "0")),
                                                DataCell(Text(product.totalAmount?.toString() ?? "0")),
                                              ],
                                            );
                                          }).toList() : [],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      SizedBox(
                                        width: double.infinity,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text("Sub Total : ${data.subTotal?.toString() ?? "0"}",style: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.bold)),
                                            SizedBox(height: 10,),
                                            Text("Total Amount : ${data.totalAmount?.toString() ?? "0"}",style: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.bold)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                    }
                  }),
                ),
                Obx((){
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Table(
                      columnWidths: const {
                        0: FlexColumnWidth(2),
                        1: FlexColumnWidth(1),
                        2: FlexColumnWidth(2),
                        3: FlexColumnWidth(1),

                      },
                      border: TableBorder.all(
                        color: Colors.grey.shade300,
                      ),
                      defaultColumnWidth: const FlexColumnWidth(0.5),
                      children: [
                        TableRow(
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          children: [
                            CustomTableCell(
                              text: 'Total Sale',
                              textColor: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            CustomTableCell(
                              text: controller.salesmanReportList.value.body?.totalSale.toString() ?? "0",
                              textColor: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            CustomTableCell(
                              text: 'Total Quantity',
                              textColor: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            CustomTableCell(
                              text: controller.salesmanReportList.value.body?.totalQty.toString() ?? "0",
                              textColor: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
