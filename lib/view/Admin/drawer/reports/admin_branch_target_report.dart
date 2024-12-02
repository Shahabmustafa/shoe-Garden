import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/date/response/status.dart';
import 'package:sofi_shoes/res/circularindictor/circularindicator.dart';
import 'package:sofi_shoes/res/widget/general_execption_widget.dart';
import 'package:sofi_shoes/viewmodel/admin/discount/branch_target_viewmodel.dart';

import '../../../../res/responsive.dart';
import '../../../../res/slidebar/side_menu_admin.dart';
import '../../../../res/tabletext/table_text.dart';
import '../../../../res/widget/app_import_button.dart';
import '../../../../res/widget/textfield/app_text_field.dart';
import '../discount/export/branch_target_export.dart';

class AdminBranchTargetReport extends StatefulWidget {
  const AdminBranchTargetReport({super.key});

  @override
  State<AdminBranchTargetReport> createState() =>
      _AdminBranchTargetReportState();
}

class _AdminBranchTargetReportState extends State<AdminBranchTargetReport> {
  Future<void> refresh() async {
    Get.put(BranchTargetViewModel()).refreshApi();
  }

  @override
  void initState() {
    super.initState();
    Get.put(BranchTargetViewModel()).getAll();
    Get.put(BranchTargetViewModel()).fetchBranchName();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final controller = Get.put(BranchTargetViewModel());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Branch Target Report"),
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
            child: RefreshIndicator(
              onRefresh: refresh,
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
                          onTap: () => BranchTargetExport().printPdf(),
                        )),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Table(
                      columnWidths: const {
                        0: FlexColumnWidth(1),
                        1: FlexColumnWidth(2),
                        2: FlexColumnWidth(2),
                        3: FlexColumnWidth(2),
                        4: FlexColumnWidth(1),
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
                              text: 'Branch Name',
                              textColor: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            CustomTableCell(
                              text: 'Target Amount',
                              textColor: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            CustomTableCell(
                              text: 'Start Date',
                              textColor: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            CustomTableCell(
                              text: 'End Date',
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
                          return const Center(
                              child: CircularIndicator.waveSpinkit);
                        case Status.ERROR:
                          return GeneralExceptionWidget(
                              errorMessage: controller.error.value.toString(),
                              onPress: () {
                                controller.refreshApi();
                              });
                        case Status.COMPLETE:
                          return ListView.builder(
                            itemCount: controller.branchTargetList.value.body!
                                .branchsTargets!.length,
                            itemBuilder: (context, index) {
                              var branchTarget = controller.branchTargetList
                                  .value.body!.branchsTargets![index];
                              var name = branchTarget.branch != null
                                  ? branchTarget.branch!.name.toString()
                                  : "null";
                              if (controller.search.value.text.isEmpty ||
                                  name.toLowerCase().contains(controller
                                      .search.value.text
                                      .trim()
                                      .toLowerCase())) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 2.5),
                                  child: Table(
                                    columnWidths: const {
                                      0: FlexColumnWidth(1),
                                      1: FlexColumnWidth(2),
                                      2: FlexColumnWidth(2),
                                      3: FlexColumnWidth(2),
                                      4: FlexColumnWidth(1),
                                    },
                                    border: TableBorder.all(
                                      // borderRadius: BorderRadius.circular(5),
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
                                            text: branchTarget.branch != null
                                                ? branchTarget.branch!.name
                                                    .toString()
                                                : "null",
                                            textColor: Colors.black,
                                          ),
                                          CustomTableCell(
                                            text: branchTarget.amount != null
                                                ? branchTarget.amount!
                                                    .toString()
                                                : "null",
                                            textColor: Colors.black,
                                          ),
                                          CustomTableCell(
                                            text: branchTarget.startDate
                                                .toString(),
                                            textColor: Colors.black,
                                          ),
                                          CustomTableCell(
                                            text:
                                                branchTarget.endDate.toString(),
                                            textColor: Colors.black,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            },
                          );
                      }
                    }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
