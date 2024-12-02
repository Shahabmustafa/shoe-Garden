import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/date/response/status.dart';
import 'package:sofi_shoes/res/circularindictor/circularindicator.dart';
import 'package:sofi_shoes/res/widget/not_found/not_found_widget.dart';
import 'package:sofi_shoes/view/Admin/drawer/expense/export/expense_detail_export.dart';
import 'package:sofi_shoes/view/Admin/drawer/expense/widget/expense_detail_table.dart';
import 'package:sofi_shoes/viewmodel/admin/expense/expense_detail_viewmodel.dart';

import '../../../../res/dialog/edit_dialog.dart';
import '../../../../res/responsive.dart';
import '../../../../res/slidebar/side_menu_admin.dart';
import '../../../../res/widget/app_drop_down.dart';
import '../../../../res/widget/app_import_button.dart';
import '../../../../res/widget/general_execption_widget.dart';
import '../../../../res/widget/textfield/app_text_field.dart';

class AExpenseDetailScreen extends StatefulWidget {
  const AExpenseDetailScreen({super.key});

  @override
  State<AExpenseDetailScreen> createState() => _AExpenseDetailScreenState();
}

class _AExpenseDetailScreenState extends State<AExpenseDetailScreen> {
  Future<void> refresh() async {
    Get.put(ExpenseDetailViewModel()).refreshApi();
  }

  @override
  void initState() {
    super.initState();
    Get.put(ExpenseDetailViewModel()).getAllExpenseDetail();
    Get.put(ExpenseDetailViewModel()).fetchHeadName();
  }

  String? selectHead;

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final controller = Get.put(ExpenseDetailViewModel());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Detail"),
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
                          child: AppTextField(
                            controller: controller.search.value,
                            labelText: "Search Head",
                            prefixIcon: const Icon(Icons.search),
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
                  ExpenseDetailTable(
                    number: '#',
                    head: "Head Name",
                    description: "Description",
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
                          var filteredStocks = controller.expenseDetailList.value.body!.generalExpenses!.where((data) {
                            return controller.search.value.text.isEmpty || (data.expense != null && data.expense!.name!.toString().toLowerCase().contains(controller.search.value.text.trim().toLowerCase()));
                          }).toList();
                          return filteredStocks.isEmpty ?
                          NotFoundWidget(title: "Expense Not Found") :
                          ListView.builder(
                            itemCount: controller.expenseDetailList.value.body!.generalExpenses!.length,
                            itemBuilder: (context, index) {
                              var expenseDetail = controller.expenseDetailList.value.body!.generalExpenses![index];
                              var name = expenseDetail.expense?.name ?? "";
                              if (controller.search.value.text.isEmpty || name.toLowerCase().contains(controller.searchValue.value.trim().toLowerCase())) {
                                return ExpenseDetailTable(
                                  number: '${index + 1}',
                                  head: expenseDetail.expense != null ? expenseDetail.expense!.name.toString() : "null",
                                  description: expenseDetail.description ?? "null",
                                  amount: expenseDetail.amount.toString() ?? "null",
                                  date: expenseDetail.date ?? "null",
                                  heading: false,
                                  editOnpress: () {
                                    selectHead = expenseDetail.expense != null
                                        ? expenseDetail.expense!.name.toString()
                                        : "Null";
                                    controller.selectExpenseHead.value =
                                        expenseDetail.expenseId != null
                                            ? expenseDetail.expenseId.toString()
                                            : "Null";
                                    controller.description.value =
                                        TextEditingController(
                                            text: expenseDetail.description);
                                    controller.amount.value =
                                        TextEditingController(
                                            text: expenseDetail.amount
                                                .toString());
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text(
                                              "Update Expense Detail"),
                                          content: SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                AppDropDown(
                                                  labelText:
                                                      "Select Expense Head",
                                                  selectedItem: selectHead,
                                                  items: controller
                                                      .dropdownItems
                                                      .map<String>((item) =>
                                                          item['name']
                                                              .toString())
                                                      .toSet()
                                                      .toList(),
                                                  onChanged:
                                                      (selectedHeadName) {
                                                    var selectedHead =
                                                        controller.dropdownItems
                                                            .firstWhere(
                                                      (head) =>
                                                          head['name']
                                                              .toString() ==
                                                          selectedHeadName,
                                                      orElse: () => null,
                                                    );
                                                    if (selectedHead != null) {
                                                      controller
                                                              .selectExpenseHead
                                                              .value =
                                                          selectedHead['id']
                                                              .toString();
                                                    } else {
                                                      if (kDebugMode) {
                                                        print(kDebugMode);
                                                      }
                                                    }
                                                  },
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                AppTextField(
                                                  controller: controller
                                                      .description.value,
                                                  labelText: "Description",
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                AppTextField(
                                                  controller:
                                                      controller.amount.value,
                                                  labelText: "amount",
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
                                                        .updateExpenseDetail(
                                                            expenseDetail.id
                                                                .toString());
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
                                          reject: () {
                                            Navigator.pop(context);
                                          },
                                          accept: () {
                                            controller.deleteExpenseDetail(
                                                expenseDetail.id.toString());
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
          controller.clearField();
          customShowDialogBox(
            controller,
            'Add Expense Detail',
            'Add',
            () {
              controller.addExpenseDetail();
            },
          );
        },
        label: const Text("Add Expense Detail"),
      ),
    );
  }

  customShowDialogBox(var controller, title, btnName, VoidCallback onpressed) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppDropDown(
                  labelText: "Select Expense Head",
                  items: controller.dropdownItems
                      .map<String>((item) => item['name'].toString())
                      .toSet()
                      .toList(),
                  onChanged: (selectedHeadName) {
                    var selectedHead = controller.dropdownItems.firstWhere(
                      (head) => head['name'].toString() == selectedHeadName,
                      orElse: () => null,
                    );
                    if (selectedHead != null) {
                      controller.selectExpenseHead.value =
                          selectedHead['id'].toString();
                    } else {
                      if (kDebugMode) {
                        print('Expense Head not found');
                      }
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                AppTextField(
                  controller: controller.description.value,
                  labelText: "Description",
                ),
                const SizedBox(
                  height: 10,
                ),
                AppTextField(
                  controller: controller.amount.value,
                  labelText: "amount",
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
                  onPressed: onpressed,
                  child: Text(btnName),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
