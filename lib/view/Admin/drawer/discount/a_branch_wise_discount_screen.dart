import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/date/response/status.dart';
import 'package:sofi_shoes/res/circularindictor/circularindicator.dart';
import 'package:sofi_shoes/res/utils/utils.dart';
import 'package:sofi_shoes/res/widget/general_execption_widget.dart';
import 'package:sofi_shoes/res/widget/not_found/not_found_widget.dart';
import 'package:sofi_shoes/view/Admin/drawer/discount/export/branch_wise_discount_export.dart';

import '../../../../res/dialog/edit_dialog.dart';
import '../../../../res/responsive.dart';
import '../../../../res/slidebar/side_menu_admin.dart';
import '../../../../res/tabletext/table_text.dart';
import '../../../../res/widget/app_drop_down.dart';
import '../../../../res/widget/app_import_button.dart';
import '../../../../res/widget/textfield/app_text_field.dart';
import '../../../../viewmodel/admin/discount/branch_wise_discount_viewmodel.dart';
import '../../../Manager/drawer/dashboard/dashboard_screen_a.dart';

class ABranchWiseDiscountScreen extends StatefulWidget {
  const ABranchWiseDiscountScreen({super.key});

  @override
  State<ABranchWiseDiscountScreen> createState() =>
      _ABranchWiseDiscountScreenState();
}

class _ABranchWiseDiscountScreenState extends State<ABranchWiseDiscountScreen> {
  Future<void> refresh() async {
    Get.put(BranchWiseDiscountViewModel()).refreshApi();
  }

  int count = 0;

