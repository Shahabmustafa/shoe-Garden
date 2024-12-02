import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/date/response/status.dart';
import 'package:sofi_shoes/res/widget/general_execption_widget.dart';
import 'package:sofi_shoes/res/widget/internet_execption_widget.dart';
import 'package:sofi_shoes/view/Admin/drawer/discount/export/branch_wise_discount_export.dart';

import '../../../../res/responsive.dart';
import '../../../../res/slidebar/side_menu_admin.dart';
import '../../../../res/tabletext/table_text.dart';
import '../../../../res/widget/app_drop_down.dart';
import '../../../../res/widget/app_import_button.dart';
import '../../../../res/widget/textfield/app_text_field.dart';
import '../../../../viewmodel/admin/discount/branch_wise_discount_viewmodel.dart';

class AdminBranchWiseDiscountReport extends StatefulWidget {
  const AdminBranchWiseDiscountReport({super.key});

  @override
  State<AdminBranchWiseDiscountReport> createState() =>
      _AdminBranchWiseDiscountReportState();
}

class _AdminBranchWiseDiscountReportState
    extends State<AdminBranchWiseDiscountReport> {
  Future<void> refresh() async {
    Get.put(BranchWiseDiscountViewModel()).refreshApi();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final controller = Get.put(BranchWiseDiscountViewModel());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Branch Wise Discount Report"),
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
                          child: AppDropDown(
                            labelText: "Select Branch",
                            items: controller.branchDropDownItems
                                .map<String>((item) => item['name'].toString())
                                .toList(),
                            onChanged: (branchWise) {
                              var head =
                                  controller.branchDropDownItems.firstWhere(
                                (head) => head['name'].toString() == branchWise,
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
                        ),
                        Flexible(
                          child: AppExportButton(
                            icons: Icons.add,
                            onTap: () => BranchWiseDiscountExport().printPdf(),
                          ),
                        ),
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
                        3: FlexColumnWidth(1),
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
                              text: 'Discount',
                              textColor: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            CustomTableCell(
                              text: 'Status',
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
                              child: CircularProgressIndicator());
                        case Status.ERROR:
                          if (controller.error.value == 'No internet') {
                            return InterNetExceptionWidget(onPress: () {
                              return controller.refreshApi();
                            });
                          } else {
                            return GeneralExceptionWidget(onPress: () {
                              controller.refreshApi();
                            });
                          }
                        case Status.COMPLETE:
                          return ListView.builder(
                            itemCount: controller.branchWiseDiscountList.value
                                .body!.branchesDiscount!.length,
                            itemBuilder: (context, index) {
                              var branchWiseDiscount = controller
                                  .branchWiseDiscountList
                                  .value
                                  .body!
                                  .branchesDiscount![index];
                              var name =
                                  branchWiseDiscount.branch!.name.toString();
                              if (controller.selectBranch.value.isEmpty ||
                                  name.toLowerCase().contains(controller
                                      .selectBranch.value
                                      .toLowerCase())) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 2.5),
                                  child: Table(
                                    columnWidths: const {
                                      0: FlexColumnWidth(1),
                                      1: FlexColumnWidth(2),
                                      2: FlexColumnWidth(2),
                                      3: FlexColumnWidth(1),
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
                                            text: branchWiseDiscount.branch !=
                                                    null
                                                ? branchWiseDiscount
                                                    .branch!.name
                                                    .toString()
                                                : "null",
                                            textColor: Colors.black,
                                          ),
                                          CustomTableCell(
                                            text: branchWiseDiscount.discount
                                                    .toString() ??
                                                "null",
                                            textColor: Colors.black,
                                          ),
                                          TableCell(
                                            child: Icon(
                                              branchWiseDiscount.status == 2 ? Icons.remove_circle : Icons.check_circle_rounded,
                                              color: branchWiseDiscount.status == 1 ? Colors.green : Colors.red,
                                              size: 16,
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
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Add Branch Wise Discount"),
                content: Column(
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
                          controller.selectBranch.value = head['id'].toString();
                        } else {
                          if (kDebugMode) {
                            print('Expense Head not found');
                          }
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AppTextField(
                      labelText: "Discount Percentage",
                      controller: controller.discount.value,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Obx(() {
                      return SwitchListTile(
                        title: Text("Stataus"),
                        value: controller.status.value,
                        onChanged: (value) {
                          controller.status.value = value;
                          print(controller.status.value);
                        },
                      );
                    }),
                  ],
                ),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          controller.add();
                        },
                        child: const Text("Add"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel"),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        },
        label: const Text("Add Branch Wise Discount"),
      ),
    );
  }
}
