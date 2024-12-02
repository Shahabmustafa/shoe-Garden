import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sofi_shoes/date/response/status.dart';
import 'package:sofi_shoes/res/slidebar/side_menu_branch.dart';
import 'package:sofi_shoes/res/widget/general_execption_widget.dart';

import '../../../../res/circularindictor/circularindicator.dart';
import '../../../../res/imageurl/image.dart';
import '../../../../res/responsive.dart';
import '../../../../res/tabletext/table_text.dart';
import '../../../../res/widget/app_boxes.dart';
import '../../../../res/widget/app_import_button.dart';
import '../../../../res/widget/textfield/app_text_field.dart';
import '../../../../viewmodel/branch/stock_position/all_branch_stock_viewmodel.dart';
import '../stock position/export/only_branch_stock_export.dart';

class BStockInventoryReport extends StatefulWidget {
  const BStockInventoryReport({super.key});

  @override
  State<BStockInventoryReport> createState() => _BStockInventoryReportState();
}

class _BStockInventoryReportState extends State<BStockInventoryReport> {
  TextEditingController search = TextEditingController();
  final controller = Get.put(AllBranchStockViewModel());
  String searchValue = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getMyBranchStock();
  }
  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stock Inventory Report"),
      ),
      drawer: !isDesktop
          ? const SizedBox(
              width: 250,
              child: SideMenuWidgetBranch(),
            )
          : null,
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
                          labelText: "Search Name",
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
                      8: FlexColumnWidth(1),
                      9: FlexColumnWidth(1),
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
                            text: 'Quantity',
                            textColor: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          CustomTableCell(
                            text: 'R.Quantity',
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
                              controller.refreshMyBranchStockApi();
                            });
                      case Status.COMPLETE:
                        return controller.myBranchStockList.value.body!.branchStocks!.isNotEmpty ?
                        ListView.builder(
                          itemCount: controller.myBranchStockList.value.body?.branchStocks?.length,
                          itemBuilder: (context, index) {
                            var data = controller.myBranchStockList.value.body?.branchStocks?[index];
                            var productName = data?.product != null ? data?.product?.name.toString() : "Null";
                            if (search.text.isEmpty || productName!.toLowerCase().contains(search.text.trim().toLowerCase())) {
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
                                    8: FlexColumnWidth(1),
                                    9: FlexColumnWidth(1),
                                  },
                                  border: TableBorder.all(
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
                                          text: data?.product?.name.toString() ?? "Null",
                                          textColor: Colors.black,
                                        ),
                                        CustomTableCell(
                                          text: data?.product?.salePrice.toString() ?? "Null",
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
                                          text: data?.quantity?.toString() ?? "0",
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
                            return null;
                          },
                        ) :
                        Center(
                          child: Text(
                            "Branch Stocks is Not Available",
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                        );;
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
