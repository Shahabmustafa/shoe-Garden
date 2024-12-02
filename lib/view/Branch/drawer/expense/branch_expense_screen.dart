import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sofi_shoes/date/response/status.dart';
import 'package:sofi_shoes/res/circularindictor/circularindicator.dart';
import 'package:sofi_shoes/res/dialog/edit_dialog.dart';
import 'package:sofi_shoes/res/slidebar/side_menu_branch.dart';
import 'package:sofi_shoes/res/widget/table/six_table.dart';
import 'package:sofi_shoes/view/Branch/drawer/expense/export/expense_export.dart';
import 'package:sofi_shoes/viewmodel/branch/expense/branch_expense.dart';

import '../../../../res/responsive.dart';
import '../../../../res/widget/app_drop_down.dart';
import '../../../../res/widget/app_import_button.dart';
import '../../../../res/widget/general_execption_widget.dart';
import '../../../../res/widget/internet_execption_widget.dart';
import '../../../../res/widget/not_found/not_found_widget.dart';
import '../../../../res/widget/textfield/app_text_field.dart';

class BranchExpensesScreenBranch extends StatefulWidget {
  const BranchExpensesScreenBranch({super.key});

  @override
  State<BranchExpensesScreenBranch> createState() =>
      _BranchExpensesScreenBranchState();
}

class _BranchExpensesScreenBranchState
    extends State<BranchExpensesScreenBranch> {
  Future<void> refreshUserList() async {
    Get.put(BranchExpenseViewModel()).refreshApi();
  }

  @override
  void initState() {
    super.initState();
    Get.put(BranchExpenseViewModel()).getAllExpenseDetail();
  }


  String? selectExpense;

  double totalAmount = 0.0;

  final controller = Get.put(BranchExpenseViewModel());

  void calculateTotalAmount() {
    totalAmount = 0.0;
    if (controller.branchExpenseList.value.body != null) {
      for (var expense
          in controller.branchExpenseList.value.body!.branchExpenses!) {
        double amount =
            double.tryParse(expense.amount.toString() ?? '0') ?? 0.0;
        totalAmount += amount;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final controller = Get.put(BranchExpenseViewModel());
    final size = MediaQuery.sizeOf(context);
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: AppTextField(
                          controller: controller.search.value,
                          labelText: "Search Name",
                          search: true,
                          prefixIcon: Icon(Icons.search),
                          onChanged: (value) {
                            setState(() {
                              controller.searchValue.value = value;
                            });
                          },
                        ),
                      ),
                      Flexible(
                        child: AppExportButton(
                          icons: Icons.add,
                          onTap: () {
                            ExpenseExport().printPdf();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SixTable(
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
                          return const Center(child: CircularIndicator.waveSpinkit);

                        case Status.ERROR:
                          if (controller.error.value == 'No internet') {
                            return InterNetExceptionWidget(
                              onPress: () {
                                controller.refreshApi();
                              },
                            );
                          } else {
                            return GeneralExceptionWidget(onPress: () {
                              controller.refreshApi();
                            });
                          }

                        case Status.COMPLETE:
                        // Retrieve the branch expenses list
                          var branchExpenses = controller.branchExpenseList.value.body!.branchExpenses!;

                          // Filter branch expenses based on the search input
                          var filteredExpenses = branchExpenses.where((expense) {
                            var name = expense.expense!.name!.toLowerCase();
                            return controller.search.value.text.isEmpty ||
                                name.contains(controller.search.value.text.trim().toLowerCase());
                          }).toList();

                          // Check if there are no branch expenses at all
                          if (branchExpenses.isEmpty) {
                            return Center(
                              child: Text(
                                "The Branch Expenses is Empty",
                                style: GoogleFonts.lato(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              ),
                            );
                          }

                          // Check if there are no matching results after filtering
                          if (filteredExpenses.isEmpty) {
                            return NotFoundWidget(title: "Expense Not Found");
                          }

                          // Display the filtered list
                          return ListView.builder(
                            itemCount: filteredExpenses.length,
                            itemBuilder: (context, index) {
                              var branchExpense = filteredExpenses[index];
                              return SixTable(
                                number: "${index + 1}",
                                name: branchExpense.expense!.name.toString(),
                                accountNumber: branchExpense.amount.toString(),
                                balance: branchExpense.date.toString(),
                                editOnpress: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      selectExpense = branchExpense.expense != null ? branchExpense.expense!.name.toString() : "Null";
                                      controller.selectExpenseHead.value = branchExpense.expenseId != null ? branchExpense.expenseId.toString() : "Null";
                                      return AlertDialog(
                                        title: const Text("Update Branch Expenses"),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            AppDropDown(
                                              labelText: "Select Head Name",
                                              selectedItem: selectExpense,
                                              items: controller.expenseHeadDropdownItems.map<String>((item) => item['name'].toString()).toList(),
                                              onChanged: (selectHead) {
                                                var head = controller.expenseHeadDropdownItems.firstWhere(
                                                      (head) => head['name'].toString() == selectHead,
                                                  orElse: () => null,
                                                );
                                                if (head != null) {
                                                  controller.selectExpenseHead.value = head['id'].toString();
                                                } else {
                                                  if (kDebugMode) {
                                                    print('Expense Head not found');
                                                  }
                                                }
                                              },
                                            ),
                                            const SizedBox(height: 20),
                                            AppTextField(
                                              labelText: "Amount",
                                              controller: controller.amount.value,
                                              onlyNumerical: true,
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
                                                child: const Text("Cancel"),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  controller.updateBranchExpense(branchExpense.id.toString());
                                                },
                                                child: const Text("Update"),
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
                                        accept: () {
                                          controller.deleteBranchExpense(branchExpense.id.toString());
                                        },
                                        reject: () {
                                          Navigator.pop(context);
                                        },
                                      );
                                    },
                                  );
                                },
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Add Branch Expenses"),
                content: Column(
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
                    AppTextField(
                      labelText: "Amount",
                      controller: controller.amount.value,
                      onlyNumerical: true,
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
