import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/res/circularindictor/circularindicator.dart';
import 'package:sofi_shoes/res/widget/not_found/not_found_widget.dart';
import 'package:sofi_shoes/res/widget/view_text.dart';
import 'package:sofi_shoes/view/Admin/drawer/bank/export/bank_entry_export.dart';
import 'package:sofi_shoes/view/Admin/drawer/customer/widget/customer_company_table.dart';
import 'package:sofi_shoes/viewmodel/admin/bank/bank_entry_viewmodel.dart';

import '../../../../date/response/status.dart';
import '../../../../res/dialog/edit_dialog.dart';
import '../../../../res/imageurl/image.dart';
import '../../../../res/responsive.dart';
import '../../../../res/slidebar/side_menu_admin.dart';
import '../../../../res/widget/app_boxes.dart';
import '../../../../res/widget/app_drop_down.dart';
import '../../../../res/widget/app_import_button.dart';
import '../../../../res/widget/general_execption_widget.dart';
import '../../../../res/widget/textfield/app_text_field.dart';

class ABankEntryScreen extends StatefulWidget {
  const ABankEntryScreen({super.key});

  @override
  State<ABankEntryScreen> createState() => _ABankEntryScreenState();
}

class _ABankEntryScreenState extends State<ABankEntryScreen> {
  Future<void> refreshBank() async {
    Get.put(BankEntryViewModel()).refreshApi();
  }

  @override
  void initState() {
    super.initState();
    Get.put(BankEntryViewModel()).getAllBankEntry();

    Get.put(BankEntryViewModel()).fetchBankName();
  }

