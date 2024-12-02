import 'package:flutter/material.dart';
import 'package:sofi_shoes/date/repository/branch/stocks/branch_stock_repository.dart';
import 'package:sofi_shoes/res/circularindictor/circularindicator.dart';
import 'package:sofi_shoes/res/slidebar/side_menu_branch.dart';

import '../../../../res/responsive.dart';
import '../../../../res/tabletext/table_text.dart';
import '../../../../res/widget/app_import_button.dart';
import '../../../../res/widget/textfield/app_text_field.dart';
import '../../../../viewmodel/excel/excel_viewmodel.dart';

class BStockInventoryScreen extends StatefulWidget {
  const BStockInventoryScreen({super.key});

  @override
  State<BStockInventoryScreen> createState() => _BStockInventoryScreenState();
}

class _BStockInventoryScreenState extends State<BStockInventoryScreen> {
  TextEditingController search = TextEditingController();
  String searchValue = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stock Inventory"),
      ),
      drawer: !isDesktop
          ? const SizedBox(
              width: 250,
              child: SideMenuWidgetBranch(),
            )
          : null,
      body: Row(
        children: [
          isDesktop
              ? const Expanded(flex: 2, child: SideMenuWidgetBranch())
              : Container(),
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
                          onTap: () => ExcelController().exportToExcel(),
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
                      0: FlexColumnWidth(1.5),
                      1: FlexColumnWidth(2),
                      2: FlexColumnWidth(2),
                      3: FlexColumnWidth(2),
                      4: FlexColumnWidth(2),
                      5: FlexColumnWidth(2),
                      // 6: FlexColumnWidth(1.5),
                      // 7: FlexColumnWidth(1.5),5
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
                            text: 'Products',
                            textColor: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          CustomTableCell(
                            text: 'Company',
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
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: FutureBuilder(
                  future: BStockInventoryRepository().getAll(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.body!.branchStocks!.length,
                        itemBuilder: (context, index) {
                          var data = snapshot.data!.body!.branchStocks![index];
                          print(snapshot.error);
                          if (search.text.isEmpty ||
                              data.product!.name!
                                  .toLowerCase()
                                  .contains(search.text.trim().toLowerCase())) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 2.5),
                              child: Table(
                                columnWidths: const {
                                  0: FlexColumnWidth(1.5),
                                  1: FlexColumnWidth(2),
                                  2: FlexColumnWidth(2),
                                  3: FlexColumnWidth(2),
                                  4: FlexColumnWidth(2),
                                  5: FlexColumnWidth(2),
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
                                        text: data.product == null
                                            ? "Product is Null"
                                            : data.product!.name.toString(),
                                        textColor: Colors.black,
                                      ),
                                      CustomTableCell(
                                          text: data.company == null
                                              ? "Company is Null"
                                              : data.company!.name.toString(),
                                          textColor: Colors.black),
                                      CustomTableCell(
                                        text: data.type == null
                                            ? "Type is Null"
                                            : data.type!.name.toString(),
                                        textColor: Colors.black,
                                      ),
                                      CustomTableCell(
                                        text: data.size == null
                                            ? "Size is Null"
                                            : data.size!.number.toString(),
                                        textColor: Colors.black,
                                      ),
                                      CustomTableCell(
                                        text: data.quantity == null
                                            ? ""
                                            : data.quantity.toString(),
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
                      );
                    } else {
                      return const Center(child: CircularIndicator.waveSpinkit);
                    }
                  },
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
