import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/date/response/status.dart';
import 'package:sofi_shoes/res/circularindictor/circularindicator.dart';
import 'package:sofi_shoes/res/responsive.dart';
import 'package:sofi_shoes/res/slidebar/side_menu_admin.dart';
import 'package:sofi_shoes/res/widget/general_execption_widget.dart';
import 'package:sofi_shoes/view/Admin/drawer/reports/widget/salesman_report_report.dart';
import 'package:sofi_shoes/viewmodel/admin/salesman/salesman_viewmodel.dart';

import '../../../../res/widget/app_import_button.dart';
import '../../../../res/widget/textfield/app_text_field.dart';
import '../saleman/export/saleman_export.dart';

class AdminSalesmanReport extends StatefulWidget {
  const AdminSalesmanReport({super.key});

  @override
  State<AdminSalesmanReport> createState() => _AdminSalesmanReportState();
}

class _AdminSalesmanReportState extends State<AdminSalesmanReport> {
  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final controller = Get.put(SalemenViewModel());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Salemen Report"),
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
                    return Column(
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
                                  labelText: "Search Name",
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
                                  onTap: () => SalemanExport().printPdf(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SalesmanReportTable(
                          index: "#",
                          name: "Name",
                          phoneNumber: "Phone Number",
                          salary: "Salary",
                          address: "Address",
                          branch: "Branch",
                          heading: true,
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: controller
                                .salemenList.value.body!.saleMen!.length,
                            itemBuilder: (context, index) {
                              var salemen = controller
                                  .salemenList.value.body!.saleMen![index];
                              var name = salemen.name.toString();
                              var branchName = controller
                                  .findBranchName(salemen.branchId.toString());
                              if (controller.search.value.text.isEmpty ||
                                  name.toLowerCase().contains(controller
                                      .searchValue.value
                                      .trim()
                                      .toLowerCase())) {
                                return SalesmanReportTable(
                                  index: "${index + 1}",
                                  name: name,
                                  phoneNumber: salemen.phoneNumber.toString(),
                                  address: salemen.address.toString(),
                                  branch: branchName,
                                  salary: salemen.salary.toString(),
                                  heading: false,
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
