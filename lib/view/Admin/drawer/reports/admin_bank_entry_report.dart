import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/date/response/status.dart';
import 'package:sofi_shoes/res/circularindictor/circularindicator.dart';
import 'package:sofi_shoes/res/responsive.dart';
import 'package:sofi_shoes/res/slidebar/side_menu_admin.dart';
import 'package:sofi_shoes/res/widget/app_import_button.dart';
import 'package:sofi_shoes/res/widget/general_execption_widget.dart';
import 'package:sofi_shoes/res/widget/textfield/app_text_field.dart';
import 'package:sofi_shoes/view/Admin/drawer/bank/export/bank_entry_export.dart';
import 'package:sofi_shoes/view/Admin/drawer/reports/widget/bank_entry_report_table.dart';
import 'package:sofi_shoes/viewmodel/admin/bank/bank_entry_viewmodel.dart';

class AdminBankEntryReport extends StatefulWidget {
  const AdminBankEntryReport({super.key});

  @override
  State<AdminBankEntryReport> createState() => _AdminBankEntryReportState();
}

class _AdminBankEntryReportState extends State<AdminBankEntryReport> {
  Future<void> refresh() async {
    Get.put(BankEntryViewModel()).refreshApi();
  }

  @override
  void initState() {
    super.initState();
    Get.put(BankEntryViewModel()).getAllBankEntry();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BankEntryViewModel());
    final isDesktop = Responsive.isDesktop(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bank Entry Report"),
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
                                    controller: controller.search.value,
                                    labelText: "Search Head",
                                    prefixIcon: Icon(Icons.search),
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
                          BankEntryReportTable(
                            index: '#',
                            bankName: "Bank Name",
                            type: "Type",
                            description: "Description",
                            deposite: "Deposite",
                            withdraw: "Withdraw",
                            heading: true,
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: controller.bankEntryList.value.body!
                                  .bankEnteries!.length,
                              itemBuilder: (context, index) {
                                var expenseDetail = controller.bankEntryList
                                    .value.body!.bankEnteries![index];
                                if (controller.search.value.text.isEmpty ||
                                    expenseDetail.bankHead!.name!
                                        .toLowerCase()
                                        .contains(controller.search.value.text
                                            .trim()
                                            .toLowerCase())) {
                                  return BankEntryReportTable(
                                    index: "${index + 1}",
                                    bankName: expenseDetail.bankHead != null
                                        ? expenseDetail.bankHead!.name
                                            .toString()
                                        : "null",
                                    type: expenseDetail.type != null
                                        ? expenseDetail.type.toString()
                                        : "null",
                                    description:
                                        expenseDetail.description ?? "null",
                                    deposite:
                                        expenseDetail.deposit.toString() ??
                                            "null",
                                    withdraw:
                                        expenseDetail.withdraw.toString() ??
                                            "null",
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
