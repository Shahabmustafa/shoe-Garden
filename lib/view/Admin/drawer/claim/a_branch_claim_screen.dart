import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/date/response/status.dart';
import 'package:sofi_shoes/res/circularindictor/circularindicator.dart';
import 'package:sofi_shoes/res/dialog/edit_dialog.dart';
import 'package:sofi_shoes/res/widget/general_execption_widget.dart';
import 'package:sofi_shoes/res/widget/not_found/not_found_widget.dart';
import 'package:sofi_shoes/view/Manager/drawer/dashboard/dashboard_screen_a.dart';
import 'package:sofi_shoes/viewmodel/admin/claim/branch_claim_viewmodel.dart';

import '../../../../res/responsive.dart';
import '../../../../res/slidebar/side_menu_admin.dart';
import '../../../../res/tabletext/table_text.dart';
import '../../../../res/utils/utils.dart';
import '../../../../res/widget/app_import_button.dart';
import '../../../../res/widget/textfield/app_text_field.dart';
import '../../../Branch/drawer/claims/view_warehouse_claim.dart';
import 'export/branch_claim_export.dart';

class ABranchClaimScreen extends StatefulWidget {
  const ABranchClaimScreen({super.key});

  @override
  State<ABranchClaimScreen> createState() => _ABranchClaimScreenState();
}

class _ABranchClaimScreenState extends State<ABranchClaimScreen> {
  // List<bool> approve = List.generate(20, (index) => false);

  Future<void> refresh() async {
    Get.put(BranchClaimViewModel()).refreshApi();
  }