  String? selectBranch;
  int? selectStatus;

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    final controller = Get.put(BranchWiseDiscountViewModel());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Branch Wise Discount"),
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
            child: RefreshIndicator(
              onRefresh: refresh,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Obx(
                            () => AppDropDown(
                              labelText: "Select Branch",
                              items: controller.branchDropDownItems.map<String>((item) => item['name'].toString()).toSet().toList(),
                              onChanged: (branchWise) {
                                var head = controller.branchDropDownItems.firstWhere((head) => head['name'].toString() == branchWise, orElse: () => null,);
                                if (head != null) {
                                  controller.selectBranch.value = head['id'].toString();
                                } else {
                                  if (kDebugMode) {
                                    print('Expense Head not found');
                                  }
                                }
                                setState(() {});
                              },
                            ),
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
                            CustomTableCell(
                              text: 'Edit',
                              textColor: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            CustomTableCell(
                              text: 'Delete',
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
                          var filteredStocks = controller.branchWiseDiscountList.value.body!.branchesDiscount!.where((data) {
                            return controller.selectBranch.value.isEmpty ||
                                (data.branch != null && data.branch!.id.toString().toLowerCase().contains(controller.selectBranch.value.trim().toLowerCase()));
                          }).toList();
                          return filteredStocks.isEmpty ?
                          NotFoundWidget(title: "Branch Discount Not Found") :
                          ListView.builder(
                            itemCount: controller.branchWiseDiscountList.value.body!.branchesDiscount!.length,
                            itemBuilder: (context, index) {
                              var branchWiseDiscount = controller.branchWiseDiscountList.value.body!.branchesDiscount![index];
                              var name = branchWiseDiscount.branch != null ? branchWiseDiscount.branch!.id.toString() : "null";
                              if (controller.selectBranch.value.isEmpty || name.toLowerCase().contains(controller.selectBranch.value.toLowerCase())) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2.5),
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
                                            text: branchWiseDiscount.discount !=
                                                    null
                                                ? branchWiseDiscount.discount
                                                    .toString()
                                                : "null",
                                            textColor: Colors.black,
                                          ),
                                          TableCell(
                                            child: CustomIcon(
                                              icons:
                                                  branchWiseDiscount.status == 1
                                                      ? Icons
                                                          .check_circle_rounded
                                                      : Icons.remove_circle,
                                              color:
                                                  branchWiseDiscount.status == 1
                                                      ? Colors.green
                                                      : Colors.red,
                                            ),
                                          ),
                                          TableCell(
                                            child: CustomIcon(
                                              icons: CupertinoIcons.eyedropper,
                                              color: Colors.blue,
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    selectBranch = branchWiseDiscount.branch != null ? branchWiseDiscount.branch.toString() : "Null";
                                                    controller.selectBranch.value = branchWiseDiscount.branchId != null ? branchWiseDiscount.branchId.toString() : "Null";
                                                    controller.discount.value = TextEditingController(text: branchWiseDiscount.discount!.toString());
                                                    controller.status.value = branchWiseDiscount.status == 1;
                                                    return AlertDialog(
                                                      title: const Text("Update Product Wise Discount"),
                                                      content: StatefulBuilder(
                                                        builder: (context,
                                                            setState) {
                                                          return SingleChildScrollView(
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                AppDropDown(
                                                                  labelText:
                                                                      "Select Branch",
                                                                  items: controller
                                                                      .branchDropDownItems
                                                                      .map<String>(
                                                                          (item) =>
                                                                              item['name'].toString())
                                                                      .toSet()
                                                                      .toList(),
                                                                  onChanged:
                                                                      (branchWise) {
                                                                    var head = controller
                                                                        .branchDropDownItems
                                                                        .firstWhere(
                                                                      (head) =>
                                                                          head['name']
                                                                              .toString() ==
                                                                          branchWise,
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
                                                                  height: 20,
                                                                ),
                                                                AppTextField(
                                                                  type: TextInputType
                                                                      .number,
                                                                  controller:
                                                                      controller
                                                                          .discount
                                                                          .value,
                                                                  labelText:
                                                                      "Discount %",
                                                                  onlyNumerical:
                                                                      true,
                                                                ),
                                                                const SizedBox(
                                                                  height: 20,
                                                                ),
                                                                Obx(() {
                                                                  return SwitchListTile(
                                                                    title: const Text(
                                                                        "Status"),
                                                                    value: controller
                                                                        .status
                                                                        .value,
                                                                    onChanged:
                                                                        (value) {
                                                                      controller
                                                                          .status
                                                                          .value = value;
                                                                      print(controller
                                                                          .status
                                                                          .value);
                                                                    },
                                                                  );
                                                                }),
                                                              ],
                                                            ),
                                                          );
                                                        },
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
                                                                double
                                                                    discountValue =
                                                                    double.parse(controller
                                                                        .discount
                                                                        .value
                                                                        .text);

                                                                if (discountValue >
                                                                        0.0 &&
                                                                    discountValue <
                                                                        99.0) {
                                                                  controller.updates(
                                                                      branchWiseDiscount
                                                                          .id
                                                                          .toString());
                                                                } else {
                                                                  Utils.ErrorToastMessage(
                                                                      "Please add 0 to 99 Discount");
                                                                }
                                                              },
                                                              child: const Text(
                                                                  "update"),
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
                                          TableCell(
                                            child: CustomIcon(
                                              icons: CupertinoIcons.delete,
                                              color: Colors.red,
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return EditDialog(
                                                      reject: () {
                                                        Navigator.pop(context);
                                                      },
                                                      accept: () {
                                                        controller.delete(
                                                            branchWiseDiscount
                                                                .id
                                                                .toString());
                                                      },
                                                    );
                                                  },
                                                );
                                              },
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
                            .toSet()
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
                        height: 20,
                      ),
                      AppTextField(
                        type: TextInputType.number,
                        labelText: "Discount Percentage",
                        controller: controller.discount.value,
                        onlyNumerical: true,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Obx(() {
                        return SwitchListTile(
                          title: const Text("Status"),
                          value: controller.status.value,
                          onChanged: (value) {
                            controller.status.value = value;
                            print(controller.status.value);
                          },
                        );
                      }),
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
                          double discountValue =
                              double.parse(controller.discount.value.text);

                          if (discountValue > 0.0 && discountValue < 99.0) {
                            controller.add();
                          } else {
                            Utils.ErrorToastMessage("Please add 0 to 99 Discount");
                          }
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
        label: const Text("Add Branch Wise Discount"),
      ),
    );
  }
}
