import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/res/widget/app_import_button.dart';
import 'package:sofi_shoes/view/Branch/drawer/reports/export/cash_counter_export.dart';
import 'package:sofi_shoes/viewmodel/branch/report/sale_expense_gross_viewmodel.dart';

import '../../../../date/response/status.dart';
import '../../../../res/circularindictor/circularindicator.dart';
import '../../../../res/responsive.dart';
import '../../../../res/slidebar/side_menu_branch.dart';
import '../../../../res/tabletext/table_text.dart';
import '../../../../res/widget/date_time_picker.dart';
import '../../../../res/widget/general_execption_widget.dart';
import '../../../../res/widget/textfield/app_text_field.dart';

class BSaleExpenseGrossReport extends StatefulWidget {
  const BSaleExpenseGrossReport({super.key});

  @override
  State<BSaleExpenseGrossReport> createState() =>
      _BSaleExpenseGrossReportState();
}

class _BSaleExpenseGrossReportState extends State<BSaleExpenseGrossReport> {
  final controller = Get.put(SaleExpenseGrossViewmodel());

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cash Counter"),
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
            child: Column(
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
                      const SizedBox(width: 10),
                      Expanded(
                        child: DateTimePicker(
                          hintText: 'To Date',
                          onTap: () {
                            controller.selectDate(context, false);
                          },
                          controller: controller.endDate.value,
                        ),
                      ),
                      const SizedBox(width: 10),
                      AppExportButton(
                        icons: Icons.add,
                        onTap: (){
                          CashCounterExport().printPdf();
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Table(
                    columnWidths: const {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(2),
                      2: FlexColumnWidth(2),
                      3: FlexColumnWidth(2),
                      4: FlexColumnWidth(2),
                      5: FlexColumnWidth(2),
                      6: FlexColumnWidth(2),
                      7: FlexColumnWidth(3),
                      8: FlexColumnWidth(2),
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
                            text: 'Date',
                            textColor: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          CustomTableCell(
                            text: 'Cash Sale',
                            textColor: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          CustomTableCell(
                            text: 'Credit Sale',
                            textColor: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          CustomTableCell(
                            text: 'Total Sale',
                            textColor: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          CustomTableCell(
                            text: 'Total Expense',
                            textColor: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          CustomTableCell(
                            text: 'Gross',
                            textColor: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          CustomTableCell(
                            text: 'Cash Paid to Admin',
                            textColor: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          CustomTableCell(
                            text: 'Difference',
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
                          itemCount: controller.BSaleExpenseGrossList.value.body!.length,
                          itemBuilder: (context, index) {
                            var data = controller.BSaleExpenseGrossList.value.body![index];
                            print("Date: ${data.date}, Sale: ${data.sale}, Expense: ${data.expense}");
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2.5),
                              child: Table(
                                columnWidths: const {
                                  0: FlexColumnWidth(1),
                                  1: FlexColumnWidth(2),
                                  2: FlexColumnWidth(2),
                                  3: FlexColumnWidth(2),
                                  4: FlexColumnWidth(2),
                                  5: FlexColumnWidth(2),
                                  6: FlexColumnWidth(2),
                                  7: FlexColumnWidth(3),
                                  8: FlexColumnWidth(2),
                                },
                                border: TableBorder.all(
                                  color: Colors.grey.shade200,
                                ),
                                defaultColumnWidth: const FlexColumnWidth(0.5),
                                children: [
                                  TableRow(
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    children: [
                                      CustomTableCell(
                                        text: '${index + 1}',
                                        textColor: Colors.black,
                                      ),
                                      CustomTableCell(
                                        text: data.date,
                                        textColor: Colors.black,
                                      ),
                                      CustomTableCell(
                                        text: data.cashSale.toString(),
                                        textColor: Colors.black,
                                      ),
                                      CustomTableCell(
                                        text: data.cardPayment.toString(),
                                        textColor: Colors.black,
                                      ),
                                      CustomTableCell(
                                        text: data.sale.toString(),
                                        textColor: Colors.black,
                                      ),
                                      CustomTableCell(
                                        text: data.expense.toString(),
                                        textColor: Colors.black,
                                      ),
                                      CustomTableCell(
                                        text: data.gross.toString(),
                                        textColor: Colors.black,
                                      ),
                                      CustomTableCell(
                                        text: data.cashPaidToAdmin.toString(),
                                        textColor: Colors.black,
                                      ),
                                      CustomTableCell(
                                        text: data.difference.toString(),
                                        textColor: Colors.black,
                                      ),
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
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Cash Paid To Admin"),
                content: Row(
                  children: [
                    AppTextField(
                      controller: controller.cashAmount.value,
                      labelText: "Assign Amount",
                    ),
                  ],
                ),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Cancel"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          controller.addCashAssignToAdmin();
                        },
                        child: Text("Add"),
                      )
                    ],
                  ),
                ],
              );
            },
          );
        },
        label: Text("Cash Paid To Admin"),
      ),
    );
  }
}