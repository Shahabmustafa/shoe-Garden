import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/date/response/status.dart';
import 'package:sofi_shoes/res/circularindictor/circularindicator.dart';

import '../../../../res/dialog/edit_dialog.dart';
import '../../../../res/responsive.dart';
import '../../../../res/slidebar/side_menu_manager.dart';
import '../../../../res/widget/app_drop_down.dart';
import '../../../../res/widget/app_import_button.dart';
import '../../../../res/widget/general_execption_widget.dart';
import '../../../../res/widget/not_found/not_found_widget.dart';
import '../../../../res/widget/textfield/app_text_field.dart';
import '../../../../viewmodel/admin/expense/all_expense_branch_viewmodel.dart';
import '../../../Admin/drawer/expense/widget/branch_expense_table.dart';
import 'export/branch_expense_export.dart';

class MAllBranchExpensesScreen extends StatefulWidget {
  const MAllBranchExpensesScreen({super.key});

  @override
  State<MAllBranchExpensesScreen> createState() =>
      _MAllBranchExpensesScreenState();
}

class _MAllBranchExpensesScreenState extends State<MAllBranchExpensesScreen> {
  Future<void> refresh() async {
    Get.put(AllBranchExpenseViewModel()).refreshApi();
  }

  String? selectExpense;
  String? selectBranch;
  String? selectAmount;

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final size = MediaQuery.sizeOf(context);
    final controller = Get.put(AllBranchExpenseViewModel());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Branch Expense"),
      ),
      drawer: !isDesktop
          ? const SizedBox(
              width: 250,
              child: SideMenuWidgetManager(),
            )
          : null,
      body: Row(
        children: [
          isDesktop
              ? const Expanded(flex: 2, child: SideMenuWidgetManager())
              : Container(),
          Expanded(
            flex: 8,
            child: RefreshIndicator(
              onRefresh: refresh,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Obx(
                                () => AppDropDown(
                              labelText: "Select Branch",
                              items: controller.branchDropdownItems
                                  .map<String>(
                                      (item) => item['name'].toString())
                                  .toList(),
                              onChanged: (selectBrand) {
                                setState(() {});
                                var branch =
                                controller.branchDropdownItems.firstWhere(
                                      (head) =>
                                  head['name'].toString() == selectBrand,
                                  orElse: () => null,
                                );
                                if (branch != null) {
                                  controller.selectBranch.value = branch['id'].toString();
                                } else {
                                  if (kDebugMode) {
                                    print('Branch not found');
                                  }
                                }
                              },
                            ),
                          ),
                        ),
                        Flexible(
                          child: AppExportButton(
                            icons: Icons.add,
                            onTap: () => BranchExpenseExport().printPdf(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  BranchExpenseTable(
                    number: "#",
                    head: "Head",
                    branch: "Branch",
                    amount: "Amount",
                    date: "Date",
                    heading: true,
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
                                controller.refreshApi();
                              });
                        case Status.COMPLETE:
                          var filteredStocks = controller.branchExpenseList.value.body!.branchExpenses!.where((data) {
                            return controller.selectBranch.value.isEmpty || (data.branch != null && data.branch!.id!.toString().toLowerCase().contains(controller.selectBranch.value.trim().toLowerCase()));
                          }).toList();
                          return filteredStocks.isEmpty ?
                          NotFoundWidget(title: "Branch Not Found") :
                          ListView.builder(
                            itemCount: controller.branchExpenseList.value.body!.branchExpenses!.length,
                            itemBuilder: (context, index) {
                              var branchExpense = controller.branchExpenseList.value.body!.branchExpenses![index];
                              if (controller.selectBranch.value.isEmpty ||
                                  branchExpense.branchId!.toString().toLowerCase().contains(controller.selectBranch.value.toLowerCase())) {
                                return BranchExpenseTable(
                                  number: "${index + 1}",
                                  head: branchExpense.expense != null ? branchExpense.expense!.name.toString() : "null",
                                  amount: branchExpense.amount.toString() ?? "null",
                                  branch: branchExpense.branch != null ? branchExpense.branch!.name.toString() : "null",
                                  date: branchExpense.date ?? "",
                                  editOnpress: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        selectExpense =
                                        branchExpense.expense != null
                                            ? branchExpense.expense!.name
                                            .toString()
                                            : "Null";
                                        selectBranch =
                                        branchExpense.branch != null
                                            ? branchExpense.branch!.name
                                            .toString()
                                            : "Null";
                                        controller.amount.value =
                                            TextEditingController(
                                                text: branchExpense.amount
                                                    .toString());
                                        controller.selectExpenseHead.value =
                                        branchExpense.expenseId != null
                                            ? branchExpense.expenseId
                                            .toString()
                                            : "Null";
                                        controller.selectBranch.value =
                                        branchExpense.branchId != null
                                            ? branchExpense.branchId
                                            .toString()
                                            : "Null";
                                        return AlertDialog(
                                          title: const Text(
                                              "Update Branch Expenses"),
                                          content: SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                AppDropDown(
                                                  labelText: "Select Head Name",
                                                  selectedItem: selectExpense,
                                                  items: controller
                                                      .expenseHeadDropdownItems
                                                      .map<String>((item) =>
                                                      item['name']
                                                          .toString())
                                                      .toSet()
                                                      .toList(),
                                                  onChanged: (selectHead) {
                                                    var head = controller
                                                        .expenseHeadDropdownItems
                                                        .firstWhere(
                                                          (head) =>
                                                      head['name']
                                                          .toString() ==
                                                          selectHead,
                                                      orElse: () => null,
                                                    );
                                                    if (head != null) {
                                                      controller
                                                          .selectExpenseHead
                                                          .value =
                                                          head['id'].toString();
                                                    } else {
                                                      if (kDebugMode) {
                                                        print(
                                                            'Expense Head not found');
                                                      }
                                                    }
                                                  },
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                AppDropDown(
                                                  labelText: "Select Branch",
                                                  selectedItem: selectBranch,
                                                  items: controller
                                                      .branchDropdownItems
                                                      .map<String>((item) =>
                                                      item['name']
                                                          .toString())
                                                      .toSet()
                                                      .toList(),
                                                  onChanged: (selectBrand) {
                                                    var branch = controller
                                                        .branchDropdownItems
                                                        .firstWhere(
                                                          (head) =>
                                                      head['name']
                                                          .toString() ==
                                                          selectBrand,
                                                      orElse: () => null,
                                                    );
                                                    if (branch != null) {
                                                      controller.selectBranch
                                                          .value =
                                                          branch['id']
                                                              .toString();
                                                    } else {
                                                      if (kDebugMode) {
                                                        print(
                                                            'Branch not found');
                                                      }
                                                    }
                                                  },
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                AppTextField(
                                                  labelText: "Amount",
                                                  controller:
                                                  controller.amount.value,
                                                  onlyNumerical: true,
                                                ),
                                              ],
                                            ),
                                          ),
                                          actions: [
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                              children: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text("Cancel"),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    controller
                                                        .updateBranchExpense(
                                                        branchExpense.id
                                                            .toString());
                                                  },
                                                  child: const Text("update"),
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  deleteOnpress: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return EditDialog(
                                          reject: () {
                                            Navigator.pop(context);
                                          },
                                          accept: () {
                                            controller.deleteBranchExpense(
                                                branchExpense.id.toString());
                                          },
                                        );
                                      },
                                    );
                                  },
                                );
                              } else {
                                return Container();
                              }
                            },
                          );
                      }
                    }),
                  ),
                ],
              ),
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
                title: const Text("Add Branch Expenses"),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppDropDown(
                        labelText: "Select Head Name",
                        items: controller.expenseHeadDropdownItems
                            .map<String>((item) => item['name'].toString())
                            .toList(),
                        onChanged: (selectHead) {
                          var head =
                              controller.expenseHeadDropdownItems.firstWhere(
                            (head) => head['name'].toString() == selectHead,
                            orElse: () => null,
                          );
                          if (head != null) {
                            controller.selectExpenseHead.value =
                                head['id'].toString();
                          } else {
                            if (kDebugMode) {
                              print('Expense Head not found');
                            }
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AppDropDown(
                        labelText: "Select Branch",
                        items: controller.branchDropdownItems
                            .map<String>((item) => item['name'].toString())
                            .toList(),
                        onChanged: (selectBrand) {
                          var branch =
                              controller.branchDropdownItems.firstWhere(
                            (head) => head['name'].toString() == selectBrand,
                            orElse: () => null,
                          );
                          if (branch != null) {
                            controller.selectBranch.value =
                                branch['id'].toString();
                          } else {
                            if (kDebugMode) {
                              print('Branch not found');
                            }
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AppTextField(
                        labelText: "Amount",
                        controller: controller.amount.value,
                        onlyNumerical: true,
                      ),
                    ],
                  ),
                ),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          controller.addBranchExpense();
                        },
                        child: const Text("Add"),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        },
        label: const Text("Add Branch Expenses"),
      ),
    );
  }
}
