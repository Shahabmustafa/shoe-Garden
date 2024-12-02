import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/date/response/status.dart';
import 'package:sofi_shoes/res/circularindictor/circularindicator.dart';
import 'package:sofi_shoes/res/responsive.dart';
import 'package:sofi_shoes/res/slidebar/side_menu_admin.dart';
import 'package:sofi_shoes/res/widget/app_import_button.dart';
import 'package:sofi_shoes/res/widget/general_execption_widget.dart';
import 'package:sofi_shoes/res/widget/textfield/app_text_field.dart';
import 'package:sofi_shoes/view/Admin/drawer/expense/export/expense_detail_export.dart';
import 'package:sofi_shoes/view/Admin/drawer/reports/widget/expense_detail_table.dart';
import 'package:sofi_shoes/viewmodel/admin/expense/expense_detail_viewmodel.dart';

class AdminExpenseDetailReport extends StatefulWidget {
  const AdminExpenseDetailReport({super.key});

  @override
  State<AdminExpenseDetailReport> createState() =>
      _AdminExpenseDetailReportState();
}

class _AdminExpenseDetailReportState extends State<AdminExpenseDetailReport> {
  Future<void> refreshCustomerList() async {
    Get.put(ExpenseDetailViewModel()).refreshApi();
  }

  @override
  void initState() {
    super.initState();
    Get.put(ExpenseDetailViewModel()).getAllExpenseDetail();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ExpenseDetailViewModel());
    final isDesktop = Responsive.isDesktop(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Detail Report"),
      ),
      drawer: !isDesktop ? const SizedBox(width: 250, child: SideMenuWidgetAdmin(),) : null,
      body: Row(
        children: [
          isDesktop ? const Expanded(flex: 2, child: SideMenuWidgetAdmin()) : Container(),
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
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: AppTextField(
                                  controller: controller.search.value,
                                  labelText: "Search Head",
                                  prefixIcon: Icon(Icons.search),
                                  search: true,
                                  onChanged: (value) {
                                    setState(() {});
                                    controller.searchValue.value = value;
                                  },
                                ),
                              ),
                              Flexible(
                                child: AppExportButton(
                                  icons: Icons.add,
                                  onTap: () => ExpenseDetailExport().printPdf(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ExpenseDetailReportTable(
                          number: '#',
                          head: "Head Name",
                          description: "Description",
                          amount: "Amount",
                          date: "Date",
                          heading: true,
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: controller.expenseDetailList.value.body!.generalExpenses!.length,
                            itemBuilder: (context, index) {
                              var expenseDetail = controller.expenseDetailList.value.body!.generalExpenses![index];
                              var name = expenseDetail.expense != null ? expenseDetail.expense!.name : "Null";
                              if (controller.search.value.text.isEmpty || name!.toLowerCase().contains(controller.search.value.text.trim().toLowerCase())) {
                                return ExpenseDetailReportTable(
                                  number: "${index + 1}",
                                  head: expenseDetail.expense != null ? expenseDetail.expense!.name.toString() : "Null",
                                  description: expenseDetail.description != null ? expenseDetail.description.toString() : 'Null',
                                  amount: expenseDetail.amount != null ? expenseDetail.amount.toString() : "Null",
                                  date: expenseDetail.date != null ? expenseDetail.date.toString() : "",
                                  heading: false,
                                );
                              } else {
                                return Container();
                              }
                            },
                          ),
                        ),
                      ],
                    );
                }
              })),
        ],
      ),
    );
  }
}
