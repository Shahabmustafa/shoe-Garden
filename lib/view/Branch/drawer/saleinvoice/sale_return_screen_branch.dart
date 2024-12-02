import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sofi_shoes/date/response/status.dart';
import 'package:sofi_shoes/res/circularindictor/circularindicator.dart';
import 'package:sofi_shoes/view/Branch/drawer/saleinvoice/add_sale_return.dart';

import '../../../../res/responsive.dart';
import '../../../../res/slidebar/side_menu_branch.dart';
import '../../../../res/tabletext/table_text.dart';
import '../../../../res/widget/general_execption_widget.dart';
import '../../../../res/widget/textfield/app_text_field.dart';
import '../../../../viewmodel/branch/saleinvoice/get_data_sale_invoice_viewmodel.dart';
import '../../../../viewmodel/branch/saleinvoice/sale_return_invoice_viewmodel.dart';
import '../../../Manager/drawer/dashboard/dashboard_screen_a.dart';
import 'export/sale_invoice_export.dart';


class SaleReturnScreenBranch extends StatefulWidget {
  const SaleReturnScreenBranch({super.key});

  @override
  State<SaleReturnScreenBranch> createState() => _SaleReturnScreenBranchState();
}

class _SaleReturnScreenBranchState extends State<SaleReturnScreenBranch> {
  double totalAmount = 0.0;
  double totalDiscount = 0.0;

