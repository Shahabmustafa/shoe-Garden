import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/date/response/status.dart';
import 'package:sofi_shoes/res/circularindictor/circularindicator.dart';
import 'package:sofi_shoes/view/Admin/drawer/voucher/widget/cash_voucher_table.dart';
import 'package:sofi_shoes/viewmodel/admin/voucher/cash_voucher_viewmodel.dart';

import '../../../../res/dialog/edit_dialog.dart';
import '../../../../res/responsive.dart';
import '../../../../res/slidebar/side_menu_manager.dart';
import '../../../../res/widget/app_drop_down.dart';
import '../../../../res/widget/app_import_button.dart';
import '../../../../res/widget/general_execption_widget.dart';
import '../../../../res/widget/not_found/not_found_widget.dart';
import '../../../../res/widget/textfield/app_text_field.dart';
import 'export/cash_voucher_export.dart';

class MCashVoucherScreen extends StatefulWidget {
  const MCashVoucherScreen({super.key});

  @override
  State<MCashVoucherScreen> createState() => _MCashVoucherScreenState();
}

class _MCashVoucherScreenState extends State<MCashVoucherScreen> {
  Future<void> refresh() async {
    Get.put(CashVoucherViewModel()).refreshApi();
  }

  String? selectCustomer;

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final controller = Get.put(CashVoucherViewModel());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cash Voucher"),
      ),
      drawer: !isDesktop
          ? const SizedBox(
              width: 250,
              child: SideMenuWidgetManager(),
            )
          : null,
      body: Row(
        children: [
          isDesktop ? const Expanded(flex: 2, child: SideMenuWidgetManager()) : Container(),
          Expanded(
            flex: 8,
            child: Obx(() {
              switch (controller.rxRequestStatus.value) {
                case Status.LOADING:
                  return const Center(child: CircularIndicator.waveSpinkit);
                case Status.ERROR:
                  return GeneralExceptionWidget(
                    errorMessage: controller.error.value,
                    onPress: controller.refreshApi,
                  );
                case Status.COMPLETE:
                  var filteredStocks = controller.cashList.value.body!.cashVouchers!.where((data) {
                    return controller.selectCustomer.value.isEmpty ||
                        (data.customer != null && data.customer!.id.toString().toLowerCase().contains(controller.selectCustomer.value.trim().toLowerCase()));
                  }).toList();
                  return RefreshIndicator(
                    onRefresh: refresh,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Obx((){
                                  return AppDropDown(
                                    labelText: "Select Customer",
                                    items: controller.dropdownItems.map<String>((item) => item['name'].toString()).toSet().toList(),
                                    onChanged: (selectedCustomerName) {
                                      var selectedCustomer = controller.dropdownItems.firstWhere((customer) => customer['name'].toString() == selectedCustomerName, orElse: () => null,);
                                      if (selectedCustomer != null) {
                                        controller.selectCustomer.value = selectedCustomer['id'].toString();
                                        setState(() {

                                        });
                                      } else {
                                        if (kDebugMode) {
                                          print('Customer Not found');
                                        }
                                      }
                                    },
                                  );
                                }),
                              ),
                              Flexible(
                                child: AppExportButton(
                                  icons: Icons.add,
                                  onTap: CashVoucherExport().printPdf,
                                ),
                              ),
                            ],
                          ),
                        ),
                        CashVoucherTable(
                          heading: true,
                          number: '#',
                          customerName: 'Customer Name',
                          amount: 'Amount',
                          description: 'Description',
                          date: 'Date',
                        ),
                        Expanded(
                          child: filteredStocks.isEmpty ?
                          NotFoundWidget(title: "Customer Not Found") :
                          ListView.builder(
                            itemCount: controller.cashList.value.body!.cashVouchers!.length,
                            itemBuilder: (context, index) {
                              var cashVoucher = controller.cashList.value.body!.cashVouchers![index];
                              var name = cashVoucher.customer?.id ?? "null";
                              if (controller.selectCustomer.value.isEmpty || name.toString().toLowerCase().contains(controller.selectCustomer.value.toLowerCase())) {
                                return CashVoucherTable(
                                  heading: false,
                                  number: "${index + 1}",
                                  customerName: cashVoucher.customer?.name ?? "Null",
                                  amount: cashVoucher.amount?.toString() ?? "null",
                                  description: cashVoucher.description ?? "",
                                  date: cashVoucher.date ?? "",
                                  editOnpress: () {
                                    controller.clear();
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        controller.selectCustomer.value = cashVoucher.customerId?.toString() ?? "Null";
                                        controller.balance.value.text = cashVoucher.customer?.openingBalance?.toString() ?? "";
                                        controller.description.value.text = cashVoucher.description ?? "";
                                        controller.amount.value.text = cashVoucher.amount?.toString() ?? "";
                                        return AlertDialog(
                                          title: const Text("Update Cash Voucher"),
                                          content: SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                AppDropDown(
                                                  labelText: "Select Customer",
                                                  selectedItem: cashVoucher.customer?.name ?? "Null",
                                                  items: controller.dropdownItems.map<String>((item) => item['name'].toString()).toSet().toList(),
                                                  onChanged: (selectedCustomerName) {
                                                    var selectedCustomer = controller.dropdownItems.firstWhere((customer) => customer['name'].toString() == selectedCustomerName, orElse: () => null,);
                                                    if (selectedCustomer != null) {
                                                      controller.selectCustomer.value = selectedCustomer['id'].toString();
                                                      controller.balance.value.text = selectedCustomer['opening_balance'].toString();
                                                    } else {
                                                      if (kDebugMode) {
                                                        print('Customer not found');
                                                      }
                                                    }
                                                  },
                                                ),
                                                const SizedBox(height: 10),
                                                AppTextField(
                                                  controller: controller.balance.value,
                                                  labelText: "Balance",
                                                  onlyNumerical: true,
                                                  enabled: false,
                                                ),
                                                const SizedBox(height: 10),
                                                AppTextField(
                                                  labelText: "Amount",
                                                  controller: controller.amount.value,
                                                  onlyNumerical: true,
                                                ),
                                                const SizedBox(height: 10),
                                                AppTextField(
                                                  controller: controller.description.value,
                                                  labelText: "Description",
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
                                                    controller.updateCash(cashVoucher.id.toString());
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
                                            controller.deleteCash(
                                                cashVoucher.id.toString());
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
          controller.clear();
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Add Cash Voucher"),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppDropDown(
                        labelText: "Select Customer",
                        items: controller.dropdownItems
                            .map<String>((item) => item['name'].toString())
                            .toSet()
                            .toList(),
                        onChanged: (selectedCustomerName) {
                          var selectedCustomer =
                          controller.dropdownItems.firstWhere(
                                (customer) =>
                            customer['name'].toString() ==
                                selectedCustomerName,
                            orElse: () => null,
                          );
                          if (selectedCustomer != null) {
                            controller.selectCustomer.value =
                                selectedCustomer['id'].toString();
                            controller.balance.value.text =
                                selectedCustomer['opening_balance'].toString();
                          } else {
                            if (kDebugMode) {
                              print('Customer not found');
                            }
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                      AppTextField(
                        controller: controller.balance.value,
                        labelText: "Balance",
                        onlyNumerical: true,
                        enabled: false,
                      ),
                      const SizedBox(height: 10),
                      AppTextField(
                        labelText: "Amount",
                        controller: controller.amount.value,
                        onlyNumerical: true,
                      ),
                      const SizedBox(height: 10),
                      AppTextField(
                        controller: controller.description.value,
                        labelText: "Description",
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
                          controller.addCashVoucher();
                        },
                        child: const Text("add"),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        },
        label: const Text("Add Cash Voucher"),
      ),
    );
  }
}
