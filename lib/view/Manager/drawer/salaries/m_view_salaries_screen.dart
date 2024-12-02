import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/date/response/status.dart';
import 'package:sofi_shoes/view/Admin/drawer/salaries/export/view_salaries_export.dart';
import 'package:sofi_shoes/view/Admin/drawer/salaries/view_saleman_salary.dart';
import 'package:sofi_shoes/viewmodel/admin/salaries/salaries_viewmodel.dart';

import '../../../../res/circularindictor/circularindicator.dart';
import '../../../../res/responsive.dart';
import '../../../../res/slidebar/side_menu_manager.dart';
import '../../../../res/tabletext/table_text.dart';
import '../../../../res/widget/app_import_button.dart';
import '../../../../res/widget/general_execption_widget.dart';
import '../../../../res/widget/not_found/not_found_widget.dart';
import '../../../../res/widget/textfield/app_text_field.dart';
import '../dashboard/dashboard_screen_a.dart';

class MSalariesScreen extends StatefulWidget {
  const MSalariesScreen({super.key});

  @override
  State<MSalariesScreen> createState() => _MSalariesScreenState();
}

class _MSalariesScreenState extends State<MSalariesScreen> {
  Future<void> refreshSalariesList() async {
    Get.put(SalemenSalariesViewModel()).refreshApi();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    var controller = Get.put(SalemenSalariesViewModel());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Salaries"),
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
                  var filteredStocks = controller.salariesList.value.body!.saleMenSalaries!.where((data) {
                    return controller.search.value.text.isEmpty || (data.name != null && data.name!.toLowerCase().contains(controller.search.value.text.trim().toLowerCase()));
                  }).toList();
                  return RefreshIndicator(
                    onRefresh: refreshSalariesList,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: AppTextField(
                                  controller: controller.search.value,
                                  labelText: "Search Salesman",
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
                                  onTap: () => ViewSalariesExport().printPdf(),
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
                              0: FlexColumnWidth(1.5),
                              1: FlexColumnWidth(3),
                              2: FlexColumnWidth(2),
                              3: FlexColumnWidth(2),
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
                                    text: 'Branch',
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
                          child: filteredStocks.isEmpty ?
                          NotFoundWidget(title: "Salaries Not Found") :
                          ListView.builder(
                            itemCount: controller.salariesList.value.body!.saleMenSalaries!.length,
                            itemBuilder: (context, index) {
                              var salaries = controller.salariesList.value.body!.saleMenSalaries![index];
                              var branchName = controller.findBranchName(salaries.branchId.toString());
                              if (controller.search.value.text.isEmpty || salaries.name!.toLowerCase().contains(controller.searchValue.value.trim().toLowerCase())) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2.5),
                                  child: Table(
                                    columnWidths: const {
                                      0: FlexColumnWidth(1.5),
                                      1: FlexColumnWidth(3),
                                      2: FlexColumnWidth(2),
                                      3: FlexColumnWidth(2),
                                    },
                                    border: TableBorder.all(
                                      color: Colors.grey.shade200,
                                    ),
                                    defaultColumnWidth:
                                    const FlexColumnWidth(0.5),
                                    children: [
                                      TableRow(
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                        ),
                                        children: [
                                          CustomTableCell(
                                            text: '${index + 1}',
                                            textColor: Colors.black,
                                          ),
                                          CustomTableCell(
                                            text: salaries.name ?? "null",
                                            textColor: Colors.black,
                                          ),
                                          CustomTableCell(
                                            text: branchName,
                                            textColor: Colors.black,
                                          ),
                                          CustomIcon(
                                            icons: Icons.visibility,
                                            color: Colors.green,
                                            onTap: (){
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return ViewSalemanSalaries(
                                                    salesmanName: salaries.name ?? "",
                                                    branch: branchName ?? "",
                                                    contact: salaries.phoneNumber ?? "",
                                                    address: salaries.address ?? "",
                                                    salary: salaries.salary.toString() ?? "",
                                                    commission: salaries.commission.toString() ?? "",
                                                    netSalary: salaries.netSalary.toString() ?? "",
                                                    totalSale: salaries.commissionOnTotalSale.toString() ?? "",
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                          // CustomTableCell(
                                          //   text: salaries.phoneNumber ?? "null",
                                          //   textColor: Colors.black,
                                          // ),
                                          // CustomTableCell(
                                          //   text: salaries.address ?? "null",
                                          //   textColor: Colors.black,
                                          // ),
                                          // CustomTableCell(
                                          //   text: salaries.salary ?? "null",
                                          //   textColor: Colors.black,
                                          // ),
                                          // CustomTableCell(
                                          //   text: salaries.totalSale.toString(),
                                          //   textColor: Colors.black,
                                          // ),
                                          // CustomTableCell(
                                          //   text: salaries.commission.toString(),
                                          //   textColor: Colors.black,
                                          // ),
                                          // CustomTableCell(
                                          //   text: salaries.netSalary.toString(),
                                          //   textColor: Colors.black,
                                          // ),
                                          // CustomTableCell(
                                          //   text: salaries.commissionOnTotalSale.toString(),
                                          //   textColor: Colors.black,
                                          // ),
                                        ],
                                      ),
                                    ],
                                  ),
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
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //     showDialog(
      //       context: context,
      //       builder: (context) {
      //         return AlertDialog(
      //           title: const Text("Update Salesman Salary"),
      //           content: SingleChildScrollView(
      //             child: Column(
      //               mainAxisSize: MainAxisSize.min,
      //               children: [
      //                 AppDropDown(
      //                   labelText: "Select Salesman",
      //                   items: controller.dropdownItems
      //                       .map<String>((item) => item['name'].toString())
      //                       .toList(),
      //                   onChanged: (selectedSalemenhName) {
      //                     // Find the bank head with the selected name and print its ID
      //                     var selectedBranch =
      //                         controller.dropdownItems.firstWhere(
      //                       (bank) =>
      //                           bank['name'].toString() == selectedSalemenhName,
      //                       orElse: () => null,
      //                     );
      //                     if (selectedBranch != null) {
      //                       controller.selectSalemen.value =
      //                           selectedBranch['id'].toString();
      //                       print(selectedBranch['id'].toString());
      //                     } else {
      //                       if (kDebugMode) {
      //                         print('Customer not found');
      //                       }
      //                     }
      //                   },
      //                 ),
      //                 const SizedBox(
      //                   height: 10,
      //                 ),
      //                 AppTextField(
      //                   labelText: "Net Salary",
      //                 ),
      //                 const SizedBox(
      //                   height: 10,
      //                 ),
      //                 AppTextField(
      //                   labelText: "Salary",
      //                   enabled: false,
      //                 ),
      //                 const SizedBox(
      //                   height: 10,
      //                 ),
      //                 AppTextField(
      //                   labelText: "Total Salary",
      //                 ),
      //                 const SizedBox(
      //                   height: 10,
      //                 ),
      //                 AppTextField(
      //                   labelText: "Percentage Reward",
      //                 ),
      //                 const SizedBox(
      //                   height: 20,
      //                 ),
      //               ],
      //             ),
      //           ),
      //           actions: [
      //             Row(
      //               mainAxisAlignment: MainAxisAlignment.spaceAround,
      //               children: [
      //                 ElevatedButton(
      //                   onPressed: () {},
      //                   child: const Text("Update"),
      //                 ),
      //                 ElevatedButton(
      //                   onPressed: () {
      //                     Navigator.pop(context);
      //                   },
      //                   child: const Text("Cancel"),
      //                 ),
      //               ],
      //             ),
      //           ],
      //         );
      //       },
      //     );
      //   },
      //   label: const Text("Update Salaries"),
      // ),
    );
  }
}
