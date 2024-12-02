import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/res/circularindictor/circularindicator.dart';
import 'package:sofi_shoes/res/widget/not_found/not_found_widget.dart';
import 'package:sofi_shoes/view/Admin/drawer/bank/export/bank_head_export.dart';
import 'package:sofi_shoes/view/Admin/drawer/bank/widget/bank_head_table.dart';
import 'package:sofi_shoes/viewmodel/admin/bank/bank_head_viewmodel.dart';

import '../../../../date/response/status.dart';
import '../../../../res/dialog/edit_dialog.dart';
import '../../../../res/responsive.dart';
import '../../../../res/slidebar/side_menu_admin.dart';
import '../../../../res/widget/app_import_button.dart';
import '../../../../res/widget/general_execption_widget.dart';
import '../../../../res/widget/textfield/app_text_field.dart';

class ABankHeadScreen extends StatefulWidget {
  const ABankHeadScreen({super.key});

  @override
  State<ABankHeadScreen> createState() => _ABankHeadScreenState();
}

class _ABankHeadScreenState extends State<ABankHeadScreen> {
  Future<void> refreshBank() async {
    Get.put(BankHeadViewModel()).refreshApi();
  }

  @override
  void initState() {
    super.initState();
    Get.put(BankHeadViewModel()).getAllBank();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BankHeadViewModel());
    final isDesktop = Responsive.isDesktop(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bank Head"),
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
                    var filteredCustomers = controller.bankHeadList.value.body!.bankHeads!.where((bankName) {
                      var name = bankName.name.toString().toLowerCase();
                      return controller.search.value.text.isEmpty || name.contains(controller.search.value.text.trim().toLowerCase());
                    }).toList();
                    return RefreshIndicator(
                      onRefresh: refreshBank,
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
                                    search: true,
                                    prefixIcon: const Icon(Icons.search),
                                    onChanged: (value) {
                                      setState(() {});
                                      controller.searchValue.value = value;
                                    },
                                  ),
                                ),
                                Flexible(
                                  child: AppExportButton(
                                    icons: Icons.add,
                                    onTap: () => BankHeadExport().printPdf(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          BankHeadTable(
                            number: "#",
                            bankHead: "Bank Head",
                            accountNumber: "Account Number",
                            balance: "Balance",
                            heading: true,
                          ),
                          Expanded(
                            child: filteredCustomers.isEmpty ?
                            NotFoundWidget(title: "Bank Head Not Found") :
                            ListView.builder(
                              itemCount: controller.bankHeadList.value.body!.bankHeads!.length,
                              itemBuilder: (context, index) {
                                var bank = controller.bankHeadList.value.body!.bankHeads![index];
                                var name = bank.name.toString();
                                if (controller.search.value.text.isEmpty || name.toLowerCase().contains(controller.search.value.text.trim().toLowerCase())) {
                                  return BankHeadTable(
                                    number: "${index + 1}",
                                    bankHead: bank.name != null ? bank.name.toString() : 'null',
                                    accountNumber: bank.accountNumber != null ? bank.accountNumber.toString() : 'null',
                                    balance:  bank.balance != null ? bank.balance.toString() : "null",
                                    heading: false,
                                    editOnpress: () {
                                      controller.clear();
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          controller.name.value =
                                              TextEditingController(
                                                  text: bank.name);
                                          controller.accountNo.value =
                                              TextEditingController(
                                                  text: bank.accountNumber);
                                          controller.balance.value =
                                              TextEditingController(
                                                  text:
                                                  bank.balance.toString());
                                          return AlertDialog(
                                            title: const Text("Edit Bank Head"),
                                            content: SingleChildScrollView(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Form(
                                                      child: Column(
                                                        children: [
                                                          AppTextField(
                                                            controller: controller
                                                                .name.value,
                                                            labelText: "Name",
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          AppTextField(
                                                            controller: controller
                                                                .accountNo.value,
                                                            labelText:
                                                            "Account Number",
                                                            onlyNumerical: true,
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          AppTextField(
                                                            controller: controller
                                                                .balance.value,
                                                            labelText: "Balance",
                                                            onlyNumerical: true,
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                        ],
                                                      ))
                                                ],
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
                                                      controller.updateBankHead(
                                                          bank.id.toString());
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
                                                controller.deleteBankHead(
                                                    bank.id.toString());
                                              },
                                            );
                                          });
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
              })),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              controller.clear();
              return AlertDialog(
                title: const Text("Add Bank Head"),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: AppTextField(
                          controller: controller.name.value,
                          labelText: "Name",
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Flexible(
                        child: AppTextField(
                          controller: controller.accountNo.value,
                          labelText: "Account Number",
                          onlyNumerical: true,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Flexible(
                        child: AppTextField(
                          controller: controller.balance.value,
                          labelText: "Account Balance",
                          onlyNumerical: true,
                        ),
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
                          controller.addBankHead();
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
        label: const Text("Add Bank Head"),
      ),
    );
  }
}
