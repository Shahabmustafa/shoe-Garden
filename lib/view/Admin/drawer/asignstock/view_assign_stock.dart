import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sofi_shoes/res/widget/textfield/app_text_field.dart';

class ViewAssignStock extends StatelessWidget {
  ViewAssignStock(
      {required this.title,
      required this.barcode,
      required this.productName,
      required this.purchasePrice,
      required this.salePrice,
      required this.company,
      required this.brand,
      required this.color,
      required this.size,
      required this.type,
      required this.quantity,
      required this.assignBy,
      required this.name,
      required this.remaningQuantity,
      super.key});
  String title;
  String barcode;
  String productName;
  String purchasePrice;
  String salePrice;
  String company;
  String brand;
  String color;
  String size;
  String type;
  String quantity;
  String assignBy;
  String name;
  String remaningQuantity;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: TextEditingController(text: assignBy),
              style: GoogleFonts.lato(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              decoration: const InputDecoration(label: Text("Assign By")),
              enabled: false,
            ),
            const SizedBox(
              height: 10,
            ),
            AppTextField(
              controller: TextEditingController(text: name),
              enabled: false,
              labelText: 'Assign To',
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: TextEditingController(text: productName),
              style: GoogleFonts.lato(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              decoration: const InputDecoration(label: Text("Product Name")),
              enabled: false,
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: TextEditingController(text: purchasePrice),
              style: GoogleFonts.lato(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              decoration: const InputDecoration(label: Text("Purchase Price")),
              enabled: false,
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: TextEditingController(text: salePrice),
              style: GoogleFonts.lato(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              decoration: const InputDecoration(label: Text("Sale Price")),
              enabled: false,
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: TextEditingController(text: company),
              style: GoogleFonts.lato(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              decoration: const InputDecoration(label: Text("Company Name")),
              enabled: false,
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: TextEditingController(text: brand),
              style: GoogleFonts.lato(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              decoration: const InputDecoration(label: Text("Brand Name")),
              enabled: false,
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: TextEditingController(text: size),
              style: GoogleFonts.lato(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              decoration: const InputDecoration(label: Text("Size Number")),
              enabled: false,
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: TextEditingController(text: color),
              style: GoogleFonts.lato(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              decoration: const InputDecoration(label: Text("Color Name")),
              enabled: false,
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: TextEditingController(text: type),
              style: GoogleFonts.lato(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              decoration: const InputDecoration(label: Text("Type")),
              enabled: false,
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: TextEditingController(text: quantity),
              style: GoogleFonts.lato(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              decoration: const InputDecoration(label: Text("Quantity")),
              enabled: false,
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: TextEditingController(text: remaningQuantity),
              style: GoogleFonts.lato(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              decoration:
                  const InputDecoration(label: Text("Remning Quantity")),
              enabled: false,
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}