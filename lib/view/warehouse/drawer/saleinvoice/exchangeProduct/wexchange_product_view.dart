import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../../date/response/status.dart';
import '../../../../../res/circularindictor/circularindicator.dart';
import '../../../../../res/responsive.dart';
import '../../../../../res/slidebar/side_menu_warehouse.dart';
import '../../../../../res/tabletext/table_text.dart';
import '../../../../../res/widget/general_execption_widget.dart';
import '../../../../../res/widget/textfield/app_text_field.dart';
import '../../../../../viewmodel/branch/saleinvoice/get_data_sale_invoice_viewmodel.dart';
import '../../../../Branch/drawer/saleinvoice/export/sale_invoice_export.dart';
import '../../../../Branch/drawer/saleinvoice/sale_exchange_product_model.dart';
import '../../../../Manager/drawer/dashboard/dashboard_screen_a.dart';
import 'add_exchange_product_w.dart';

class WExchangeProductScreen extends StatefulWidget {
  const WExchangeProductScreen({super.key});

  @override
  State<WExchangeProductScreen> createState() => _WExchangeProductScreenState();
}

class _WExchangeProductScreenState extends State<WExchangeProductScreen> {
  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final controller = Get.put(GetDataSaleInvoiceViewmodel());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Exchange Product"),
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
                  return GeneralExceptionWidget(
                      errorMessage: controller.error.value.toString(),
                      onPress: () {
                        controller.refreshApi();
                      });
                case Status.COMPLETE:
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: Row(
                            children: [
                              Flexible(
                                child: AppTextField(
                                  controller: controller.search.value,
                                  labelText: "Search c.name or invoiceNo.",
                                  search: true,
                                  prefixIcon: const Icon(Icons.search),
                                  onChanged: (value) {
                                    setState(() {
                                      controller.searchValue.value = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
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
                                    text: 'Invoice No',
                                    textColor: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  CustomTableCell(
                                    text: 'Customer',
                                    textColor: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  CustomTableCell(
                                    text: 'Salesman',
                                    textColor: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  CustomTableCell(
                                    text: 'Date',
                                    textColor: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  CustomTableCell(
                                    text: 'Payment Method',
                                    textColor: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  CustomTableCell(
                                    text: 'View',
                                    textColor: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  CustomTableCell(
                                    text: 'Edit',
                                    textColor: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  CustomTableCell(
                                    text: 'Print',
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
                            itemCount: controller
                                .saleInvoiceList.value.body!.invoice!.length,
                            itemBuilder: (context, index) {
                              final invoice = controller
                                  .saleInvoiceList.value.body!.invoice![index];
                              String dateTimeString =
                                  invoice.createdAt.toString();
                              DateTime dateTime =
                                  DateTime.parse(dateTimeString);
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(dateTime);
                              final invoiceData = InvoiceExport(
                                id: invoice.invoiceNumber.toString(),
                                date: DateTime.now(),
                                paymentMethod: invoice.paymentMethod ?? "Null",
                                saleman: Salesman(
                                    name: invoice.saleman != null
                                        ? invoice.saleman!.name
                                        : 'null'),
                                customer: Customer(
                                    name: invoice.customer != null
                                        ? invoice.customer!.name
                                        : 'null'),
                                total: invoice.totalAmount.toString(),
                                items: invoice.invoiceProducts!.map((product) {
                                  return InvoiceItem(
                                    product: product.product != null
                                        ? product.product!.name.toString()
                                        : 'null',
                                    salePrice: product.salePrice != null
                                        ? product.salePrice.toString()
                                        : 'null',
                                    qty: int.parse(product.quantity.toString()),
                                    dis: product.discount != null
                                        ? "${product.discount}%"
                                        : "Null",
                                    subTotal: product.subTotal != null
                                        ? product.subTotal.toString()
                                        : 'null',
                                    totalAmount: product.totalAmount != null
                                        ? product.totalAmount.toString()
                                        : "null",
                                  );
                                }).toList(),
                              );

                              if (controller.search.value.text.isEmpty ||
                                  invoice.invoiceNumber!
                                      .toString()
                                      .toLowerCase()
                                      .contains(controller.search.value.text
                                          .trim()
                                          .toLowerCase()) ||
                                  invoice.customer!.name!
                                      .toString()
                                      .toLowerCase()
                                      .contains(controller.search.value.text
                                          .trim()
                                          .toLowerCase())) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
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
                                          8: FlexColumnWidth(1),
                                        },
                                        border: TableBorder.all(
                                          // borderRadius: BorderRadius.circular(5),
                                          color: Colors.grey.shade300,
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
                                                text: invoice.invoiceNumber != null ? invoice.invoiceNumber.toString() : "Null",
                                                textColor: Colors.black,
                                              ),
                                              CustomTableCell(
                                                text: invoice.customer != null ? invoice.customer!.name.toString() : "Null",
                                                textColor: Colors.black,
                                              ),
                                              CustomTableCell(
                                                text: invoice.saleman != null ? invoice.saleman!.name.toString() : "Null",
                                                textColor: Colors.black,
                                              ),
                                              CustomTableCell(
                                                text: formattedDate,
                                                textColor: Colors.black,
                                              ),
                                              CustomTableCell(
                                                text: invoice.paymentMethod != null ? invoice.paymentMethod.toString() : "Null",
                                                textColor: Colors.black,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        title: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  "Invoice : ${invoice.invoiceNumber != null ? invoice.invoiceNumber.toString() : "Null"}",
                                                                  style:
                                                                      GoogleFonts
                                                                          .lato(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        14,
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Text(
                                                                  "Date : $formattedDate",
                                                                  style:
                                                                      GoogleFonts
                                                                          .lato(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        14,
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Text(
                                                                  "Payment Method : ${invoice.paymentMethod ?? "Null"}",
                                                                  style:
                                                                  GoogleFonts
                                                                      .lato(
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                    fontSize:
                                                                    14,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  "Warehouse: ${invoice.saleman != null ? invoice.saleman!.name.toString() : "Null"}",
                                                                  style:
                                                                      GoogleFonts
                                                                          .lato(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        14,
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Text(
                                                                  invoice.customer !=
                                                                          null
                                                                      ? "Customer: ${invoice.customer != null ? invoice.customer!.name.toString() : 'null'}"
                                                                      : "Null",
                                                                  style:
                                                                      GoogleFonts
                                                                          .lato(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        14,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        content:
                                                            SingleChildScrollView(
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .end,
                                                            children: [
                                                              SingleChildScrollView(
                                                                scrollDirection:
                                                                    Axis.horizontal,
                                                                child:
                                                                    DataTable(
                                                                  // columnSpacing: 16, // Adjust as needed
                                                                  // dataRowHeight: 60, // Adjust as needed
                                                                  columns: const [
                                                                    DataColumn(
                                                                      label: Text(
                                                                          'Product'),
                                                                      numeric:
                                                                          false, // Adjust based on content
                                                                    ),
                                                                    DataColumn(
                                                                      label: Text(
                                                                          'Color'),
                                                                      numeric:
                                                                          false, // Adjust based on content
                                                                    ),
                                                                    DataColumn(
                                                                      label: Text(
                                                                          'Size'),
                                                                      numeric:
                                                                          false, // Adjust based on content
                                                                    ),
                                                                    DataColumn(
                                                                      label: Text(
                                                                          'Quantity'),
                                                                      numeric:
                                                                          true, // Adjust based on content
                                                                    ),
                                                                    DataColumn(
                                                                      label: Text(
                                                                          'Sale Price'),
                                                                      numeric:
                                                                          true, // Adjust based on content
                                                                    ),
                                                                    DataColumn(
                                                                      label: Text(
                                                                          'Sub Total'),
                                                                      numeric:
                                                                          true, // Adjust based on content
                                                                    ),
                                                                    DataColumn(
                                                                      label: Text(
                                                                          'Discount'),
                                                                      numeric:
                                                                          true, // Adjust based on content
                                                                    ),
                                                                    DataColumn(
                                                                      label: Text(
                                                                          'Total Amount'),
                                                                      numeric:
                                                                          true, // Adjust based on content
                                                                    ),
                                                                  ],
                                                                  rows: invoice
                                                                              .invoiceProducts !=
                                                                          null
                                                                      ? invoice
                                                                          .invoiceProducts!
                                                                          .map(
                                                                              (product) {
                                                                          return DataRow(
                                                                            cells: [
                                                                              DataCell(
                                                                                Text(product.product != null ? product.product!.name.toString() : "Null"),
                                                                              ),
                                                                              DataCell(
                                                                                Text(product.color != null ? product.color!.name.toString() : "Null"),
                                                                              ),
                                                                              DataCell(
                                                                                Text(product.size != null ? product.size!.number.toString() : "Null"),
                                                                              ),
                                                                              DataCell(Text(product.quantity != null ? product.quantity.toString() : "Null")),
                                                                              DataCell(Text(product.product!.salePrice != null ? product.product!.salePrice.toString() : "Null")),
                                                                              DataCell(
                                                                                Text(product.subTotal != null ? product.subTotal.toString() : 'null'),
                                                                              ),
                                                                              DataCell(
                                                                                Text(
                                                                                  product.discount != null ? "${product.discount}%" : "Null", // Display discount percentage or "Null" if discount is null
                                                                                ),
                                                                              ),
                                                                              DataCell(
                                                                                Text(
                                                                                  product.totalAmount != null ? product.totalAmount.toString() : "Null",
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          );
                                                                        }).toList()
                                                                      : [],
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 30,
                                                              ),
                                                              const Divider(
                                                                color:
                                                                    Colors.grey,
                                                                thickness: 1,
                                                              ),
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  Text(
                                                                    "Sub Total",
                                                                    style:
                                                                        GoogleFonts
                                                                            .lato(
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 30,
                                                                  ),
                                                                  Text(
                                                                    invoice.subTotal !=
                                                                            null
                                                                        ? invoice
                                                                            .subTotal
                                                                            .toString()
                                                                        : "Null",
                                                                    style:
                                                                        GoogleFonts
                                                                            .lato(
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  Text(
                                                                    "Total Amount",
                                                                    style:
                                                                        GoogleFonts
                                                                            .lato(
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 30,
                                                                  ),
                                                                  Text(
                                                                    invoice.totalAmount !=
                                                                            null
                                                                        ? invoice
                                                                            .totalAmount
                                                                            .toString()
                                                                        : "Null",
                                                                    style:
                                                                        GoogleFonts
                                                                            .lato(
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  Text(
                                                                    "Received Amount",
                                                                    style:
                                                                        GoogleFonts
                                                                            .lato(
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 30,
                                                                  ),
                                                                  Text(
                                                                    invoice.totalAmount !=
                                                                            null
                                                                        ? invoice
                                                                            .receivedAmount
                                                                            .toString()
                                                                        : "Null",
                                                                    style:
                                                                        GoogleFonts
                                                                            .lato(
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),

                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
                                                child: const CustomIcon(
                                                  icons: Icons.visibility,
                                                  color: Colors.green,
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => AddExchangeProductScreenWarehouse(
                                                        uid: invoice.id.toString(),
                                                        invoiceNo: invoice.invoiceNumber.toString(),
                                                        salesmanId: invoice.saleman!.id.toString(),
                                                        salesmanName: invoice.saleman!.name.toString(),
                                                        customerId: invoice.customer!.id.toString(),
                                                        customerName: invoice.customer!.name.toString(),
                                                        receivedAmount: invoice.receivedAmount.toString(),
                                                        returnAmount: invoice.totalAmount.toString(),
                                                        products: invoice.invoiceProducts!.map((product) {
                                                          return ExchangProductItemModel(
                                                            previousProductId:
                                                            product.productId,
                                                            name: product.product?.name ?? "Null",
                                                            color: product.color!.name ?? "Null",
                                                            size: product.size!.number.toString() ?? "Null",
                                                            quantity: product.quantity ?? 0,
                                                            salePrice: product.product!.salePrice!.toDouble() ?? 0.0,
                                                            discount: product.discount!.toDouble(),
                                                            productId: product.productId.toString(),
                                                            colorId: product.colorId.toString(),
                                                            sizeId: product.sizeId.toString(),
                                                            typeId: product.typeId.toString(),
                                                            brandId: product.brandId.toString(),
                                                            companyId: product.companyId.toString(),
                                                            subTotal: product.subTotal.toString(),
                                                            totalAmount: product.totalAmount.toString(),
                                                          );
                                                        }).toList(),
                                                        productLimit: invoice.invoiceProducts!.length,
                                                        subTotal: invoice.subTotal.toString(),
                                                        totalAmount: invoice.totalAmount.toString(),
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: const CustomIcon(
                                                  icons: Icons.edit,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  await generateInvoice(
                                                      invoiceData);
                                                },
                                                child: const CustomIcon(
                                                  icons: Icons.print,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                return Container();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  );
              }
            }),
          ),
        ],
      ),
    );
  }
}
