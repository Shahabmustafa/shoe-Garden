import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/date/response/status.dart';
import 'package:sofi_shoes/res/circularindictor/circularindicator.dart';
import 'package:sofi_shoes/res/responsive.dart';
import 'package:sofi_shoes/res/slidebar/side_menu_admin.dart';
import 'package:sofi_shoes/res/tabletext/table_text.dart';
import 'package:sofi_shoes/res/widget/app_import_button.dart';
import 'package:sofi_shoes/res/widget/general_execption_widget.dart';
import 'package:sofi_shoes/res/widget/textfield/app_text_field.dart';
import 'package:sofi_shoes/view/Admin/drawer/company/export/company_export.dart';
import 'package:sofi_shoes/viewmodel/admin/company/company_viewmodel.dart';

import '../../../Manager/drawer/dashboard/dashboard_screen_a.dart';
import '../company/widget/view_company.dart';

class AdminCompanyReport extends StatefulWidget {
  const AdminCompanyReport({super.key});

  @override
  State<AdminCompanyReport> createState() => _AdminCompanyReportState();
}

class _AdminCompanyReportState extends State<AdminCompanyReport> {
  Future<void> refresh() async {
    Get.put(CompanyViewModel()).refreshApi();
  }

  @override
  void initState() {
    super.initState();
    Get.put(CompanyViewModel()).getAllCompany();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CompanyViewModel());
    final isDesktop = Responsive.isDesktop(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Company Report"),
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
                                    labelText: "Search Company",
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
                                    onTap: () => CompanyExport().printPdf(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: Table(
                              columnWidths: const {
                                0: FlexColumnWidth(1),
                                1: FlexColumnWidth(3),
                                2: FlexColumnWidth(3),
                                3: FlexColumnWidth(1),
                              },
                              border: TableBorder.all(
                                // borderRadius: BorderRadius.circular(5),
                                color: Colors.grey.shade300,
                              ),
                              defaultColumnWidth: const FlexColumnWidth(0.5),
                              children: const [
                                TableRow(
                                  decoration: BoxDecoration(
                                    color: Color(0xff13132a),
                                  ),
                                  children: [
                                    CustomTableCell(
                                      text: "#",
                                      textColor: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    CustomTableCell(
                                      text: 'Customer Name',
                                      textColor: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    CustomTableCell(
                                      text: 'Opening Balance',
                                      textColor: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    CustomTableCell(
                                      text: 'View',
                                      textColor: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: controller.companyList.value.body != null &&
                                    controller.companyList.value.body!
                                            .companies !=
                                        null
                                ? ListView.builder(
                                    itemCount: controller.companyList.value
                                        .body!.companies!.length,
                                    itemBuilder: (context, index) {
                                      var company = controller.companyList.value
                                          .body!.companies![index];

                                      // Ensure 'company' and its properties are not null
                                      var name =
                                          company.name?.toString() ?? "null";
                                      if (controller
                                              .search.value.text.isEmpty ||
                                          name.toLowerCase().contains(controller
                                              .search.value.text
                                              .trim()
                                              .toLowerCase())) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 5),
                                          child: Table(
                                            columnWidths: const {
                                              0: FlexColumnWidth(1),
                                              1: FlexColumnWidth(3),
                                              2: FlexColumnWidth(3),
                                              3: FlexColumnWidth(1),
                                              4: FlexColumnWidth(1),
                                            },
                                            border: TableBorder.all(
                                              // borderRadius: BorderRadius.circular(5),
                                              color: Colors.grey.shade300,
                                            ),
                                            defaultColumnWidth:
                                                const FlexColumnWidth(0.5),
                                            children: [
                                              TableRow(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                ),
                                                children: [
                                                  CustomTableCell(
                                                    text: "${index + 1}",
                                                    textColor: Colors.black,
                                                  ),
                                                  CustomTableCell(
                                                    text: company.name.toString(),
                                                    textColor: Colors.black,
                                                  ),
                                                  CustomTableCell(
                                                    text: company.openingBalance
                                                        .toString(),
                                                    textColor: Colors.black,
                                                  ),
                                                  TableCell(
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return ViewCustomer(
                                                              title: "Company Detail",
                                                              companyName: company.name != null ? company.name.toString() : "Null",
                                                              email: company.email != null ? company.email.toString() : "Null",
                                                              phoneNumber: company.phoneNumber != null ? company.phoneNumber.toString() : "Null",
                                                              address: company.address != null ? company.address.toString() : "Null",
                                                              opBalance: company.openingBalance != null ? company.openingBalance.toString() : "Null",
                                                              date: company.currentDate != null ? company.currentDate.toString() : "Null",
                                                            );
                                                          },
                                                        );
                                                      },
                                                      child: CustomIcon(
                                                        icons: Icons.visibility,
                                                        color: Colors.green,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      } else {
                                        return Container();
                                      }
                                    },
                                  )
                                : Container(),
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
