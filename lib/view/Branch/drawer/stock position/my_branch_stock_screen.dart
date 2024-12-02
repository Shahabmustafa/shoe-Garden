import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/date/response/status.dart';
import 'package:sofi_shoes/res/circularindictor/circularindicator.dart';
import 'package:sofi_shoes/res/slidebar/side_menu_branch.dart';
import 'package:sofi_shoes/res/widget/general_execption_widget.dart';
import 'package:sofi_shoes/res/widget/not_found/not_found_widget.dart';

import '../../../../res/imageurl/image.dart';
import '../../../../res/responsive.dart';
import '../../../../res/tabletext/table_text.dart';
import '../../../../res/widget/app_boxes.dart';
import '../../../../res/widget/app_import_button.dart';
import '../../../../res/widget/textfield/app_text_field.dart';
import '../../../../viewmodel/branch/stock_position/all_branch_stock_viewmodel.dart';
import '../stock position/export/only_branch_stock_export.dart';

class MyBranchStockScreen extends StatefulWidget {
  const MyBranchStockScreen({super.key});

  @override
  State<MyBranchStockScreen> createState() => _MyBranchStockScreenState();
}

class _MyBranchStockScreenState extends State<MyBranchStockScreen> {
  TextEditingController search = TextEditingController();
  String searchValue = "";

  final controller = Get.put(AllBranchStockViewModel());

  @override
  void initState() {
    super.initState();
    controller.getMyBranchStock();
  }
  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Branch Stock"),
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
                      Flexible(
                        child: AppExportButton(
                          icons: Icons.add,
                          onTap: () {
                            MyBranchStockExport().printPdf();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Obx((){
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    child: Row(
                      children: [
                        Flexible(
                          child: AppBoxes(
                            title: "Total Item Remaining Quantity",
                            amount: controller.myBranchStockList.value.body?.sumOfQuantity.toString() ?? "0",
                            imageUrl: TImageUrl.imgProductT,
                          ),
                        ),
                        SizedBox(width: 20,),
                        Flexible(
                          child: AppBoxes(
                            title: "Total Item Sale Prices",
                            amount: controller.myBranchStockList.value.body?.sumOfSalePrice.toString() ?? "0",
                            imageUrl: TImageUrl.imgsaleI,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                            text: 'Products',
                            textColor: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          CustomTableCell(
                            text: 'Sale Price',
                            textColor: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          CustomTableCell(
                            text: 'Company',
                            textColor: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          CustomTableCell(
                            text: "Brand",
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
                  child: Obx(() {
                    switch (controller.rxRequestStatus.value) {
                      case Status.LOADING:
                        return const Center(
                          child: CircularIndicator.waveSpinkit,
                        );
                      case Status.ERROR:
                        return GeneralExceptionWidget(
                          errorMessage: controller.error.value.toString(),
                          onPress: () {
                            controller.refreshMyBranchStockApi();
                          },
                        );
                      case Status.COMPLETE:
                        var branchStocks = controller.myBranchStockList.value.body?.branchStocks ?? [];

                        // Filter branch stocks based on search input
                        var filteredStocks = branchStocks.where((data) {
                          var productName = data?.product?.name?.toLowerCase() ?? "";
                          return search.text.isEmpty ||
                              productName.contains(search.text.trim().toLowerCase());
                        }).toList();

                        // Display a message if no branch stocks match the search
                        if (filteredStocks.isEmpty) {
                          return NotFoundWidget(title: "No Branch Stocks Found");
                        }
                        return ListView.builder(
                          itemCount: filteredStocks.length,
                          itemBuilder: (context, index) {
                            var data = filteredStocks[index];
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
                                        text: data?.product?.name.toString() ?? "Null",
                                        textColor: Colors.black,
                                      ),
                                      CustomTableCell(
                                        text: data.product?.salePrice.toString() ?? "0",
                                        textColor: Colors.black,
                                      ),
                                      CustomTableCell(
                                        text: data.company?.name?.toString() ?? "Null",
                                        textColor: Colors.black,
                                      ),
                                      CustomTableCell(
                                        text: data.brand?.name?.toString() ?? "Null",
                                        textColor: Colors.black,
                                      ),
                                      CustomTableCell(
                                        text: data.color?.name.toString() ?? "Null",
                                        textColor: Colors.black,
                                      ),
                                      CustomTableCell(
                                        text: data?.type?.name.toString() ?? "Null",
                                        textColor: Colors.black,
                                      ),
                                      CustomTableCell(
                                        text: data?.size?.number.toString() ?? "Null",
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
                          },
                        );
                    }
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
