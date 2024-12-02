import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/date/response/status.dart';
import 'package:sofi_shoes/res/widget/general_execption_widget.dart';
import 'package:sofi_shoes/res/widget/not_found/not_found_widget.dart';
import 'package:sofi_shoes/view/Branch/drawer/claims/branchclaim/add_branch_claim.dart';
import 'package:sofi_shoes/view/Branch/drawer/claims/export/branch_claim_export.dart';
import 'package:sofi_shoes/viewmodel/branch/claim/branch_claim_view_model.dart';

import '../../../../../res/circularindictor/circularindicator.dart';
import '../../../../../res/responsive.dart';
import '../../../../../res/slidebar/side_menu_branch.dart';
import '../../../../../res/tabletext/table_text.dart';
import '../../../../../res/widget/app_import_button.dart';
import '../../../../../res/widget/textfield/app_text_field.dart';
import '../../../../Manager/drawer/dashboard/dashboard_screen_a.dart';
import '../view_warehouse_claim.dart';

class BBranchClaim extends StatefulWidget {
  const BBranchClaim({super.key});

  @override
  State<BBranchClaim> createState() => _BBranchClaimState();
}

class _BBranchClaimState extends State<BBranchClaim> {
  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final size = MediaQuery.sizeOf(context);
    final controller = Get.put(BBranchClaimViewModel());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Branch Claim"),
      ),
      drawer: !isDesktop ? const SizedBox(width: 250, child: SideMenuWidgetBranch(),) : null,
      body: Row(
        children: [
          isDesktop ? const Expanded(flex: 2, child: SideMenuWidgetBranch()) : Container(),
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
                          labelText: "Search Branch",
                          search: true,
                          prefixIcon: const Icon(Icons.search),
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
                            BranchClaimExport().printPdf();
                          },
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
                      2: FlexColumnWidth(3),
                      3: FlexColumnWidth(2),
                      4: FlexColumnWidth(2),
                      5: FlexColumnWidth(2),
                      6: FlexColumnWidth(2),
                      7: FlexColumnWidth(4),
                      8: FlexColumnWidth(1),
                      9: FlexColumnWidth(1.5),
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
                            text: "Branch",
                            textColor: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          CustomTableCell(
                            text: 'Product',
                            textColor: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          CustomTableCell(
                            text: 'Color',
                            textColor: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          CustomTableCell(
                            text: 'Type',
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
                            text: 'View',
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
                        return const Center(child: CircularIndicator.waveSpinkit);
                      case Status.ERROR:
                        return GeneralExceptionWidget(
                          errorMessage: controller.error.value.toString(),
                          onPress: () {
                            controller.refreshApi();
                          },
                        );
                      case Status.COMPLETE:
                        var claims = controller.branchClaimList.value.body!.claims!;

                        // Filter claims based on search input
                        var filteredClaims = claims.where((data) {
                          var name = data.claimTo!.name.toString();
                          return controller.search.value.text.isEmpty || name.toLowerCase().contains(controller.search.value.text.trim().toLowerCase());
                        }).toList();

                        // Check if filtered list is empty
                        if (filteredClaims.isEmpty) {
                          return NotFoundWidget(title: "Branch Not Found");
                        }

                        // If there are matching claims, display them in a ListView
                        return ListView.builder(
                          itemCount: filteredClaims.length,
                          itemBuilder: (context, index) {
                            var data = filteredClaims[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2.5),
                              child: Table(
                                columnWidths: const {
                                  0: FlexColumnWidth(1),
                                  1: FlexColumnWidth(2),
                                  2: FlexColumnWidth(3),
                                  3: FlexColumnWidth(2),
                                  4: FlexColumnWidth(2),
                                  5: FlexColumnWidth(2),
                                  6: FlexColumnWidth(2),
                                  7: FlexColumnWidth(4),
                                  8: FlexColumnWidth(1),
                                  9: FlexColumnWidth(1.5),
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
                                      CustomTableCell(
                                        text: '${index + 1}',
                                        textColor: Colors.black,
                                      ),
                                      CustomTableCell(
                                        text: data.claimTo != null ? data.claimTo!.name.toString() : "Null",
                                        textColor: Colors.black,
                                      ),
                                      CustomTableCell(
                                        text: data.product != null ? data.product!.name.toString() : "Null",
                                        textColor: Colors.black,
                                      ),
                                      CustomTableCell(
                                        text: data.color != null ? data.color!.name.toString() : "Null",
                                        textColor: Colors.black,
                                      ),
                                      CustomTableCell(
                                        text: data.type != null ? data.type!.name.toString() : "Null",
                                        textColor: Colors.black,
                                      ),
                                      CustomTableCell(
                                        text: data.size != null ? data.size!.number.toString() : "Null",
                                        textColor: Colors.black,
                                      ),
                                      CustomTableCell(
                                        text: data.quantity != null ? data.quantity!.toString() : "Null",
                                        textColor: Colors.black,
                                      ),
                                      CustomTableCell(
                                        text: data.description ?? "Null",
                                        textColor: Colors.black,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return ViewClaim(
                                                title: "Branch Claim Detail",
                                                claimForm: data.claimFrom == null ? "Null" : data.claimFrom!.name.toString(),
                                                claimTO: data.claimTo == null ? "Null" : data.claimTo!.name.toString(),
                                                product: data.product == null ? "Product Null" : data.product!.name.toString(),
                                                brand: data.brand == null ? "Brand Null" : data.brand!.name.toString(),
                                                company: data.company == null ? "Company Null" : data.company!.name.toString(),
                                                color: data.color == null ? "Color Null" : data.color!.name.toString(),
                                                size: data.size == null ? "Size Null" : data.size!.number.toString(),
                                                type: data.type == null ? "Type Null" : data.type!.name.toString(),
                                                quantity: data.quantity == null ? "Quantity Null" : data.quantity!.toString(),
                                                date: data.date == null ? "Date Null" : data.date!.toString(),
                                                description: data.description == null ? "Description Null" : data.description!.toString(),
                                              );
                                            },
                                          );
                                        },
                                        child: const CustomIcon(
                                          icons: Icons.visibility,
                                          color: Colors.green,
                                        ),
                                      ),
                                      TableCell(
                                        child: CustomIcon(
                                          icons: data.status == 2 ? Icons.remove_circle : Icons.check_circle,
                                          color: data.status == 0 ? Colors.yellow : data.status == 1 ? Colors.green : Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                    }
                  }),
                )

              ],
            ),
          ),
        ],
      ),
      floatingActionButton: const AddBranchClaim(),
    );
  }
}
