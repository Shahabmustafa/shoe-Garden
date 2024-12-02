import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/res/circularindictor/circularindicator.dart';
import 'package:sofi_shoes/view/Admin/drawer/voucher/widget/cash_voucher_table.dart';
import 'package:sofi_shoes/viewmodel/admin/voucher/payment_voucher_viewmodel.dart';

import '../../../../date/response/status.dart';
import '../../../../res/dialog/edit_dialog.dart';
import '../../../../res/responsive.dart';
import '../../../../res/slidebar/side_menu_manager.dart';
import '../../../../res/widget/app_drop_down.dart';
import '../../../../res/widget/app_import_button.dart';
import '../../../../res/widget/general_execption_widget.dart';
import '../../../../res/widget/not_found/not_found_widget.dart';
import '../../../../res/widget/textfield/app_text_field.dart';
import 'export/payment_voucher_export.dart';

class MPaymentVoucherScreen extends StatefulWidget {
  const MPaymentVoucherScreen({super.key});

  @override
  State<MPaymentVoucherScreen> createState() => _MPaymentVoucherScreenState();
}

class _MPaymentVoucherScreenState extends State<MPaymentVoucherScreen> {
  Future<void> refreshPaymentList() async {
    Get.put(PaymentVoucherViewModel()).refreshApi();
  }

  String? selectCompany;

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final controller = Get.put(PaymentVoucherViewModel());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment Voucher"),
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
                        errorMessage: controller.error.value.toString(),
                        onPress: () {
                          controller.refreshApi();
                        });
                  case Status.COMPLETE:
                    var filteredStocks = controller.paymentVoList.value.body!.paymentVouchers!.where((data) {
                      return controller.selectCompany.value.isEmpty ||
                          (data.company != null && data.company!.id.toString().toLowerCase().contains(controller.selectCompany.value.trim().toLowerCase()));
                    }).toList();
                    return RefreshIndicator(
                      onRefresh: refreshPaymentList,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: AppDropDown(
                                    labelText: "Select Company",
                                    items: controller.dropdownItems.map<String>((item) => item['name'].toString()).toSet().toList(),
                                    onChanged: (selectedCustomerName) {
                                      var selectedCustomer = controller.dropdownItems.firstWhere((bank) => bank['name'].toString() == selectedCustomerName, orElse: () => null,);
                                      if (selectedCustomer != null) {
                                        controller.selectCompany.value = selectedCustomer['id'].toString();
                                        setState(() {});
                                      } else {
                                        if (kDebugMode) {
                                          print('Customer not found');
                                        }
                                      }
                                    },
                                  ),
                                ),
                                Flexible(
                                  child: AppExportButton(
                                    icons: Icons.add,
                                    onTap: () =>
                                        PaymentVoucherExport().printPdf(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          CashVoucherTable(
                            heading: true,
                            number: '#',
                            customerName: 'Company Name',
                            amount: 'Amount',
                            description: 'Description',
                            date: "Date",
                          ),
                          Expanded(
                            child: filteredStocks.isEmpty ?
                            NotFoundWidget(title: "Company Not Found") :
                            ListView.builder(
                              itemCount: controller.paymentVoList.value.body!.paymentVouchers!.length,
                              itemBuilder: (context, index) {
                                var payment = controller.paymentVoList.value.body!.paymentVouchers![index];
                                var name = payment.company != null ? payment.company!.id : "Null";
                                if (controller.selectCompany.value.isEmpty || name.toString().toLowerCase().contains(controller.selectCompany.value.toLowerCase())) {
                                  return CashVoucherTable(
                                      heading: false,
                                      number: "${index + 1}",
                                      customerName: payment.company != null ? payment.company!.name.toString() : "null",
                                      amount: payment.company != null ? payment.amount.toString() : "null",
                                      description: payment.description ?? "",
                                      date: payment.date.toString(),
                                      editOnpress: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            selectCompany =
                                            payment.company != null ? payment.company!.name.toString() : "Null";
                                            controller.selectCompany.value =
                                            payment.companyId != null ? payment.companyId.toString() : "Null";
                                            controller.selectCompany.value = payment.company!.id.toString();
                                            controller.openingBalance.value = TextEditingController(text: payment.company!.openingBalance.toString());
                                            controller.description.value = TextEditingController(text: payment.description);
                                            controller.amount.value = TextEditingController(text: payment.amount.toString());
                                            return AlertDialog(
                                              title: const Text("Update Payment Voucher"),
                                              content: SingleChildScrollView(
                                                child: Column(
                                                  mainAxisSize:
                                                  MainAxisSize.min,
                                                  children: [
                                                    AppDropDown(
                                                      labelText: "Select Company",
                                                      selectedItem: selectCompany,
                                                      items: controller.dropdownItems.map<String>((item) => item['name'].toString()).toSet().toList(),
                                                      onChanged: (companyName) {
                                                        var selectCompany =
                                                        controller.dropdownItems.firstWhere((bank) =>
                                                        bank['name'].toString() == companyName, orElse: () => null,
                                                        );
                                                        if (selectCompany != null) {
                                                          controller.selectCompany.value = selectCompany['id'].toString();
                                                          controller.openingBalance.value.text = selectCompany['opening_balance'].toString();
                                                        } else {
                                                          if (kDebugMode) {
                                                            print('Customer not found');
                                                          }
                                                        }
                                                      },
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    AppTextField(
                                                      controller: controller.openingBalance.value,
                                                      labelText:
                                                      "Company Opening Balance",
                                                      enabled: false,
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    AppTextField(
                                                      controller: controller.amount.value,
                                                      labelText: "Amount",
                                                      onlyNumerical: true,
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    AppTextField(
                                                      controller: controller.description.value,
                                                      labelText: "Description",
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
                                                      child:
                                                      const Text("Cancel"),
                                                    ),
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        controller.updatePayment(
                                                            payment.id
                                                                .toString());
                                                      },
                                                      child:
                                                      const Text("Update"),
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
                                                controller.deletePayment(
                                                    payment.id.toString());
                                              },
                                            );
                                          },
                                        );
                                      });
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
              return AlertDialog(
                title: const Text("Add Payment Voucher"),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppDropDown(
                        labelText: "Select Company",
                        items: controller.dropdownItems.map<String>((item) => item['name'].toString()).toSet().toList(),
                        onChanged: (selectedCustomerName) {
                          var selectedCustomer =
                          controller.dropdownItems.firstWhere((bank) =>
                          bank['name'].toString() == selectedCustomerName,
                            orElse: () => null,
                          );
                          if (selectedCustomer != null) {
                            controller.selectCompany.value = selectedCustomer['id'].toString();
                            controller.openingBalance.value.text = selectedCustomer["opening_balance"].toString();
                          } else {
                            if (kDebugMode) {
                              print('Customer not found');
                            }
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      AppTextField(
                        controller: controller.openingBalance.value,
                        labelText: "Company Opening Balance",
                        enabled: false,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      AppTextField(
                        controller: controller.amount.value,
                        labelText: "Amount",
                        onlyNumerical: true,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
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
                          controller.addPaymentVoucher();
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
        label: const Text("Add Payment Voucher"),
      ),
    );
  }
}