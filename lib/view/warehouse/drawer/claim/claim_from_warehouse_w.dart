import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sofi_shoes/res/widget/not_found/not_found_widget.dart';
import 'package:sofi_shoes/view/warehouse/drawer/claim/export/claim_to_warehouse_export.dart';
import 'package:sofi_shoes/viewmodel/warehouse/claim/claim_from_another_warehouse_view_model.dart';

import '../../../../date/response/status.dart';
import '../../../../res/circularindictor/circularindicator.dart';
import '../../../../res/responsive.dart';
import '../../../../res/slidebar/side_menu_warehouse.dart';
import '../../../../res/tabletext/table_text.dart';
import '../../../../res/widget/app_import_button.dart';
import '../../../../res/widget/general_execption_widget.dart';
import '../../../../res/widget/internet_execption_widget.dart';
import '../../../../res/widget/textfield/app_text_field.dart';
import '../../../Manager/drawer/dashboard/dashboard_screen_a.dart';

class ClaimFromWarehouseScreenWarehouse extends StatefulWidget {
  const ClaimFromWarehouseScreenWarehouse({super.key});

  @override
  State<ClaimFromWarehouseScreenWarehouse> createState() =>
      _ClaimFromWarehouseScreenWarehouseState();
}

class _ClaimFromWarehouseScreenWarehouseState
    extends State<ClaimFromWarehouseScreenWarehouse> {
  String? selectType = 'Select Type';
  Future<void> refresh() async {
    Get.put(WClaimFromAnotherWarehouseViewModel()).refreshApi();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final controller = Get.put(WClaimFromAnotherWarehouseViewModel());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Claim From Warehouse"),
      ),
      drawer: !isDesktop
          ? const SizedBox(
              width: 250,
              child: SideMenuWidgetWarehouse(),
            )
          : null,
      body: Row(
        children: [
          isDesktop
              ? const Expanded(flex: 2, child: SideMenuWidgetWarehouse())
              : Container(),
          Expanded(
              flex: 8,
              child: Obx(() {
                switch (controller.rxRequestStatus.value) {
                  case Status.LOADING:
                    return const Center(child: CircularIndicator.waveSpinkit);
                  case Status.ERROR:
                    if (controller.error.value == 'No internet') {
                      return InterNetExceptionWidget(onPress: () {
                        return controller.refreshApi();
                      });
                    } else {
                      return GeneralExceptionWidget(
                          errorMessage: controller.error.value.toString(),
                          onPress: () {
                            controller.refreshApi();
                          });
                    }
                  case Status.COMPLETE:
                    final filteredClaims = controller.claimList.value.body!.claims!
                        .where((stock) {
                      var name = stock.claimTo != null ? stock.claimTo!.name.toString() : "";
                      return controller.search.value.text.isEmpty || name.toLowerCase().contains(controller.search.value.text.trim().toLowerCase());
                    }).toList();
                    return RefreshIndicator(
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
                                    prefixIcon: Icon(Icons.search),
                                    onChanged: (value) {
                                      setState(() {});
                                      controller.searchValue.value = value;
                                    },
                                  ),
                                ),
                                Flexible(
                                  child: AppExportButton(
                                    icons: Icons.add,
                                    onTap: () =>
                                        ClaimFromWarehouuseExport().printPdf(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: Table(
                              columnWidths: const {
                                0: FlexColumnWidth(1),
                                1: FlexColumnWidth(2),
                                2: FlexColumnWidth(2),
                                3: FlexColumnWidth(2),
                                4: FlexColumnWidth(2),
                                5: FlexColumnWidth(2),
                                6: FlexColumnWidth(2),
                                7: FlexColumnWidth(2),
                                8: FlexColumnWidth(2),
                                9: FlexColumnWidth(2),
                                10: FlexColumnWidth(1.5),
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
                                      text: 'Warehouse',
                                      textColor: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    CustomTableCell(
                                      text: 'Article',
                                      textColor: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    CustomTableCell(
                                      text: 'Brand',
                                      textColor: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    CustomTableCell(
                                      text: 'Type',
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
                                      text: 'Date',
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
                            child: controller.claimList.value.body!.claims!.isNotEmpty ?
                            filteredClaims.isEmpty ?
                            NotFoundWidget(title: "Warehouse Not Found") :
                            ListView.builder(
                              itemCount: controller.claimList.value.body!.claims!.length,
                              itemBuilder: (context, index) {
                                var stock = controller.claimList.value.body!.claims![index];
                                var name = stock.claimTo!.name.toString();
                                if (controller.search.value.text.isEmpty || name.toLowerCase().contains(controller.search.value.text.trim().toLowerCase())) {
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
                                        6: FlexColumnWidth(2),
                                        7: FlexColumnWidth(2),
                                        8: FlexColumnWidth(2),
                                        9: FlexColumnWidth(2),
                                        10: FlexColumnWidth(1.5),
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
                                                textColor: Colors.black),
                                            CustomTableCell(
                                                text: stock.claimTo != null
                                                    ? stock.claimTo!.name
                                                    : 'null',
                                                textColor: Colors.black),
                                            CustomTableCell(
                                                text: stock.product != null
                                                    ? stock.product!.name
                                                    : 'null',
                                                textColor: Colors.black),
                                            CustomTableCell(
                                                text: stock.brand != null
                                                    ? stock.brand!.name
                                                    : 'null',
                                                textColor: Colors.black),
                                            CustomTableCell(
                                                text: stock.type != null
                                                    ? stock.type!.name
                                                    : 'null',
                                                textColor: Colors.black),
                                            CustomTableCell(
                                                text: stock.color != null
                                                    ? stock.color!.name
                                                    : 'null',
                                                textColor: Colors.black),
                                            CustomTableCell(
                                                text: stock.size != null
                                                    ? stock.size!.number
                                                        .toString()
                                                    : 'null',
                                                textColor: Colors.black),
                                            CustomTableCell(
                                                text: stock.quantity != null
                                                    ? stock.quantity.toString()
                                                    : 'null',
                                                textColor: Colors.black),
                                            CustomTableCell(
                                                text: stock.description != null
                                                    ? stock.description
                                                        .toString()
                                                    : 'null',
                                                textColor: Colors.black),
                                            CustomTableCell(
                                                text: stock.date != null
                                                    ? stock.date.toString()
                                                    : 'null',
                                                textColor: Colors.black),
                                            TableCell(
                                              child: InkWell(
                                                child: CustomIcon(
                                                  icons: stock.status == 2
                                                      ? Icons.remove_circle
                                                      : Icons
                                                          .check_circle_rounded,
                                                  color: stock.status == 0
                                                      ? Colors.yellow
                                                      : stock.status == 1
                                                          ? Colors.green
                                                          : Colors.red,
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
                            ) :
                            Center(
                              child: Text(
                                "Claim from Warehouse is Empty",
                                style: GoogleFonts.lato(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                }
              })),
        ],
      ),
    );
  }
}