  String? selectBank;
  String? selectType;

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final controller = Get.put(BankEntryViewModel());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bank Entry"),
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
                    var filteredCustomers = controller.bankEntryList.value.body!.bankEnteries!.where((bankName) {
                      var name = bankName.bankHead!.name.toString().toLowerCase();
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
                                    labelText: "Search Bank",
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
                                    onTap: () => BankEntryExport().printPdf(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                AppBoxes(
                                  imageUrl: TImageUrl.imgSale,
                                  title: "Total Balance",
                                  amount: controller.bankEntryList.value.body!.totalBalnce.toString(),
                                  height: MediaQuery.sizeOf(context).height * 0.1,
                                  width: MediaQuery.sizeOf(context).width * 0.4,
                                ),
                              ],
                            ),
                          ),
                          TableRowWidget(
                            number: "#",
                            one: "Bank Name",
                            two: "Type",
                            three: "Description",
                            // deposite: "Deposit",
                            // withdraw: "Withdraw",
                            // date: "Date",
                            heading: true,
                          ),
                          Expanded(
                            child: filteredCustomers.isEmpty ?
                            NotFoundWidget(title: "Bank Head Not Found") :
                            ListView.builder(
                              itemCount: controller.bankEntryList.value.body!.bankEnteries!.length,
                              itemBuilder: (context, index) {
                                var bank = controller.bankEntryList.value.body!.bankEnteries![index];
                                var name = bank.bankHead != null ? bank.bankHead!.name.toString() : '';
                                if (controller.search.value.text.isEmpty || name.toLowerCase().contains(controller.search.value.text.trim().toLowerCase())) {
                                  return TableRowWidget(
                                    number: "${index + 1}",
                                    one: bank.bankHead != null ? bank.bankHead!.name.toString() : 'null',
                                    two: bank.type == '0' ? 'Cash' : 'Online',
                                    three: bank.description != null ? bank.description.toString() : "null",
                                    heading: false,
                                    editOnpress: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          controller.description.value =
                                              TextEditingController(
                                                  text: bank.description);
                                          controller.desposit.value =
                                              TextEditingController(
                                                  text:
                                                      bank.deposit.toString());
                                          controller.withdraw.value =
                                              TextEditingController(
                                                  text:
                                                      bank.withdraw.toString());
                                          selectBank = bank.bankHead != null
                                              ? bank.bankHead!.name.toString()
                                              : "Null";
                                          controller.selectBank.value =
                                              bank.bankHeadId.toString() != null
                                                  ? bank.bankHeadId!.toString()
                                                  : "Null";

                                          selectType = bank.type != null
                                              ? bank.type.toString()
                                              : "Null";
                                          controller.type.value =
                                              bank.type.toString() != null
                                                  ? bank.type!.toString()
                                                  : "Null";
                                          return AlertDialog(
                                            title:
                                                const Text("Update Bank Entry"),
                                            content: SingleChildScrollView(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  AppDropDown(
                                                    labelText:
                                                        "Select Bank Name",
                                                    selectedItem: selectBank,
                                                    items: controller
                                                        .dropdownItems
                                                        .map<String>((item) =>
                                                            item['name']
                                                                .toString())
                                                        .toSet()
                                                        .toList(),
                                                    onChanged:
                                                        (selectedBankName) {
                                                      // Find the bank head with the selected name and print its ID
                                                      var selectedBank =
                                                          controller
                                                              .dropdownItems
                                                              .firstWhere(
                                                        (bank) =>
                                                            bank['name']
                                                                .toString() ==
                                                            selectedBankName,
                                                        orElse: () => null,
                                                      );
                                                      if (selectedBank !=
                                                          null) {
                                                        controller.selectBank
                                                                .value =
                                                            selectedBank['id']
                                                                .toString();
                                                      } else {
                                                        if (kDebugMode) {
                                                          print(
                                                              'Bank not found');
                                                        }
                                                      }
                                                    },
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  AppDropDown(
                                                    labelText: "Select Type",
                                                    selectedItem:
                                                        selectType == "0"
                                                            ? "Cash"
                                                            : "Online",
                                                    items: const [
                                                      'Cash',
                                                      'Online'
                                                    ],
                                                    onChanged: (value) {
                                                      if (value == 'Cash') {
                                                        controller.type.value =
                                                            '0';
                                                      } else {
                                                        controller.type.value =
                                                            '1';
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
                                                    controller: controller
                                                        .desposit.value,
                                                    labelText: "Deposit",
                                                    onlyNumerical: true,
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  AppTextField(
                                                    controller: controller
                                                        .withdraw.value,
                                                    labelText: "Withdraw",
                                                    onlyNumerical: true,
                                                  ),
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
                                                      controller
                                                          .updateBankEntry(bank
                                                              .id
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
                                                controller.deleteBankEntry(
                                                    bank.id.toString());
                                              },
                                            );
                                          });
                                    },
                                    view: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title:
                                                const Text("Customer Detail"),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                ViewText(
                                                    title: "Bank Head",
                                                    subTitle: bank.bankHead !=
                                                            null
                                                        ? bank.bankHead!.name
                                                            .toString()
                                                        : 'null'),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                ViewText(
                                                    title: "Bank Type",
                                                    subTitle: bank.type == '0'
                                                        ? 'Cash'
                                                        : 'Online'),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                ViewText(
                                                    title: "Description",
                                                    subTitle:
                                                        bank.description != null
                                                            ? bank.description
                                                                .toString()
                                                            : "null"),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                ViewText(
                                                    title: "Bank Deposit",
                                                    subTitle:
                                                        bank.deposit != null
                                                            ? bank.deposit
                                                                .toString()
                                                            : 'null'),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                ViewText(
                                                    title: "Bank Withdraw",
                                                    subTitle:
                                                        bank.withdraw != null
                                                            ? bank.withdraw
                                                                .toString()
                                                            : 'null'),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                ViewText(
                                                    title: "Date",
                                                    subTitle:
                                                        bank.date.toString()),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                              ],
                                            ),
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
              })),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          controller.clear();
          customShowDialogBox(controller, 'Add Bank Entry', 'Add', () {
            controller.addBankEntry();
          });
        },
        label: const Text("Add Bank Entry"),
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
                  labelText: "Select Bank Name",
                  items: controller.dropdownItems
                      .map<String>((item) => item['name'].toString())
                      .toSet()
                      .toList(),
                  onChanged: (selectedBankName) {
                    // Find the bank head with the selected name and print its ID
                    var selectedBank = controller.dropdownItems.firstWhere(
                      (bank) => bank['name'].toString() == selectedBankName,
                      orElse: () => null,
                    );
                    if (selectedBank != null) {
                      controller.selectBank.value =
                          selectedBank['id'].toString();
                    } else {
                      if (kDebugMode) {
                        print('Bank not found');
                      }
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                AppDropDown(
                  labelText: "Select Type",
                  items: const ['Cash', 'Online'],
                  onChanged: (value) {
                    if (value == 'Cash') {
                      controller.type.value = '0';
                    } else {
                      controller.type.value = '1';
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
                  controller: controller.desposit.value,
                  labelText: "Deposit",
                  onlyNumerical: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                AppTextField(
                  controller: controller.withdraw.value,
                  labelText: "Withdraw",
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
