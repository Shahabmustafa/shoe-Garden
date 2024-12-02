import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/date/response/status.dart';
import 'package:sofi_shoes/res/widget/general_execption_widget.dart';
import 'package:sofi_shoes/res/widget/not_found/not_found_widget.dart';
import 'package:sofi_shoes/view/Branch/drawer/salaries/export/salesman_export.dart';
import 'package:sofi_shoes/viewmodel/branch/salaries/salman_salaries_repository.dart';

import '../../../../res/circularindictor/circularindicator.dart';
import '../../../../res/responsive.dart';
import '../../../../res/slidebar/side_menu_branch.dart';
import '../../../../res/tabletext/table_text.dart';
import '../../../../res/widget/app_import_button.dart';
import '../../../../res/widget/textfield/app_text_field.dart';
import '../../../../viewmodel/branch/report/salesman_report_viewmodel.dart';

class SalariesScreenBranch extends StatefulWidget {
  const SalariesScreenBranch({super.key});

  @override
  State<SalariesScreenBranch> createState() => _SalariesScreenBranchState();
}

class _SalariesScreenBranchState extends State<SalariesScreenBranch> {
  Future<void> refreshUserList() async {
    Get.put(BranchSalmanSalariesViewModel()).refreshApi();
  }

  @override
  void initState() {
    super.initState();
    Get.put(SalesmanReportViewmodel()).getSalesmanSalaryReport();
  }


  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final controller = Get.put(SalesmanReportViewmodel());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Salesman Salaries"),
      ),
      drawer: !isDesktop
          ? const SizedBox(
              width: 250,
              child: SideMenuWidgetBranch(),
            )
          : null,
      body: Row(
        children: [
          isDesktop
              ? const Expanded(flex: 2, child: SideMenuWidgetBranch())
              : Container(),
          Expanded(
            flex: 8,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: AppTextField(
                          controller: controller.search.value,
                          labelText: "Search Salesman",
                          search: true,
                          prefixIcon: Icon(Icons.search),
                          onChanged: (value) {
                            setState(() {
                              controller.searchValue.value = value;
                            });
                          },
                        ),
                      ),
                      Flexible(
                        child: AppExportButton(
                          icons: Icons.add,
                          onTap: () {
                            SalemanExport().printSalesmanPdf();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Table(
                    columnWidths: const {
                      0: FlexColumnWidth(0.5),
                      1: FlexColumnWidth(2),
                      2: FlexColumnWidth(2),
                      3: FlexColumnWidth(2),
                      4: FlexColumnWidth(2),
                      5: FlexColumnWidth(3),
                      6: FlexColumnWidth(2),
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
                            text: 'Salesman Name',
                            textColor: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          CustomTableCell(
                            text: 'Net Salary',
                            textColor: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          CustomTableCell(
                            text: 'Commission',
                            textColor: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          CustomTableCell(
                            text: 'Total Sale',
                            textColor: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          CustomTableCell(
                            text: 'Total Commission',
                            textColor: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          CustomTableCell(
                            text: 'Total Salary',
                            textColor: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Obx(() {
                    switch (controller.rxRequestStatus.value) {
                      case Status.LOADING:
                        return const Center(child: CircularIndicator.waveSpinkit);
                      case Status.ERROR:
                        return GeneralExceptionWidget(
                          errorMessage: controller.error.value.toString(),
                          onPress: () {
                            controller.salesmanSalaryReportRefresh();
                          },
                        );
                      case Status.COMPLETE:
                        var salesmen = controller.salesmanSalaryReportList.value.body!.saleMen!;
                        // Filter salesmen based on search input
                        var filteredSalesmen = salesmen.where((data) {
                          var salesmanName = data.name?.toString().toLowerCase() ?? "";
                          return controller.search.value.text.isEmpty ||
                              salesmanName.contains(controller.search.value.text.trim().toLowerCase());
                        }).toList();

                        // If there are no matching salesmen after filtering
                        if (filteredSalesmen.isEmpty) {
                          return NotFoundWidget(title: "No Salesman Found",);
                        }

                        // If there are matching salesmen, display them in a ListView
                        return ListView.builder(
                          itemCount: filteredSalesmen.length ?? 00,
                          itemBuilder: (context, index) {
                            var data = filteredSalesmen[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2.5),
                              child: Table(
                                columnWidths: const {
                                  0: FlexColumnWidth(0.5),
                                  1: FlexColumnWidth(2),
                                  2: FlexColumnWidth(2),
                                  3: FlexColumnWidth(2),
                                  4: FlexColumnWidth(2),
                                  5: FlexColumnWidth(3),
                                  6: FlexColumnWidth(2),
                                },
                                border: TableBorder.all(
                                  color: Colors.grey.shade200,
                                ),
                                defaultColumnWidth: const FlexColumnWidth(0.5),
                                children: [
                                  TableRow(
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    children: [
                                      CustomTableCell(text: '${index + 1}', textColor: Colors.black),
                                      CustomTableCell(text: data.name?.toString() ?? "Null", textColor: Colors.black),
                                      CustomTableCell(text: data.salary?.toString() ?? "0", textColor: Colors.black),
                                      CustomTableCell(text: data.commission?.toString() ?? "0", textColor: Colors.black),
                                      CustomTableCell(text: data.totalSale?.toStringAsFixed(0) ?? "0", textColor: Colors.black),
                                      CustomTableCell(text: data.totalCommission?.toStringAsFixed(2) ?? "0", textColor: Colors.black),
                                      CustomTableCell(text: data.totalSalary?.toStringAsFixed(2) ?? "0", textColor: Colors.black),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                    }
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
