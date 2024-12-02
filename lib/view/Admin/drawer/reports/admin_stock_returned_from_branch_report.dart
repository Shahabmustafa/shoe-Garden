import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/date/response/status.dart';
import 'package:sofi_shoes/res/circularindictor/circularindicator.dart';
import 'package:sofi_shoes/res/widget/general_execption_widget.dart';
import 'package:sofi_shoes/viewmodel/admin/claim/returned_stock_branch_view_model.dart';

import '../../../../res/responsive.dart';
import '../../../../res/slidebar/side_menu_admin.dart';
import '../../../../res/tabletext/table_text.dart';
import '../../../../res/widget/app_import_button.dart';
import '../../../../res/widget/textfield/app_text_field.dart';
import '../../../Branch/drawer/claims/view_warehouse_claim.dart';
import '../../../Manager/drawer/dashboard/dashboard_screen_a.dart';
import '../claim/export/returned_stock_branch_export.dart';

class AReturnedStockBranchReportScreen extends StatefulWidget {
  const AReturnedStockBranchReportScreen({super.key});

  @override
  State<AReturnedStockBranchReportScreen> createState() =>
      _AReturnedStockBranchReportScreenState();
}

class _AReturnedStockBranchReportScreenState
    extends State<AReturnedStockBranchReportScreen> {
  // List<bool> approve = List.generate(20, (index) => false);

  Future<void> refresh() async {
    Get.put(ReturnedStockBranchViewModel()).refreshApi();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final controller = Get.put(ReturnedStockBranchViewModel());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Returned Stock From Branch"),
      ),
      drawer: !isDesktop ? const SizedBox(width: 250, child: SideMenuWidgetAdmin(),) : null,
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
                            onTap: () => ReturnedStockBranchExport().printPdf(),
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
                        6: FlexColumnWidth(1),
                        7: FlexColumnWidth(1),
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
                              text: "Return Form",
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
                            return ListView.builder(
                              itemCount: controller.returnedStockBranchList
                                  .value.body!.returnProducts!.length,
                              itemBuilder: (context, index) {
                                var stock = controller.returnedStockBranchList
                                    .value.body!.returnProducts![index];
                                if (controller.search.value.text.isEmpty ||
                                    stock.returnFrom!.name.toString().contains(
                                        controller.search.value.text
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
                                        4: FlexColumnWidth(2),
                                        5: FlexColumnWidth(2),
                                        6: FlexColumnWidth(1),
                                        7: FlexColumnWidth(1),
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
                                              text: stock.returnFrom!.name ?? "Null",
                                              textColor: Colors.black,
                                            ),
                                            CustomTableCell(
                                              text: stock.product != null ? stock.product!.name : "null",
                                              textColor: Colors.black,
                                            ),
                                            CustomTableCell(
                                              text: stock.color != null ? stock.color!.name : "null",
                                              textColor: Colors.black,
                                            ),
                                            CustomTableCell(
                                              text: stock.size != null ? stock.size!.number.toString() : "null",
                                              textColor: Colors.black,
                                            ),
                                            CustomTableCell(
                                              text: stock.quantity?.toString() ?? "null",
                                              textColor: Colors.black,
                                            ),
                                            TableCell(
                                              child: CustomIcon(
                                                icons: stock.status == 2 ? Icons.remove_circle : Icons.check_circle_rounded,
                                                color: stock.status == 0 ? Colors.yellow : stock.status == 1 ? Colors.green : Colors.red,
                                              ),
                                            ),
                                            TableCell(
                                              child: GestureDetector(
                                                onTap: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return ViewClaim(
                                                        title:
                                                        "Return Stock To Branch Detail",
                                                        claimForm: stock.returnFrom != null ? stock.returnFrom!.name.toString() : "null",
                                                        claimTO: stock.returnTo != null ? stock.returnTo!.name.toString() : "null",
                                                        product: stock.product != null ? stock.product!.name.toString() : "null",
                                                        brand: stock.brand != null ? stock.brand!.name.toString() : "null",
                                                        company: stock.company != null ? stock.company!.name.toString() : "null",
                                                        color: stock.color != null ? stock.color!.name.toString() : "null",
                                                        size: stock.size != null ? stock.size!.number.toString() : "null",
                                                        type: stock.type != null ? stock.type!.name.toString() : "null",
                                                        quantity: stock.quantity != null ? stock.quantity.toString() : "null",
                                                        date: stock.date != null ? stock.date.toString() : "null",
                                                        description: stock.description != null ? stock.description.toString() : "null",
                                                      );
                                                    },
                                                  );
                                                },
                                                child: CustomIcon(
                                                  icons:  Icons.visibility,
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