  double calculateSubtotal(String quantityStr, String salePriceStr) {
    try {
      var quantity = int.parse(quantityStr);
      var salePrice = double.parse(salePriceStr);
      return quantity * salePrice;
    } catch (e) {
      print('Error calculating subtotal: $e');
      return 0.0; // Return default value or handle error case appropriately
    }
  }

// Function to calculate total amount including discount
  double calculateTotal(double subtotal, double? discount) {
    if (discount != null) {
      return subtotal * (1 - discount / 100);
    } else {
      return subtotal;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final controller = Get.put(GetDataSaleInvoiceViewmodel());
    final controllerR = Get.put(SaleReturnInvoiceViewmodel());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sale Return"),
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
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
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
                            itemCount: controller.saleInvoiceList.value.body!.invoice!.length,
                            itemBuilder: (context, index) {
                              final invoice = controller.saleInvoiceList.value.body!.invoice![index];
                              String dateTimeString = invoice.createdAt.toString();
                              DateTime dateTime = DateTime.parse(dateTimeString);
                              String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
                              final invoiceData = InvoiceExport(
                                paymentMethod: invoice.paymentMethod ?? "Null",
                                id: invoice.invoiceNumber.toString(),
                                date: DateTime.now(),
                                saleman: Salesman(name: invoice.saleman != null ? controller.warehouseName.toString(): "Null"),
                                customer: Customer(name: invoice.customer != null ? invoice.customer!.name.toString() : "Null"),
                                total: invoice.totalAmount.toString(),
                                items: invoice.invoiceProducts!.map((product) {
                                  return InvoiceItem(
                                    product: product.product != null ? product.product!.name.toString() : 'null',
                                    salePrice: product.salePrice != null ? product.salePrice.toString() : 'null',
                                    qty: int.parse(product.quantity.toString()),
                                    dis: product.discount != null ? "${product.discount}%" : "Null",
                                    subTotal: product.subTotal != null ? product.subTotal.toString() : 'null',
                                    totalAmount: product.totalAmount != null ? product.totalAmount.toString() : "Null",
                                  );
                                }).toList(),
                              );
                              if (controller.search.value.text.isEmpty || invoice.invoiceNumber!.toString().toLowerCase().contains(controller.search.value.text.trim().toLowerCase()) || invoice.customer!.name!.toString().toLowerCase().contains(controller.search.value.text.trim().toLowerCase())) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
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
                                                  controllerR.getSpecificReturnedInvoice(int.parse(invoice.id.toString()));
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        title: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text(
                                                                  "Invoice : ${invoice.invoiceNumber != null ? invoice.invoiceNumber.toString() : "Null"}",
                                                                  style: GoogleFonts.lato(
                                                                    fontWeight: FontWeight.w600,
                                                                    fontSize: 14,
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Text(
                                                                  "Date : $formattedDate",
                                                                  style: GoogleFonts.lato(
                                                                    fontWeight: FontWeight.w600,
                                                                    fontSize: 14,
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Text(
                                                                  "Payment Method : ${invoice.paymentMethod != null ? invoice.paymentMethod.toString() : "Null"}",
                                                                  style: GoogleFonts.lato(
                                                                    fontWeight: FontWeight.w600,
                                                                    fontSize: 14,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text(
                                                                  "Salesman: ${invoice.saleman != null ? invoice.saleman!.name.toString() : "Null"}",
                                                                  style: GoogleFonts.lato(
                                                                    fontWeight: FontWeight.w600,
                                                                    fontSize: 14,
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Text(
                                                                  invoice.customer != null ? "Customer: ${invoice.customer!.name.toString()}" : "Null",
                                                                  style: GoogleFonts.lato(
                                                                    fontWeight: FontWeight.w600,
                                                                    fontSize: 14,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        content: Column(
                                                          mainAxisSize: MainAxisSize.min,
                                                          crossAxisAlignment: CrossAxisAlignment.end,
                                                          children: [
                                                            SingleChildScrollView(
                                                              child: Column(
                                                                mainAxisSize: MainAxisSize.min,
                                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                                children: [
                                                                  SingleChildScrollView(
                                                                    scrollDirection: Axis.horizontal,
                                                                    child: DataTable(
                                                                      columns: const [
                                                                        DataColumn(label: Text('Product'), numeric: false),
                                                                        DataColumn(label: Text('Color'), numeric: false),
                                                                        DataColumn(label: Text('Size'), numeric: false),
                                                                        DataColumn(label: Text('Quantity'), numeric: true),
                                                                        DataColumn(label: Text('Sale Price'), numeric: true),
                                                                        DataColumn(label: Text('Sub Total'), numeric: true),
                                                                        DataColumn(label: Text('Discount'), numeric: true),
                                                                        DataColumn(label: Text('Total Amount'), numeric: true),
                                                                      ],
                                                                      rows: invoice.invoiceProducts != null
                                                                          ? invoice.invoiceProducts!.map((product) {
                                                                        return DataRow(
                                                                          cells: [
                                                                            DataCell(Text(product.product?.name ?? "Null")),
                                                                            DataCell(Text(product.color?.name ?? "Null")),
                                                                            DataCell(Text(product.size?.number.toString() ?? "Null")),
                                                                            DataCell(Text(product.quantity?.toString() ?? "Null")),
                                                                            DataCell(Text(product.product?.salePrice.toString() ?? "Null")),
                                                                            DataCell(Text(product.subTotal?.toString() ?? "Null")),
                                                                            DataCell(Text(product.discount != null ? "${product.discount}%" : "Null")),
                                                                            DataCell(Text(product.totalAmount?.toString() ?? "Null")),
                                                                          ],
                                                                        );
                                                                      }).toList() : [],
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 30,
                                                                  ),
                                                                  const Divider(
                                                                    color: Colors.grey,
                                                                    thickness: 1,
                                                                  ),
                                                                  Row(
                                                                    mainAxisSize: MainAxisSize.min,
                                                                    children: [
                                                                      Text(
                                                                        "Sub Total",
                                                                        style: GoogleFonts.lato(
                                                                          fontSize: 14,
                                                                          fontWeight: FontWeight.w600,
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                        width: 30,
                                                                      ),
                                                                      Text(
                                                                        invoice.subTotal != null ? invoice.subTotal.toString() : "Null",
                                                                        style: GoogleFonts.lato(
                                                                          fontSize: 14,
                                                                          fontWeight: FontWeight.w500,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  Row(
                                                                    mainAxisSize: MainAxisSize.min,
                                                                    children: [
                                                                      Text(
                                                                        "Total Amount",
                                                                        style: GoogleFonts.lato(
                                                                          fontSize: 14,
                                                                          fontWeight: FontWeight.w600,
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                        width: 30,
                                                                      ),
                                                                      Text(
                                                                        invoice.totalAmount != null ? invoice.totalAmount.toString() : "Null",
                                                                        style: GoogleFonts.lato(
                                                                          fontSize: 14,
                                                                          fontWeight: FontWeight.w500,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 10,
                                                                  ),

                                                                  ///Return product
                                                                  Obx(() => controllerR.specificInvoice.value.body?.saleReturn == null ?
                                                                  SizedBox() :
                                                                  Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                                    children: [
                                                                      SingleChildScrollView(
                                                                        scrollDirection: Axis.horizontal,
                                                                        child: DataTable(
                                                                          columns: const [
                                                                            DataColumn(
                                                                              label: Text('Product'),
                                                                              numeric: false,
                                                                            ),
                                                                            DataColumn(
                                                                              label: Text('Color'),
                                                                              numeric: false,
                                                                            ),
                                                                            DataColumn(
                                                                              label: Text('Size'),
                                                                              numeric: false,
                                                                            ),
                                                                            DataColumn(
                                                                              label: Text('Quantity'),
                                                                              numeric: true,
                                                                            ),
                                                                            DataColumn(
                                                                              label: Text('Sale Price'),
                                                                              numeric: true,
                                                                            ),
                                                                            DataColumn(
                                                                              label: Text('Sub Total'),
                                                                              numeric: true,
                                                                            ),
                                                                            DataColumn(
                                                                              label: Text('Discount'),
                                                                              numeric: true,
                                                                            ),
                                                                            DataColumn(
                                                                              label: Text('Total Amount'),
                                                                              numeric: true,
                                                                            ),
                                                                          ],
                                                                          rows: controllerR.specificInvoice.value.body!.saleReturn != null
                                                                              ? controllerR.specificInvoice.value.body!.saleReturn!.returnProducts!.map((product) {
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
                                                                                  Text(
                                                                                    product.subTotal != null ? product.subTotal.toString() : 'null',
                                                                                  ),
                                                                                ),
                                                                                DataCell(
                                                                                  Text(
                                                                                    product.discount != null ? "${product.discount}%" : "Null",
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
                                                                      const Divider(
                                                                        color: Colors.grey,
                                                                        thickness: 1,
                                                                      ),
                                                                      Row(
                                                                        mainAxisSize: MainAxisSize.min,
                                                                        children: [
                                                                          Text(
                                                                            "Sub Total",
                                                                            style: GoogleFonts.lato(
                                                                              fontSize: 14,
                                                                              fontWeight: FontWeight.w600,
                                                                            ),
                                                                          ),
                                                                          const SizedBox(
                                                                            width: 30,
                                                                          ),
                                                                          Text(
                                                                            controllerR.specificInvoice.value.body!.saleReturn!.subTotal != null ? controllerR.specificInvoice.value.body!.saleReturn!.subTotal.toString() : "Null",
                                                                            style: GoogleFonts.lato(
                                                                              fontSize: 14,
                                                                              fontWeight: FontWeight.w500,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      const SizedBox(
                                                                        height: 10,
                                                                      ),
                                                                      Row(
                                                                        mainAxisSize: MainAxisSize.min,
                                                                        children: [
                                                                          Text(
                                                                            "Total Amount",
                                                                            style: GoogleFonts.lato(
                                                                              fontSize: 14,
                                                                              fontWeight: FontWeight.w600,
                                                                            ),
                                                                          ),
                                                                          const SizedBox(
                                                                            width: 30,
                                                                          ),
                                                                          Text(
                                                                            controllerR.specificInvoice.value.body!.saleReturn!.totalAmount != null ? controllerR.specificInvoice.value.body!.saleReturn!.totalAmount.toString() : "Null",
                                                                            style: GoogleFonts.lato(
                                                                              fontSize: 14,
                                                                              fontWeight: FontWeight.w500,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
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
                                                      builder: (context) => AddSaleReturnScreen(
                                                        uid: invoice.id.toString(),
                                                        customer: invoice.customer!.name.toString(),
                                                        salesman: invoice.saleman != null ? invoice.saleman!.name.toString() : 'null',
                                                        invoiceNo: invoice.invoiceNumber.toString(),
                                                        customerId: invoice.customerId != null ? invoice.customerId.toString() : 'null',
                                                        salesmanId: invoice.saleMenId != null ? invoice.saleMenId.toString() : 'null',
                                                        products: invoice.invoiceProducts!.map((product) {
                                                          return Product(
                                                            maxQuantity: int.parse(product.quantity.toString()),
                                                            name: product.product != null ? product.product!.name.toString() : "Null",
                                                            color: product.color != null ? product.color!.name.toString() : "Null",
                                                            size: product.size != null ? product.size!.number.toString() : "Null",
                                                            quantity: product.quantity ?? 0,
                                                            salePrice: product.product!.salePrice != null ? product.product!.salePrice!.toDouble() : 0.0,
                                                            discount: product.discount != null ? product.discount!.toDouble() : 0.0,
                                                            productId: product.productId != null ? product.productId.toString() : "Null",
                                                            colorId: product.colorId != null ? product.colorId.toString() : "Null",
                                                            sizeId: product.sizeId != null ? product.sizeId.toString() : "Null",
                                                            typeId: product.typeId != null ? product.typeId.toString() : "Null",
                                                            brandId: product.brandId != null ? product.brandId.toString() : "Null",
                                                            companyId: product.companyId != null ? product.companyId.toString() : 'null',
                                                          );
                                                        }).toList(),
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
                                                  await generateInvoice(invoiceData);
                                                },
                                                child: const CustomIcon(
                                                  icons: Icons.print,
                                                  color: Colors.blue,
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