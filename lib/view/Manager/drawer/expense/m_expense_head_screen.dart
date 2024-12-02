import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/res/circularindictor/circularindicator.dart';
import 'package:sofi_shoes/res/widget/textfield/app_text_field.dart';
import 'package:sofi_shoes/view/Admin/drawer/expense/export/expense_head_export.dart';
import 'package:sofi_shoes/view/Admin/drawer/product/widget/size_table.dart';
import 'package:sofi_shoes/viewmodel/admin/expense/expense_head_viewmodel.dart';

import '../../../../date/response/status.dart';
import '../../../../res/dialog/edit_dialog.dart';
import '../../../../res/responsive.dart';
import '../../../../res/slidebar/side_menu_manager.dart';
import '../../../../res/widget/app_import_button.dart';
import '../../../../res/widget/general_execption_widget.dart';
import '../../../../res/widget/not_found/not_found_widget.dart';

class MExpenseHeadScreen extends StatefulWidget {
  const MExpenseHeadScreen({super.key});

  @override
  State<MExpenseHeadScreen> createState() => _MExpenseHeadScreenState();
}

class _MExpenseHeadScreenState extends State<MExpenseHeadScreen> {
  Future<void> refresh() async {
    Get.put(ExpenseHeadViewModel()).refreshApi();
  }

  @override
  void initState() {
    super.initState();
    Get.put(ExpenseHeadViewModel()).getAllExpenceHead();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final size = MediaQuery.sizeOf(context);
    final controller = Get.put(ExpenseHeadViewModel());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Head"),
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
                  var filteredStocks = controller.expenseList.value.body!.expenses!.where((data) {
                    return controller.search.value.text.isEmpty || (data.name != null && data.name!.toString().toLowerCase().contains(controller.search.value.text.trim().toLowerCase()));
                  }).toList();
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
                                  labelText: "Search Head",
                                  controller: controller.search.value,
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
                                  onTap: () => ExpenseHeadExport().printPdf(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizeTable(
                          number: "#",
                          size: "Head Name",
                          heading: true,
                        ),
                        Expanded(
                          child: filteredStocks.isEmpty ?
                          NotFoundWidget(title: "Head Not Found") :
                          ListView.builder(
                            itemCount: controller.expenseList.value.body!.expenses!.length,
                            itemBuilder: (context, index) {
                              var expence = controller.expenseList.value.body!.expenses![index];
                              if (controller.search.value.text.isEmpty || expence.name!.toLowerCase().contains(controller.searchValue.value.trim().toLowerCase())) {
                                return SizeTable(
                                  number: "${index + 1}",
                                  size: expence.name ?? "null",
                                  heading: false,
                                  editOnpress: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          controller.name.value.clear();
                                          controller.name.value =
                                              TextEditingController(
                                                  text: expence.name);
                                          return AlertDialog(
                                            title:
                                            const Text("Edit Expense Head"),
                                            content: SingleChildScrollView(
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                child: Column(
                                                  mainAxisSize:
                                                  MainAxisSize.min,
                                                  children: [
                                                    Form(
                                                      child: Column(
                                                        children: [
                                                          AppTextField(
                                                            controller:
                                                            controller
                                                                .name.value,
                                                            labelText:
                                                            "Expense Head",
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            actions: [
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceAround,
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
                                                          .updateExpenseHead(
                                                          expence.id
                                                              .toString());
                                                    },
                                                    child: const Text("Update"),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          );
                                        });
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
                                            controller.deleteExpenceHead(
                                                expence.id.toString());
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
                          ),
                        ),
                      ],
                    ),
                  );
              }
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              controller.name.value.clear();
              return AlertDialog(
                title: const Text("Head Name"),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppTextField(
                        labelText: "Head Name",
                        controller: controller.name.value,
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
                          controller.addExpenseHead();
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
        label: const Text("Add Expense Head"),
      ),
    );
  }
}
