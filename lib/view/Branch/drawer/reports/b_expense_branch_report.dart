import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/date/response/status.dart';
import 'package:sofi_shoes/res/circularindictor/circularindicator.dart';
import 'package:sofi_shoes/res/slidebar/side_menu_branch.dart';
import 'package:sofi_shoes/res/widget/general_execption_widget.dart';
import 'package:sofi_shoes/view/Branch/drawer/expense/export/expense_export.dart';
import 'package:sofi_shoes/viewmodel/branch/expense/branch_expense.dart';

import '../../../../res/responsive.dart';
import '../../../../res/widget/app_import_button.dart';
import '../widget/expense_branch_table.dart';

class BExpenseBranchReport extends StatefulWidget {
  const BExpenseBranchReport({super.key});

  @override
  State<BExpenseBranchReport> createState() => _BExpenseBranchReportState();
}

class _BExpenseBranchReportState extends State<BExpenseBranchReport> {
  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final size = MediaQuery.sizeOf(context);
    final controller = Get.put(BranchExpenseViewModel());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Branch Expense"),
      ),
      drawer: !isDesktop
          ? const SizedBox(
              width: 250,
              child: SideMenuWidgetBranch(),
            )
          : null,
      body: Row(
        children: [
          isDesktop
              ? const Expanded(flex: 2, child: SideMenuWidgetBranch())
              : Container(),
          Expanded(
            flex: 8,
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AppExportButton(
                          icons: Icons.add,
                          onTap: () {
                            ExpenseExport().printPdf();
                          }),
                    ],
                  ),
                ),
                BranchExpenseWidget(
                  number: "#",
                  name: 'Head Name',
                  accountNumber: 'Amount',
                  balance: 'Date',
                  heading: true,
                ),
                Expanded(
                  child: Obx(
                    () {
                      switch (controller.rxRequestStatus.value) {
                        case Status.LOADING:
                          return const Center(
                              child: CircularIndicator.waveSpinkit);
                        case Status.ERROR:
                          return GeneralExceptionWidget(
                              errorMessage: controller.error.value.toString(),
                              onPress: () {
                                controller.refreshApi();
                              });
                        case Status.COMPLETE:
                          return ListView.builder(
                            itemCount: controller.branchExpenseList.value.body!.branchExpenses!.length,
                            itemBuilder: (context, index) {
                              var branchExpense = controller.branchExpenseList.value.body!.branchExpenses![index];
                              return BranchExpenseWidget(
                                number: "${index + 1}",
                                name: branchExpense.expense!.name.toString(),
                                accountNumber: branchExpense.amount.toString(),
                                balance: branchExpense.date.toString(),
                                heading: false,
                              );
                            },
                          );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
