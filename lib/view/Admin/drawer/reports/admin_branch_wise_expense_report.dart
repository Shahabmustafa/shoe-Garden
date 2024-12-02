import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/date/response/status.dart';
import 'package:sofi_shoes/res/circularindictor/circularindicator.dart';
import 'package:sofi_shoes/res/responsive.dart';
import 'package:sofi_shoes/res/slidebar/side_menu_admin.dart';
import 'package:sofi_shoes/res/widget/app_import_button.dart';
import 'package:sofi_shoes/res/widget/general_execption_widget.dart';
import 'package:sofi_shoes/res/widget/textfield/app_text_field.dart';
import 'package:sofi_shoes/view/Admin/drawer/expense/export/branch_expense_export.dart';
import 'package:sofi_shoes/view/Admin/drawer/reports/widget/expense_detail_table.dart';
import 'package:sofi_shoes/viewmodel/admin/expense/all_expense_branch_viewmodel.dart';

class AdminBranchExpenseReport extends StatefulWidget {
  const AdminBranchExpenseReport({super.key});

  @override
  State<AdminBranchExpenseReport> createState() =>
      _AdminBranchExpenseReportState();
}

class _AdminBranchExpenseReportState extends State<AdminBranchExpenseReport> {
  Future<void> refresh() async {
    Get.put(AllBranchExpenseViewModel()).refreshApi();
  }

  @override
  void initState() {
    super.initState();
    Get.put(AllBranchExpenseViewModel()).getAllExpenseDetail();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllBranchExpenseViewModel());
    final isDesktop = Responsive.isDesktop(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Branch Expense Report"),
      ),
      drawer: !isDesktop
          ? const SizedBox(
              width: 250,
              child: SideMenuWidgetAdmin(),
            )
          : null,
      body: Row(
        children: [
          isDesktop
              ? const Expanded(flex: 2, child: SideMenuWidgetAdmin())
              : Container(),
          Expanded(
            flex: 8,
            child: Obx(
              () {
                switch (controller.rxRequestStatus.value) {
                  case Status.LOADING:
                    return const Center(child: CircularIndicator.waveSpinkit);
                  case Status.ERROR:
                    return GeneralExceptionWidget(
                      errorMessage: controller.error.value.toString(),
                      onPress: () {
                        controller.refreshApi();
                      },
                    );
                  case Status.COMPLETE:
                    return RefreshIndicator(
                      onRefresh: refresh,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
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
                                    onTap: () =>
                                        BranchExpenseExport().printPdf(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ExpenseDetailReportTable(
                            number: '#',
                            head: "Head Name",
                            description: "Branch",
                            amount: "Amount",
                            date: "Date",
                            heading: true,
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: controller.branchExpenseList.value
                                  .body!.branchExpenses!.length,
                              itemBuilder: (context, index) {
                                var expenseDetail = controller.branchExpenseList
                                    .value.body!.branchExpenses![index];
                                var name =
                                    expenseDetail.expense!.name.toString();
                                if (controller.search.value.text.isEmpty ||
                                    name.toLowerCase().contains(controller
                                        .search.value.text
                                        .trim()
                                        .toLowerCase())) {
                                  return ExpenseDetailReportTable(
                                    number: "${index + 1}",
                                    head: expenseDetail.expense != null
                                        ? expenseDetail.expense!.name.toString()
                                        : "null",
                                    description: expenseDetail.branch != null
                                        ? expenseDetail.branch!.name.toString()
                                        : "null",
                                    amount: expenseDetail.amount.toString() ??
                                        "null",
                                    date: expenseDetail.date.toString(),
                                    heading: false,
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
              },
            ),
          ),
        ],
      ),
    );
  }
}
