// import 'package:dotted_border/dotted_border.dart';
// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../../../viewmodel/branch/saleinvoice/sale_invoice_product_model.dart';
// import '../../../../../viewmodel/branch/saleinvoice/sale_invoice_viewmodel.dart';
//
// class ProductList extends StatefulWidget {
//   @override
//   _ProductListState createState() => _ProductListState();
// }
//
// class _ProductListState extends State<ProductList> {
//   double total = 0.0;
//   double paidAmount = 0.0;
//   double dueAmount = 0.0;
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(SaleInvoiceViewmodel());
//     return SizedBox(
//       height: 400,
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             DataTable(
//               columns: [
//                 DataColumn(label: Text('#')),
//                 DataColumn(label: Text('Bar')),
//                 DataColumn(label: Text('Product')),
//                 DataColumn(label: Text('Color')),
//                 DataColumn(label: Text('Size')),
//                 DataColumn(label: Text('S.Price')),
//                 DataColumn(label: Text('T.Quantity')),
//                 DataColumn(label: Text('Quantity')),
//                 DataColumn(label: Text('Dist')),
//                 DataColumn(label: Text('Delete')),
//               ],
//               rows: controller.products.asMap().entries.map((entry) {
//                 int index = entry.key;
//                 SaleInvoiceProductModel product = entry.value;
//                 return DataRow(cells: [
//                   DataCell(Text((index + 1).toString())),
//                   DataCell(Text("Bar")),
//                   DataCell(
//                     Obx(() => SaleInvoiceDropdown(
//                       labelText: "Product",
//                       items: controller.dropdownProduct.map((branch) {return branch["name"].toString();}).toList(),
//                       onChanged: (branchName) async {
//                         var selectBranch = controller.dropdownProduct.firstWhere((branch) => branch['name'].toString() == branchName,orElse: () => null);
//                         if (selectBranch != null) {
//                           controller.salePrice.value = selectBranch['sale_price'].toString();
//                           controller.selectProduct.value = selectBranch['id'].toString();
//                         }
//                         controller.getColor();
//                         },
//                       ),
//                     ),
//                   ),
//                   DataCell(
//                     Obx(() => SaleInvoiceDropdown(
//                       labelText: "Color",
//                       items: controller.dropdownItemsColor.map((branch) {
//                         return branch["name"].toString();
//                       }).toList(),
//                       onChanged: (colorName) async {
//                         var selectColor = controller.dropdownItemsColor.firstWhere(
//                                 (branch) => branch['name'].toString() == colorName,
//                             orElse: () => null);
//                         if (selectColor != null) {
//                           controller.selectColor.value = selectColor['id'].toString();
//                         }
//                         controller.getSize();
//                         },
//                       ),
//                     ),
//                   ),
//                   DataCell(
//                     Obx(
//                           () => SaleInvoiceDropdown(
//                         labelText: "Size",
//                         items: controller.dropdownItemsSize.map((branch) {
//                           return branch["number"].toString();
//                         }).toList(),
//                         onChanged: (sizeNumber) async {
//                           var selectSize = controller.dropdownItemsSize.firstWhere(
//                                   (branch) => branch['number'].toString() == sizeNumber,
//                               orElse: () => null);
//                           if (selectSize != null) {
//                             controller.selectSize.value = selectSize['id'].toString();
//                           }
//                         },
//                       ),
//                     ),
//                   ),
//                   DataCell(
//                     Obx(() => Text(controller.salePrice.value)), // Use product sale price
//                   ),
//                   DataCell(
//                     Obx(() => Text(controller.totalQuantity.value)),
//                   ),
//                   DataCell(
//                     TextFormField(
//                       decoration: InputDecoration(
//                         hintText: '0',
//                         enabled: true,
//                         border: InputBorder.none,
//                       ),
//                       keyboardType: TextInputType.number,
//                       initialValue: product.quantity?.toString() ?? '',
//                       onChanged: (value) {
//                         setState(() {
//                           product.quantity = int.tryParse(value) as String?;
//                         });
//                       },
//                     ),
//                   ),
//                   DataCell(
//                     Obx(() => Text(controller.discount.value != null ? controller.discount.value : "0")),
//                   ),
//                   DataCell(
//                     IconButton(
//                       icon: Icon(Icons.delete, color: Colors.red),
//                       onPressed: () {
//                         setState(() {
//                           // print(controller.to.value);
//                           controller.products.removeAt(index);
//                         });
//                       },
//                     ),
//                   ),
//                 ]);
//               }).toList(),
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: DottedBorder(
//                     color: Colors.grey,
//                     strokeWidth: 1,
//                     dashPattern: [6, 3],
//                     borderType: BorderType.RRect,
//                     radius: Radius.circular(12.0),
//                     child: GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           print('Adding new product...');
//                           print(controller.selectProduct.value);
//                           print(controller.selectSize.value);
//                           print(controller.selectColor.value);
//                           print(controller.quantity.value);
//
//                           controller.totalQuantity.value = "";
//                           controller.salePrice.value = "";
//                           controller.discount.value = "";
//
//                           // Print each product in the controller.products list
//                           controller.products.forEach((product) {
//                             print(
//                                 'Product ID: ${product.productId}, Color ID: ${product.colorId}, Size ID: ${product.sizeId}');
//                           });
//                           // Add a new SaleInvoiceProductModel instance to the list
//                           controller.products.add(SaleInvoiceProductModel());
//                         });
//                       },
//                       child: Container(
//                         width: double.infinity,
//                         height: 40,
//                         color: Colors.white,
//                         child: const Center(
//                           child: Text(
//                             "Add Product",
//                             style: TextStyle(
//                               fontWeight: FontWeight.w700,
//                               fontSize: 14,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
// }

// ignore: must_be_immutable
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class SaleInvoiceDropdown extends StatelessWidget {
  SaleInvoiceDropdown({
    super.key,
    required this.labelText,
    required this.items,
    this.onChanged,
    this.selectedItem,
    this.borderColor,
    this.allowBorder = true,
  });
  List<String> items;
  String labelText;
  String? selectedItem;
  Color? borderColor;
  void Function(String?)? onChanged;
  bool allowBorder;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return SizedBox(
      height: size.height * 0.06,
      child: DropdownSearch<String>(
        popupProps: PopupProps.menu(
          fit: FlexFit.loose,
          showSelectedItems: false,
        ),
        items: items,
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: const TextStyle(color: Colors.black),
          dropdownSearchDecoration: InputDecoration(
            hintText: labelText,
            contentPadding: EdgeInsets.only(left: 15, top: 15),
            hintStyle: const TextStyle(
              color: Colors.black,
            ),
            labelStyle: const TextStyle(
              color: Colors.black,
            ),
            floatingLabelStyle: const TextStyle(color: Colors.black),
            border: allowBorder
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                    borderSide: BorderSide(
                      color: borderColor ?? Colors.black,
                    ),
                  )
                : InputBorder.none,
            hoverColor: Colors.white,
          ),
        ),
        onChanged: onChanged,
        selectedItem: selectedItem,
      ),
    );
  }
}
