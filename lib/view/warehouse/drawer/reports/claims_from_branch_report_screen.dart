import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/viewmodel/warehouse/claim/claim_from_branch_view_model.dart';

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
import '../claim/export/claim_from__branch_export.dart';

class WClaimsFromBranchReportScreen extends StatefulWidget {
  const WClaimsFromBranchReportScreen({super.key});

  @override
  State<WClaimsFromBranchReportScreen> createState() =>
      _WClaimsFromBranchReportScreenState();
}

class _WClaimsFromBranchReportScreenState
    extends State<WClaimsFromBranchReportScreen> {
  String? selectType = 'Select Type';
  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final controller = Get.put(WClaimFromBranchViewModel());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Claim From Branch Report"),
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
                      return GeneralExceptionWidget(onPress: () {
                        controller.refreshApi();
                      });
                    }
                  case Status.COMPLETE:
                    return Column(
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
                                  labelText: "Search Product",
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
                                  onTap: () =>
                                      ClaimFromBranchExport().printPdf(),
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
                                    text: 'Article Name',
                                    textColor: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  CustomTableCell(
                                    text: 'Branch',
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
                          child: ListView.builder(
                            itemCount:
                                controller.claimList.value.body!.claims!.length,
                            itemBuilder: (context, index) {
                              var stock = controller
                                  .claimList.value.body!.claims![index];
                              var name = stock.product!.name.toString();

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
                                              text: stock.product != null
                                                  ? stock.product!.name
                                                  : 'null',
                                              textColor: Colors.black),
                                          CustomTableCell(
                                              text: stock.claimTo != null
                                                  ? stock.claimTo!.name
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
                                                  ? stock.description.toString()
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
                                                icons: Icons.check_circle,
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
                          ),
                        ),
                      ],
                    );
                }
              })),
        ],
      ),
    );
  }
}