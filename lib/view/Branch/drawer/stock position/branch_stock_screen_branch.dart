import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sofi_shoes/date/response/status.dart';
import 'package:sofi_shoes/res/circularindictor/circularindicator.dart';
import 'package:sofi_shoes/res/widget/general_execption_widget.dart';
import 'package:sofi_shoes/res/widget/not_found/not_found_widget.dart';
import 'package:sofi_shoes/viewmodel/branch/stock_position/all_branch_stock_viewmodel.dart';

import '../../../../res/responsive.dart';
import '../../../../res/slidebar/side_menu_branch.dart';
import '../../../../res/tabletext/table_text.dart';
import '../../../../res/widget/textfield/app_text_field.dart';

class BBranchStockScreen extends StatefulWidget {
  const BBranchStockScreen({super.key});

  @override
  State<BBranchStockScreen> createState() => _BBranchStockScreenState();
}

class _BBranchStockScreenState extends State<BBranchStockScreen> {
  TextEditingController search = TextEditingController();
  final controller = Get.put(AllBranchStockViewModel());
  String searchValue = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getAllBranchStock();
  }
  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Differance Branch Stock"),
      ),
      drawer: !isDesktop ? const SizedBox(width: 250, child: SideMenuWidgetBranch(),) : null,
      body: Row(
        children: [
          isDesktop ? const Expanded(flex: 2, child: SideMenuWidgetBranch()) : Container(),
          Expanded(
            flex: 8,
            child: Obx(() {
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
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: AppTextField(
                                labelText: "Search Product",
                                controller: search,
                                prefixIcon: Icon(Icons.search),
                                search: true,
                                onChanged: (value) {
                                  setState(() {});
                                  searchValue = value;
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
                            5: FlexColumnWidth(1.5),
                            6: FlexColumnWidth(1.5),
                            7: FlexColumnWidth(1.5),
                            8: FlexColumnWidth(1.5),
                          },
                          border: TableBorder.all(
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
                                  text: 'Product',
                                  textColor: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                CustomTableCell(
                                  text: 'Company',
                                  textColor: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                CustomTableCell(
                                  text: 'Brand',
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
                                  text: 'Type',
                                  textColor: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                CustomTableCell(
                                  text: 'Re.Quantity',
                                  textColor: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: search.text.isNotEmpty
                            ? (controller.branchStockList.value.body?.branchStocks?.any((data) {
                          var productName = data.product?.name.toString() ?? "Null";
                          return productName.toLowerCase().contains(search.text.trim().toLowerCase());
                        }) ?? false)
                            ? ListView.builder(
                          itemCount: controller.branchStockList.value.body?.branchStocks?.length,
                          itemBuilder: (context, index) {
                            var data = controller.branchStockList.value.body?.branchStocks?[index];
                            var productName = data?.product?.name.toString() ?? "Null";
                            if (productName.toLowerCase().contains(search.text.trim().toLowerCase())) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2.5),
                                child: Table(
                                  columnWidths: const {
                                    0: FlexColumnWidth(1),
                                    1: FlexColumnWidth(2),
                                    2: FlexColumnWidth(2),
                                    3: FlexColumnWidth(2),
                                    4: FlexColumnWidth(2),
                                    5: FlexColumnWidth(1.5),
                                    6: FlexColumnWidth(1.5),
                                    7: FlexColumnWidth(1.5),
                                    8: FlexColumnWidth(1.5),
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
                                          text: data?.branch?.name.toString() ?? "Null",
                                          textColor: Colors.black,
                                        ),
                                        CustomTableCell(
                                          text: data?.product?.name.toString() ?? "Null",
                                          textColor: Colors.black,
                                        ),
                                        CustomTableCell(
                                          text: data?.company?.name.toString() ?? "Null",
                                          textColor: Colors.black,
                                        ),
                                        CustomTableCell(
                                          text: data?.brand?.name.toString() ?? "Null",
                                          textColor: Colors.black,
                                        ),
                                        CustomTableCell(
                                          text: data?.color?.name.toString() ?? "Null",
                                          textColor: Colors.black,
                                        ),
                                        CustomTableCell(
                                          text: data?.size?.number.toString() ?? "Null",
                                          textColor: Colors.black,
                                        ),
                                        CustomTableCell(
                                          text: data?.type?.name.toString() ?? "Null",
                                          textColor: Colors.black,
                                        ),
                                        CustomTableCell(
                                          text: data?.remainingQuantity?.toString() ?? "Null",
                                          textColor: Colors.black,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }
                            return SizedBox.shrink(); // Return an empty widget if not matching
                          },
                        )
                            : NotFoundWidget(title: "Product Not Found",)
                            : Center(
                          child: Text(
                            "Search Product Other Branches",
                            style: GoogleFonts.lato(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
              }
            }),
          ),
        ],
      ),
    );
  }
}