  @override
  void initState() {
    super.initState();
    Get.put(BranchClaimViewModel()).getAllBranchClaim();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    // final size = MediaQuery.sizeOf(context);
    final controller = Get.put(BranchClaimViewModel());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Branch Claim"),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: AppTextField(
                            controller: controller.search.value,
                            labelText: "Search Branch",
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
                            onTap: () => BranchClaimExport().printPdf(),
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
                        3: FlexColumnWidth(2),
                        4: FlexColumnWidth(2),
                        5: FlexColumnWidth(2),
                        6: FlexColumnWidth(4),
                        7: FlexColumnWidth(1),
                        8: FlexColumnWidth(1),
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
                              text: "Claim Form",
                              textColor: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            CustomTableCell(
                              text: 'Products',
                              textColor: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            CustomTableCell(
                              text: 'Color',
                              textColor: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            CustomTableCell(
                              text: 'Size',
                              textColor: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            CustomTableCell(
                              text: 'Quantity',
                              textColor: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            CustomTableCell(
                              text: 'Description',
                              textColor: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            CustomTableCell(
                              text: 'Status',
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
                    child: Obx(
                      () {
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
                            var filteredStocks = controller.branchClaimList.value.body!.claimsFromBranches!.where((data) {
                              return controller.search.value.text.isEmpty || (data.claimFrom != null && data.claimFrom!.name!.toLowerCase().contains(controller.search.value.text.trim().toLowerCase()));
                            }).toList();
                            return filteredStocks.isEmpty ?
                            NotFoundWidget(title: "Branch Not Found") :
                            ListView.builder(
                              itemCount: controller.branchClaimList.value.body!.claimsFromBranches!.length,
                              itemBuilder: (context, index) {
                                var branchClaim = controller.branchClaimList.value.body!.claimsFromBranches![index];
                                if (controller.search.value.text.isEmpty || branchClaim.claimFrom!.name.toString().contains(controller.search.value.text.trim().toLowerCase())) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2.5),
                                    child: Table(
                                      columnWidths: const {
                                        0: FlexColumnWidth(1),
                                        1: FlexColumnWidth(2),
                                        2: FlexColumnWidth(2),
                                        3: FlexColumnWidth(2),
                                        4: FlexColumnWidth(2),
                                        5: FlexColumnWidth(2),
                                        6: FlexColumnWidth(4),
                                        7: FlexColumnWidth(1),
                                        8: FlexColumnWidth(1),
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
                                              text: "${index + 1}",
                                              textColor: Colors.black,
                                            ),
                                            CustomTableCell(
                                              text: branchClaim.claimFrom != null ? branchClaim.claimFrom!.name : "null",
                                              textColor: Colors.black,
                                            ),
                                            CustomTableCell(
                                              text: branchClaim.product != null ? branchClaim.product!.name : "null",
                                              textColor: Colors.black,
                                            ),
                                            CustomTableCell(
                                              text: branchClaim.color != null ? branchClaim.color!.name : "null",
                                              textColor: Colors.black,
                                            ),
                                            CustomTableCell(
                                              text: branchClaim.size != null ? branchClaim.size!.number.toString() : "null",
                                              textColor: Colors.black,
                                            ),
                                            CustomTableCell(
                                              text: branchClaim.quantity?.toString() ?? "null",
                                              textColor: Colors.black,
                                            ),
                                            CustomTableCell(
                                              text: branchClaim.description?.toString() ?? "null",
                                              textColor: Colors.black,
                                            ),
                                            TableCell(
                                              child: GestureDetector(
                                                onTap: () {
                                                  branchClaim.status == 0
                                                      ? showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return EditDialog(
                                                              title:
                                                                  "Do you want to Approve",
                                                              accept: () {
                                                                controller.updateStatus(
                                                                    "1",
                                                                    branchClaim
                                                                        .id
                                                                        .toString());
                                                                Get.back();
                                                              },
                                                              reject: () {
                                                                controller.updateStatus(
                                                                    "2",
                                                                    branchClaim
                                                                        .id
                                                                        .toString());
                                                                Get.back();
                                                              },
                                                            );
                                                          },
                                                        )
                                                      : Utils.ErrorToastMessage(
                                                          'do not change status');
                                                },
                                                child: CustomIcon(
                                                  icons: branchClaim.status == 2 ? Icons.remove_circle : Icons.check_circle_rounded,
                                                  color: branchClaim.status == 0 ? Colors.yellow : branchClaim.status == 1 ? Colors.green : Colors.red,
                                                ),
                                              ),
                                            ),
                                            TableCell(
                                              child: GestureDetector(
                                                onTap: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return ViewClaim(
                                                        title: "Branch Claim Detail",
                                                        claimForm: branchClaim
                                                                    .claimFrom !=
                                                                null
                                                            ? branchClaim
                                                                .claimFrom!.name
                                                                .toString()
                                                            : "null",
                                                        claimTO: branchClaim
                                                                    .claimTo !=
                                                                null
                                                            ? branchClaim
                                                                .claimTo!.name
                                                                .toString()
                                                            : "null",
                                                        product: branchClaim
                                                                    .product !=
                                                                null
                                                            ? branchClaim
                                                                .product!.name
                                                                .toString()
                                                            : "null",
                                                        brand:
                                                            branchClaim.brand !=
                                                                    null
                                                                ? branchClaim
                                                                    .brand!.name
                                                                    .toString()
                                                                : "null",
                                                        company: branchClaim
                                                                    .company !=
                                                                null
                                                            ? branchClaim
                                                                .company!.name
                                                                .toString()
                                                            : "null",
                                                        color:
                                                            branchClaim.color !=
                                                                    null
                                                                ? branchClaim
                                                                    .color!.name
                                                                    .toString()
                                                                : "null",
                                                        size:
                                                            branchClaim.size !=
                                                                    null
                                                                ? branchClaim
                                                                    .size!
                                                                    .number
                                                                    .toString()
                                                                : "null",
                                                        type:
                                                            branchClaim.type !=
                                                                    null
                                                                ? branchClaim
                                                                    .type!.name
                                                                    .toString()
                                                                : "null",
                                                        quantity: branchClaim
                                                                    .quantity !=
                                                                null
                                                            ? branchClaim
                                                                .quantity
                                                                .toString()
                                                            : "null",
                                                        date: branchClaim
                                                                    .date !=
                                                                null
                                                            ? branchClaim.date
                                                                .toString()
                                                            : "null",
                                                        description: branchClaim
                                                                    .description !=
                                                                null
                                                            ? branchClaim
                                                                .description
                                                                .toString()
                                                            : "null",
                                                      );
                                                    },
                                                  );
                                                },
                                                child: const CustomIcon(
                                                  icons: Icons.visibility,
                                                  color: Colors.green,
                                                ),
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
                      },
                    ),
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
