import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/date/response/status.dart';
import 'package:sofi_shoes/res/circularindictor/circularindicator.dart';
import 'package:sofi_shoes/res/dialog/edit_dialog.dart';
import 'package:sofi_shoes/view/Admin/drawer/claim/export/warehouse_claim_export.dart';
import 'package:sofi_shoes/view/Manager/drawer/dashboard/dashboard_screen_a.dart';

import '../../../../res/responsive.dart';
import '../../../../res/slidebar/side_menu_manager.dart';
import '../../../../res/tabletext/table_text.dart';
import '../../../../res/utils/utils.dart';
import '../../../../res/widget/app_import_button.dart';
import '../../../../res/widget/general_execption_widget.dart';
import '../../../../res/widget/not_found/not_found_widget.dart';
import '../../../../res/widget/textfield/app_text_field.dart';
import '../../../../viewmodel/admin/claim/warehouse_claim_viewmodel.dart';
import '../../../Branch/drawer/claims/view_warehouse_claim.dart';

class MWarehouseClaimScreen extends StatefulWidget {
  const MWarehouseClaimScreen({super.key});

  @override
  State<MWarehouseClaimScreen> createState() => _MWarehouseClaimScreenState();
}

class _MWarehouseClaimScreenState extends State<MWarehouseClaimScreen> {
  Future<void> refresh() async {
    Get.put(WearhouseClaimViewModel()).refreshApi();
  }

  @override
  void initState() {
    super.initState();
    Get.put(WearhouseClaimViewModel()).getAllWarehouseClaim();
  }

  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final size = MediaQuery.sizeOf(context);
    final controller = Get.put(WearhouseClaimViewModel());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Warehouse Claim"),
      ),
      drawer: !isDesktop
          ? const SizedBox(
              width: 250,
              child: SideMenuWidgetManager(),
            )
          : null,
      body: Row(
        children: [
          isDesktop ? const Expanded(flex: 2, child: SideMenuWidgetManager()) : Container(),
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
                            labelText: "Search Warehouse",
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
                            onTap: () => WarehouseClaimExport().printPdf(),
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
                  Expanded(child: Obx(() {
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
                        var filteredStocks = controller.warehouseClaimList.value.body!.claimsFromWarehouses!.where((data) {
                          return controller.search.value.text.isEmpty || (data.claimFrom != null && data.claimFrom!.name!.toLowerCase().contains(controller.search.value.text.trim().toLowerCase()));
                        }).toList();
                        return filteredStocks.isEmpty ?
                        NotFoundWidget(title: "Warehouse Not Found") :
                        ListView.builder(
                          itemCount: controller.warehouseClaimList.value.body!.claimsFromWarehouses!.length,
                          itemBuilder: (context, index) {
                            var warehouseClaim = controller.warehouseClaimList.value.body!.claimsFromWarehouses![index];
                            if (controller.search.value.text.isEmpty ||
                                warehouseClaim.claimFrom!.name
                                    .toString()
                                    .contains(controller.search.value.text
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
                                          text:
                                          warehouseClaim.claimFrom!.name ?? "",
                                          textColor: Colors.black,
                                        ),
                                        CustomTableCell(
                                          text: warehouseClaim.product != null ? warehouseClaim.product!.name : "null",
                                          textColor: Colors.black,
                                        ),
                                        CustomTableCell(
                                          text: warehouseClaim.color != null ? warehouseClaim.color!.name : "null",
                                          textColor: Colors.black,
                                        ),
                                        CustomTableCell(
                                          text: warehouseClaim.size != null ? warehouseClaim.size!.number.toString() : "null",
                                          textColor: Colors.black,
                                        ),
                                        CustomTableCell(
                                          text: warehouseClaim.quantity
                                              .toString() ??
                                              "null",
                                          textColor: Colors.black,
                                        ),
                                        TableCell(
                                          child: GestureDetector(
                                            onTap: () {
                                              warehouseClaim.status == 0 ?
                                              showDialog(
                                                context: context,
                                                builder: (BuildContextcontext) {
                                                  return EditDialog(
                                                    title: "Do you want to Approve",
                                                    accept: () {
                                                      controller.updateStatus('1', warehouseClaim.id.toString());
                                                      Get.back();
                                                    },
                                                    reject: () {
                                                      controller.updateStatus('2', warehouseClaim.id.toString());
                                                      Get.back();
                                                    },
                                                  );
                                                },
                                              ) :
                                              Utils.ErrorToastMessage('do not change status');
                                            },
                                            child:
                                            CustomIcon(
                                              icons: warehouseClaim.status == 2 ? Icons.remove_circle : Icons.check_circle_rounded,
                                              color: warehouseClaim.status == 0 ? Colors.yellow : warehouseClaim.status == 1 ? Colors.green : Colors.red,
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
                                                    title: "Warehouse Claim Detail",
                                                    claimForm: warehouseClaim.claimFrom != null ? warehouseClaim.claimFrom!.name.toString() : "null",
                                                    claimTO: warehouseClaim.claimTo != null ?
                                                    warehouseClaim.claimTo!.name.toString() : "null",
                                                    product: warehouseClaim.product != null ? warehouseClaim.product!.name.toString() : "null",
                                                    brand: warehouseClaim.brand != null ? warehouseClaim.brand!.name.toString() : "null",
                                                    company: warehouseClaim.company != null ? warehouseClaim.company!.name.toString() : "null",
                                                    color: warehouseClaim.color != null ? warehouseClaim.color!.name.toString() : "null",
                                                    size: warehouseClaim.size != null ? warehouseClaim.size!.number.toString() : "null",
                                                    type: warehouseClaim.type != null ? warehouseClaim.type!.name.toString() : "null",
                                                    quantity: warehouseClaim.quantity != null ? warehouseClaim.quantity.toString() : "null",
                                                    date: warehouseClaim.date != null ? warehouseClaim.date.toString() : "null",
                                                    description: warehouseClaim.description != null ? warehouseClaim.description.toString() : "null",
                                                  );
                                                },
                                              );
                                            },
                                            child: CustomIcon(
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
                  })),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
