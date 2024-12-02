import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sofi_shoes/date/response/status.dart';
import 'package:sofi_shoes/res/circularindictor/circularindicator.dart';
import 'package:sofi_shoes/res/widget/general_execption_widget.dart';
import 'package:sofi_shoes/view/Admin/drawer/discount/export/branch_target_export.dart';
import 'package:sofi_shoes/viewmodel/admin/discount/branch_target_viewmodel.dart';

import '../../../../res/responsive.dart';
import '../../../../res/slidebar/side_menu_manager.dart';
import '../../../../res/tabletext/table_text.dart';
import '../../../../res/widget/app_drop_down.dart';
import '../../../../res/widget/app_import_button.dart';
import '../../../../res/widget/not_found/not_found_widget.dart';
import '../../../../res/widget/textfield/app_text_field.dart';
import '../dashboard/dashboard_screen_a.dart';

class MBranchTargetScreen extends StatefulWidget {
  const MBranchTargetScreen({super.key});

  @override
  State<MBranchTargetScreen> createState() => _MBranchTargetScreenState();
}

class _MBranchTargetScreenState extends State<MBranchTargetScreen> {
  String? selectedStartDate;
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  Future<void> startDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        // Format the selected date to match Y-m-d format
        selectedStartDate = DateFormat('yyyy-MM-dd').format(picked);
        startDateController.text = selectedStartDate!;
      });
    }
  }

  String? selectedEndDate;

  Future<void> endDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        // Format the selected date to match Y-m-d format
        selectedEndDate = DateFormat('yyyy-MM-dd').format(picked);
        endDateController.text = selectedEndDate!;
      });
    }
  }

  Future<void> refresh() async {
    Get.put(BranchTargetViewModel()).refreshApi();
  }

  @override
  void initState() {
    super.initState();
    Get.put(BranchTargetViewModel()).getAll();
    Get.put(BranchTargetViewModel()).fetchBranchName();
  }

  String? selectBranch;

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final controller = Get.put(BranchTargetViewModel());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Branch Target"),
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
                            prefixIcon: const Icon(Icons.search),
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
                        5: FlexColumnWidth(1),
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
                            CustomTableCell(
                              text: 'Edit',
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
                          var filteredStocks = controller.branchTargetList.value.body!.branchsTargets!.where((data) {
                            return controller.search.value.text.isEmpty ||
                                (data.branch != null && data.branch!.name!.toLowerCase().contains(controller.search.value.text.trim().toLowerCase()));
                          }).toList();
                          return filteredStocks.isEmpty ?
                          NotFoundWidget(title: "Branch Not Found") :
                          ListView.builder(
                            itemCount: controller.branchTargetList.value.body!.branchsTargets!.length,
                            itemBuilder: (context, index) {
                              var branchTarget = controller.branchTargetList.value.body!.branchsTargets![index];
                              var name = branchTarget.branch != null ? branchTarget.branch!.name.toString() : "null";
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
                                      5: FlexColumnWidth(1),
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
                                          TableCell(
                                            child: CustomIcon(
                                              icons: CupertinoIcons.eyedropper,
                                              color: Colors.blue,
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    selectBranch =
                                                    branchTarget.branch !=
                                                        null
                                                        ? branchTarget
                                                        .branch!.name
                                                        .toString()
                                                        : "Null";
                                                    controller.selectBranch
                                                        .value = branchTarget
                                                        .branchId !=
                                                        null
                                                        ? branchTarget.branchId
                                                        .toString()
                                                        : "Null";
                                                    controller.target.value =
                                                        TextEditingController(
                                                            text: branchTarget
                                                                .amount!
                                                                .toString());
                                                    startDateController =
                                                        TextEditingController(
                                                            text: branchTarget
                                                                .startDate!
                                                                .toString());
                                                    endDateController =
                                                        TextEditingController(
                                                            text: branchTarget
                                                                .endDate!
                                                                .toString());
                                                    return AlertDialog(
                                                      title: const Text(
                                                          "Update Branch Target Discount"),
                                                      content:
                                                      SingleChildScrollView(
                                                        child: Column(
                                                          mainAxisSize:
                                                          MainAxisSize.min,
                                                          children: [
                                                            AppDropDown(
                                                              labelText:
                                                              "Select Branch",
                                                              selectedItem:
                                                              selectBranch,
                                                              items: controller
                                                                  .branchDropDownItems
                                                                  .map<String>((item) =>
                                                                  item['name']
                                                                      .toString())
                                                                  .toSet()
                                                                  .toList(),
                                                              onChanged:
                                                                  (prodcutWise) {
                                                                var head = controller
                                                                    .branchDropDownItems
                                                                    .firstWhere(
                                                                      (head) =>
                                                                  head['name']
                                                                      .toString() ==
                                                                      prodcutWise,
                                                                  orElse: () =>
                                                                  null,
                                                                );
                                                                if (head !=
                                                                    null) {
                                                                  controller
                                                                      .selectBranch
                                                                      .value = head[
                                                                  'id']
                                                                      .toString();
                                                                } else {
                                                                  if (kDebugMode) {
                                                                    print(
                                                                        'Expense Head not found');
                                                                  }
                                                                }
                                                              },
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            AppTextField(
                                                              type:
                                                              TextInputType
                                                                  .number,
                                                              controller:
                                                              controller
                                                                  .target
                                                                  .value,
                                                              labelText:
                                                              "Target",
                                                              onlyNumerical:
                                                              true,
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                startDate(
                                                                    context);
                                                              },
                                                              child:
                                                              AppTextField(
                                                                controller:
                                                                startDateController,
                                                                labelText:
                                                                "Start Date",
                                                                enabled: false,
                                                                suffixIcon:
                                                                IconButton(
                                                                  onPressed: () =>
                                                                      startDate(
                                                                          context),
                                                                  icon: const Icon(
                                                                      Icons
                                                                          .calendar_today),
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                endDate(
                                                                    context);
                                                              },
                                                              child:
                                                              AppTextField(
                                                                controller:
                                                                endDateController,
                                                                labelText:
                                                                "End Date",
                                                                enabled: false,
                                                                suffixIcon:
                                                                IconButton(
                                                                  onPressed: () =>
                                                                      endDate(
                                                                          context),
                                                                  icon: const Icon(
                                                                      Icons
                                                                          .calendar_today),
                                                                ),
                                                              ),
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
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: const Text(
                                                                  "Cancel"),
                                                            ),
                                                            ElevatedButton(
                                                              onPressed: () {
                                                                controller.updates(
                                                                    branchTarget
                                                                        .id
                                                                        .toString(),
                                                                    selectedStartDate,
                                                                    selectedEndDate);
                                                              },
                                                              child: const Text(
                                                                  "Update"),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                            ),
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          startDateController.clear();
          endDateController.clear();
          controller.clear();
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Add Branch Wise Discount"),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppDropDown(
                        labelText: "Select Branch",
                        items: controller.branchDropDownItems
                            .map<String>((item) => item['name'].toString())
                            .toList(),
                        onChanged: (prodcutWise) {
                          var head = controller.branchDropDownItems.firstWhere(
                            (head) => head['name'].toString() == prodcutWise,
                            orElse: () => null,
                          );
                          if (head != null) {
                            controller.selectBranch.value =
                                head['id'].toString();
                          } else {
                            if (kDebugMode) {
                              print('Expense Head not found');
                            }
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      AppTextField(
                        type: TextInputType.number,
                        controller: controller.target.value,
                        labelText: "Target",
                        onlyNumerical: true,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          startDate(context);
                        },
                        child: AppTextField(
                          controller: startDateController,
                          labelText: "Start Date",
                          enabled: false,
                          suffixIcon: IconButton(
                            onPressed: () => startDate(context),
                            icon: const Icon(Icons.calendar_today),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          endDate(context);
                        },
                        child: AppTextField(
                          controller: endDateController,
                          labelText: "End Date",
                          enabled: false,
                          suffixIcon: IconButton(
                            onPressed: () => endDate(context),
                            icon: const Icon(Icons.calendar_today),
                          ),
                        ),
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
                          controller.add(selectedStartDate, selectedEndDate);
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
        label: const Text("Add Branch Target"),
      ),
    );
  }
}
