import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sofi_shoes/date/response/status.dart';
import 'package:sofi_shoes/res/circularindictor/circularindicator.dart';
import 'package:sofi_shoes/res/widget/general_execption_widget.dart';
import 'package:sofi_shoes/viewmodel/report/profit_loss_viewmodel.dart';

import '../../../../res/imageurl/image.dart';
import '../../../../res/responsive.dart';
import '../../../../res/slidebar/side_menu_admin.dart';
import '../../../../res/tabletext/table_text.dart';
import '../../../../res/widget/app_boxes.dart';
import '../../../../res/widget/app_drop_down.dart';
import '../../../../res/widget/app_import_button.dart';
import '../../../../res/widget/date_time_picker.dart';
import '../../../Manager/drawer/dashboard/dashboard_screen_a.dart';
import 'export/profit_and_loss_export.dart';

class ProfitOrLossReport extends StatefulWidget {
  const ProfitOrLossReport({super.key});

  @override
  State<ProfitOrLossReport> createState() => _ProfitOrLossReportState();
}

class _ProfitOrLossReportState extends State<ProfitOrLossReport> {
  final controller = Get.put(ProfitOrLossVeiwModel());

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profit Or Loss Report"),
      ),
      drawer: !isDesktop
          ? const SizedBox(
              width: 250,
              child: SideMenuWidgetAdmin(),
            )
          : null,
      body: Row(
        children: [
          isDesktop
              ? const Expanded(flex: 2, child: SideMenuWidgetAdmin())
              : Container(),
          Expanded(
            flex: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: DateTimePicker(
                          hintText: 'From Date',
                          onTap: () {
                            controller.selectDate(context, true);
                            // controller.getProfitOrLoss();
                          },
                          controller: controller.startDate.value,
                        ),
                      ),
                      Flexible(
                        child: DateTimePicker(
                          hintText: 'To Date',
                          onTap: () {
                            controller.selectDate(context, false);
                            // controller.getProfitOrLoss();
                          },
                          controller: controller.endDate.value,
                        ),
                      ),
                      Flexible(
                        child: AppExportButton(
                          icons: Icons.add,
                          onTap: () => ProfitAndLossExport().printPdf(),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Obx(() {
                          return AppDropDown(
                            labelText: "Select Branch",
                            items: controller.dropdownItemsBranch.map<String>((item) => item['name'].toString()).toList(),
                            selectedItem: controller.selectBranchName.value.isEmpty ? null : controller.selectBranchName.value,
                            onChanged: (branchName) {
                              controller.selectBranchName.value = branchName.toString();

                              // clear warehouse dropdown name clear
                              controller.selectWarehouseName.value = '';

                              controller.startDate.value.clear();
                              controller.endDate.value.clear();
                              var selectBranch = controller.dropdownItemsBranch.firstWhere((items) => items['name'].toString() == branchName, orElse: () => null,);
                              if (selectBranch != null) {
                                controller.selectSpecific.value = selectBranch['id'].toString();
                                controller.getProfitOrLoss();
                                controller.selectSpecific.isEmpty;
                              }
                            },
                          );
                        }),
                      ),
                      Flexible(
                        child: Obx(() {
                          return AppDropDown(
                            labelText: "Select Warehouse",
                            items: controller.dropdownItemsWarehouse.map<String>((item) => item['name'].toString()).toList(),
                            selectedItem: controller.selectWarehouseName.value.isEmpty ? null : controller.selectWarehouseName.value,
                            onChanged: (warehouseName) {
                              // clear warehouse dropdown name clear
                              controller.startDate.value.clear();
                              controller.endDate.value.clear();
                              controller.selectBranchName.value = '';
                              controller.selectWarehouseName.value = warehouseName.toString();
                              var selectWarehouse =
                                  controller.dropdownItemsWarehouse.firstWhere(
                                (items) =>
                                    items['name'].toString() == warehouseName,
                                orElse: () => null,
                              );
                              if (selectWarehouse != null) {
                                controller.selectSpecific.value = selectWarehouse['id'].toString();
                                controller.getProfitOrLoss();
                              }
                            },
                          );
                        }),
                      ),
                    ],
                  ),
                ),
                Obx(() {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      children: [
                        Flexible(
                          child: AppBoxes(
                            title: "Profit and Loss Balance",
                            width: 350,
                            amount: controller
                                    .profitOrLossList.value.body?.profitLoss
                                    .toString() ??
                                "0",
                            imageUrl: TImageUrl.imgProductT,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Table(
                    columnWidths: const {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(3),
                      2: FlexColumnWidth(3),
                      3: FlexColumnWidth(2),
                      4: FlexColumnWidth(2),
                      5: FlexColumnWidth(2),
                      6: FlexColumnWidth(2),
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
                            text: 'Warehouse/Branch',
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
                            text: 'Total Amount',
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
                  child: Obx(() {
                    switch (controller.rxRequestStatus.value) {
                      case Status.LOADING:
                        return const Center(
                            child: CircularIndicator.waveSpinkit);
                      case Status.ERROR:
                        return GeneralExceptionWidget(
                            errorMessage: controller.error.value.toString(),
                            onPress: () {
                              controller.refreshProfitLossApi();
                            });
                      case Status.COMPLETE:
                        return ListView.builder(
                          itemCount: controller
                              .profitOrLossList.value.body!.products!.length,
                          itemBuilder: (context, index) {
                            var profitOrLossList = controller
                                .profitOrLossList.value.body!.products![index];
                            var branchId = profitOrLossList.saleInvoice != null
                                ? profitOrLossList.saleInvoice!.branchId
                                : "Null";
                            if (controller.selectSpecific.value.isEmpty ||
                                branchId.toString().toLowerCase().contains(
                                    controller.selectSpecific.value
                                        .toLowerCase())) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 2.5),
                                child: Table(
                                  columnWidths: const {
                                    0: FlexColumnWidth(1),
                                    1: FlexColumnWidth(3),
                                    2: FlexColumnWidth(3),
                                    3: FlexColumnWidth(2),
                                    4: FlexColumnWidth(2),
                                    5: FlexColumnWidth(2),
                                    6: FlexColumnWidth(2),
                                    7: FlexColumnWidth(1),
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
                                          text: profitOrLossList.saleInvoice !=
                                                  null
                                              ? profitOrLossList
                                                  .saleInvoice!.branch!.name
                                                  .toString()
                                              : "Null",
                                          textColor: Colors.black,
                                        ),
                                        CustomTableCell(
                                          text: profitOrLossList.product != null
                                              ? profitOrLossList.product!.name
                                                  .toString()
                                              : "Null",
                                          textColor: Colors.black,
                                        ),
                                        CustomTableCell(
                                          text: profitOrLossList.color != null
                                              ? profitOrLossList.color!.name
                                                  .toString()
                                              : "Null",
                                          textColor: Colors.black,
                                        ),
                                        CustomTableCell(
                                          text: profitOrLossList.color != null
                                              ? profitOrLossList.size!.number
                                                  .toString()
                                              : "Null",
                                          textColor: Colors.black,
                                        ),
                                        CustomTableCell(
                                          text:
                                              profitOrLossList.quantity != null
                                                  ? profitOrLossList.quantity
                                                      .toString()
                                                  : "Null",
                                          textColor: Colors.black,
                                        ),
                                        CustomTableCell(
                                          text: profitOrLossList.totalAmount !=
                                                  null
                                              ? profitOrLossList.totalAmount!
                                                  .toString()
                                              : "Null",
                                          textColor: Colors.black,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return ViewProfitLoss(
                                                  title: "Profit Loss Detail",
                                                  productName: profitOrLossList
                                                              .product !=
                                                          null
                                                      ? profitOrLossList
                                                          .product!.name
                                                          .toString()
                                                      : "Null",
                                                  purchasePrice:
                                                      profitOrLossList
                                                                  .product !=
                                                              null
                                                          ? profitOrLossList
                                                              .product!
                                                              .purchasePrice
                                                              .toString()
                                                          : "Null",
                                                  salePrice: profitOrLossList
                                                              .product !=
                                                          null
                                                      ? profitOrLossList
                                                          .product!.salePrice
                                                          .toString()
                                                      : "Null",
                                                  brand:
                                                      profitOrLossList.brand !=
                                                              null
                                                          ? profitOrLossList
                                                              .brand!.name
                                                              .toString()
                                                          : "Null",
                                                  company: profitOrLossList
                                                              .company !=
                                                          null
                                                      ? profitOrLossList
                                                          .company!.name
                                                          .toString()
                                                      : "Null",
                                                  color:
                                                      profitOrLossList.color !=
                                                              null
                                                          ? profitOrLossList
                                                              .color!.name
                                                              .toString()
                                                          : "Null",
                                                  size: profitOrLossList.size !=
                                                          null
                                                      ? profitOrLossList
                                                          .size!.number
                                                          .toString()
                                                      : "Null",
                                                  type: profitOrLossList.type !=
                                                          null
                                                      ? profitOrLossList
                                                          .type!.name
                                                          .toString()
                                                      : "Null",
                                                  quantity: profitOrLossList
                                                              .quantity !=
                                                          null
                                                      ? profitOrLossList
                                                          .quantity!
                                                          .toString()
                                                      : "Null",
                                                  totalSale: profitOrLossList
                                                              .totalAmount !=
                                                          null
                                                      ? profitOrLossList
                                                          .totalAmount
                                                          .toString()
                                                      : "Null",
                                                  invoiceId: profitOrLossList
                                                              .saleInvoiceId !=
                                                          null
                                                      ? profitOrLossList
                                                          .saleInvoiceId!
                                                          .toString()
                                                      : "Null",
                                                  subTotal: profitOrLossList
                                                              .subTotal !=
                                                          null
                                                      ? profitOrLossList
                                                          .subTotal!
                                                          .toString()
                                                      : "Null",
                                                );
                                              },
                                            );
                                          },
                                          child: const CustomIcon(
                                            icons: Icons.visibility,
                                            color: Colors.green,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }
                            return null;
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

class ViewProfitLoss extends StatelessWidget {
  ViewProfitLoss(
      {required this.title,
      required this.productName,
      required this.purchasePrice,
      required this.salePrice,
      required this.brand,
      required this.company,
      required this.color,
      required this.size,
      required this.type,
      required this.quantity,
      required this.totalSale,
      required this.invoiceId,
      required this.subTotal,
      super.key});
  String title;
  String productName;
  String purchasePrice;
  String salePrice;
  String brand;
  String company;
  String color;
  String size;
  String type;
  String quantity;
  String totalSale;
  String invoiceId;
  String subTotal;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: TextEditingController(text: invoiceId),
              style: GoogleFonts.lato(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              decoration: InputDecoration(label: Text("Invoice Id")),
              enabled: false,
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: TextEditingController(text: productName),
              style: GoogleFonts.lato(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              decoration: InputDecoration(label: Text("Product Name")),
              enabled: false,
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: TextEditingController(text: purchasePrice),
              style: GoogleFonts.lato(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              decoration:
                  InputDecoration(label: Text("Product Purchase Price")),
              enabled: false,
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: TextEditingController(text: salePrice),
              style: GoogleFonts.lato(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              decoration: InputDecoration(label: Text("Sale Price")),
              enabled: false,
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: TextEditingController(text: brand),
              style: GoogleFonts.lato(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              decoration: InputDecoration(label: Text("Brand Name")),
              enabled: false,
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: TextEditingController(text: company),
              style: GoogleFonts.lato(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              decoration: InputDecoration(label: Text("Company Name")),
              enabled: false,
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: TextEditingController(text: color),
              style: GoogleFonts.lato(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              decoration: InputDecoration(label: Text("Color Name")),
              enabled: false,
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: TextEditingController(text: size),
              style: GoogleFonts.lato(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              decoration: InputDecoration(label: Text("Size Number")),
              enabled: false,
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: TextEditingController(text: type),
              style: GoogleFonts.lato(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              decoration: InputDecoration(label: Text("Type")),
              enabled: false,
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: TextEditingController(text: quantity),
              style: GoogleFonts.lato(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              decoration: InputDecoration(label: Text("Quantity")),
              enabled: false,
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: TextEditingController(text: totalSale),
              style: GoogleFonts.lato(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              decoration: InputDecoration(label: Text("Total Sale")),
              enabled: false,
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: TextEditingController(text: subTotal),
              style: GoogleFonts.lato(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              decoration: InputDecoration(label: Text("Sub Total")),
              enabled: false,
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
