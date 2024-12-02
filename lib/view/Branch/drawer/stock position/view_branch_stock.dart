import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewBranchStock extends StatelessWidget {
  ViewBranchStock(
      {required this.title,
      required this.assignBy,
      required this.barcode,
      required this.product,
      required this.purchase,
      required this.salePrice,
      required this.brand,
      required this.company,
      required this.color,
      required this.size,
      required this.type,
      required this.quantity,
      super.key});
  String title;
  String assignBy;
  String product;
  String salePrice;
  String barcode;
  String purchase;
  String brand;
  String company;
  String color;
  String size;
  String type;
  String quantity;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: TextEditingController(text: assignBy),
              style: GoogleFonts.lato(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              decoration: InputDecoration(label: Text("Warehouse Name")),
              enabled: false,
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: TextEditingController(text: barcode),
              style: GoogleFonts.lato(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              decoration: InputDecoration(label: Text("Barcode")),
              enabled: false,
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: TextEditingController(text: product),
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
              controller: TextEditingController(text: purchase),
              style: GoogleFonts.lato(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              decoration: InputDecoration(label: Text("Purchase Name")),
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
          ],
        ),
      ),
    );
  }
}
