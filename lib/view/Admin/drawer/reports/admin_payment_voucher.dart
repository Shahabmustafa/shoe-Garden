import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/date/response/status.dart';
import 'package:sofi_shoes/res/responsive.dart';
import 'package:sofi_shoes/res/slidebar/side_menu_admin.dart';
import 'package:sofi_shoes/res/widget/app_import_button.dart';
import 'package:sofi_shoes/res/widget/general_execption_widget.dart';
import 'package:sofi_shoes/view/Admin/drawer/reports/widget/voucher_report_table.dart';
import 'package:sofi_shoes/view/Admin/drawer/voucher/export/payment_voucher_export.dart';

import '../../../../res/circularindictor/circularindicator.dart';
import '../../../../res/widget/app_drop_down.dart';
import '../../../../viewmodel/admin/voucher/payment_voucher_viewmodel.dart';

class AdminPaymentVoucherReport extends StatefulWidget {
  const AdminPaymentVoucherReport({super.key});

  @override
  State<AdminPaymentVoucherReport> createState() =>
      _AdminPaymentVoucherReportState();
}

class _AdminPaymentVoucherReportState extends State<AdminPaymentVoucherReport> {
  Future<void> refreshCustomerList() async {
    Get.put(PaymentVoucherViewModel()).refreshApi();
  }

  @override
  void initState() {
    super.initState();
    Get.put(PaymentVoucherViewModel()).getAllPayment();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PaymentVoucherViewModel());
    final isDesktop = Responsive.isDesktop(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment Voucher Report"),
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
                      },
                    );
                  case Status.COMPLETE:
                    return Column(
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
                        VoucherReportTable(
                          number: "#",
                          customName: "Company Name",
                          amount: "Amount",
                          description: "Description",
                          date: "Date",
                          heading: true,
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: controller.paymentVoList.value.body!.paymentVouchers!.length,
                            itemBuilder: (context, index) {
                              var payment = controller.paymentVoList.value.body!.paymentVouchers![index];
                              var name = payment.company != null ? payment.company!.id.toString() : "Null";
                              if (controller.selectCompany.value.isEmpty || name.toString().toLowerCase().contains(controller.selectCompany.value.toLowerCase())) {
                                return VoucherReportTable(
                                  number: "${index + 1}",
                                  customName: payment.company != null ? payment.company!.name.toString() : "Null",
                                  amount: payment.amount != null ? payment.amount.toString() : "Null",
                                  description: payment.description != null ? payment.description.toString() : "Null",
                                  date: payment.date != null ? payment.date.toString() : "Null",
                                );
                              } else {
                                return Container();
                              }
                            },
                          ),
                        ),
                      ],
                    );
                }
              })),
        ],
      ),
    );
  }
}
