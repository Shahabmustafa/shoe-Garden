import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sofi_shoes/date/response/status.dart';
import 'package:sofi_shoes/res/widget/general_execption_widget.dart';
import 'package:sofi_shoes/view/Branch/drawer/claims/export/admin_claim_export.dart';
import 'package:sofi_shoes/view/Branch/drawer/claims/view_warehouse_claim.dart';
import 'package:sofi_shoes/viewmodel/branch/claim/admin_claim_view_model.dart';

import '../../../../../res/circularindictor/circularindicator.dart';
import '../../../../../res/responsive.dart';
import '../../../../../res/slidebar/side_menu_branch.dart';
import '../../../../../res/widget/app_import_button.dart';
import '../../../../res/tabletext/table_text.dart';
import '../../../Manager/drawer/dashboard/dashboard_screen_a.dart';

class BAdminClaimReport extends StatefulWidget {
  const BAdminClaimReport({super.key});

  @override
  State<BAdminClaimReport> createState() => _BAdminClaimReportState();
}

class _BAdminClaimReportState extends State<BAdminClaimReport> {
  // Future<void> refreshCustomerList() async {
  //   Get.put(BAdminClaimViewModel()).refreshApi();
  // }

  @override
  void initState() {
    super.initState();
    Get.put(BAdminClaimViewModel()).getAll();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final size = MediaQuery.sizeOf(context);
    final controller = Get.put(BAdminClaimViewModel());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Claim Report"),
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
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        child: AppExportButton(
                          icons: Icons.add,
                          onTap: () {
                            AdminClaimExport().printPdf();
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
                      2: FlexColumnWidth(2),
                      3: FlexColumnWidth(2),
                      4: FlexColumnWidth(2),
                      5: FlexColumnWidth(2),
                      6: FlexColumnWidth(2),
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
                            text: "Admin",
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
                Expanded(child: Obx(() {
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
                      return controller.adminClaimList.value.body!.claims!.isNotEmpty ?
                      ListView.builder(
                        itemCount: controller.adminClaimList.value.body!.claims!.length,
                        itemBuilder: (context, index) {
                          var data = controller.adminClaimList.value.body!.claims![index];
                          print(">>><>><><><><><${data.status.runtimeType}");
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 2.5),
                            child: Table(
                              columnWidths: const {
                                0: FlexColumnWidth(1),
                                1: FlexColumnWidth(2),
                                2: FlexColumnWidth(2),
                                3: FlexColumnWidth(2),
                                4: FlexColumnWidth(2),
                                5: FlexColumnWidth(2),
                                6: FlexColumnWidth(2),
                                7: FlexColumnWidth(1),
                                8: FlexColumnWidth(1),
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
                                      text: data.claimTo == null ? "Null" : data.claimTo!.name.toString(),
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
                                    GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return ViewClaim(
                                              title: "Admin Claim Detail",
                                              claimForm: data.claimFrom == null
                                                  ? "Null"
                                                  : data.claimFrom!.name
                                                  .toString(),
                                              claimTO: data.claimTo == null
                                                  ? "Null"
                                                  : data.claimTo!.name
                                                  .toString(),
                                              product: data.product == null
                                                  ? "Product Null"
                                                  : data.product!.name
                                                  .toString(),
                                              brand: data.brand == null
                                                  ? "Brand Null"
                                                  : data.brand!.name.toString(),
                                              company: data.company == null
                                                  ? "Company Null"
                                                  : data.company!.name
                                                  .toString(),
                                              color: data.color == null
                                                  ? "Color Null"
                                                  : data.color!.name.toString(),
                                              size: data.size == null
                                                  ? "Size Null"
                                                  : data.size!.number
                                                  .toString(),
                                              type: data.type == null
                                                  ? "Type Null"
                                                  : data.type!.name.toString(),
                                              quantity: data.quantity == null
                                                  ? "Quantity Null"
                                                  : data.quantity!.toString(),
                                              date: data.date == null
                                                  ? "Date Null"
                                                  : data.date!.toString(),
                                              description:
                                              data.description == null
                                                  ? "Description Null"
                                                  : data.description!
                                                  .toString(),
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
                                        icons: data.status == 1
                                            ? Icons.check_circle
                                            : Icons.remove_circle,
                                        color: data.status == 1
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ) :
                      Center(
                        child: Text(
                          "Admin Claim is Empty",
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      );
                  }
                })),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
