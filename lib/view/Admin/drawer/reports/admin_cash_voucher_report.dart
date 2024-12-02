import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/date/response/status.dart';
import 'package:sofi_shoes/res/circularindictor/circularindicator.dart';
import 'package:sofi_shoes/res/responsive.dart';
import 'package:sofi_shoes/res/slidebar/side_menu_admin.dart';
import 'package:sofi_shoes/res/widget/app_import_button.dart';
import 'package:sofi_shoes/res/widget/general_execption_widget.dart';
import 'package:sofi_shoes/view/Admin/drawer/reports/widget/voucher_report_table.dart';
import 'package:sofi_shoes/view/Admin/drawer/voucher/export/cash_voucher_export.dart';
import 'package:sofi_shoes/viewmodel/admin/voucher/cash_voucher_viewmodel.dart';

import '../../../../res/widget/app_drop_down.dart';

class AdminCashVoucherReport extends StatefulWidget {
  const AdminCashVoucherReport({super.key});

  @override
  State<AdminCashVoucherReport> createState() => _AdminCashVoucherReportState();
}

class _AdminCashVoucherReportState extends State<AdminCashVoucherReport> {
  Future<void> refresh() async {
    Get.put(CashVoucherViewModel()).refreshApi();
  }

  @override
  void initState() {
    super.initState();
    Get.put(CashVoucherViewModel()).getAllCash();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CashVoucherViewModel());
    final isDesktop = Responsive.isDesktop(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cash Voucher Report"),
      ),
      drawer: !isDesktop
          ? const SizedBox(
              width: 250,
              child: SideMenuWidgetAdmin(),
            )
          : null,
      body: Row(
        children: [
          isDesktop ? const Expanded(flex: 2, child: SideMenuWidgetAdmin()) : Container(),
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
                      },
                    );
                  case Status.COMPLETE:
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
                                  child: AppDropDown(
                                    labelText: "Select Customer",
                                    items: controller.dropdownItems.map<String>((item) => item['name'].toString()).toSet().toList(),
                                    onChanged: (selectedCustomerName) {
                                      var selectedCustomer = controller.dropdownItems.firstWhere((customer) => customer['name'].toString() == selectedCustomerName, orElse: () => null,);
                                      if (selectedCustomer != null) {
                                        controller.selectCustomer.value = selectedCustomer['id'].toString();
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
                                    onTap: CashVoucherExport().printPdf,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          VoucherReportTable(
                            number: "#",
                            customName: "Customer Name",
                            amount: "Amount",
                            description: "Description",
                            date: "Date",
                            heading: true,
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: controller.cashList.value.body!.cashVouchers!.length,
                              itemBuilder: (context, index) {
                                var expenseDetail = controller.cashList.value.body!.cashVouchers![index];
                                var name = expenseDetail.customer?.id ?? "null";
                                if (controller.selectCustomer.value.isEmpty || name.toString().toLowerCase().contains(controller.selectCustomer.value.toLowerCase())) {
                                  return VoucherReportTable(
                                    number: "${index + 1}",
                                    customName: expenseDetail.customer != null
                                        ? expenseDetail.customer!.name
                                            .toString()
                                        : "null",
                                    amount: expenseDetail.amount.toString() ??
                                        "null",
                                    description:
                                        expenseDetail.description ?? "null",
                                    date: expenseDetail.date ?? "null",
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
    );
  }
}
