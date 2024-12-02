import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewAssignStockToOtherBranch extends StatelessWidget {
  ViewAssignStockToOtherBranch(
      {this.title,
      required this.branchName,
      required this.product,
      required this.brand,
      required this.company,
      required this.color,
      required this.size,
      required this.type,
      required this.quantity,
      required this.remainingquantity,
      super.key});
  String branchName;
  String product;
  String brand;
  String company;
  String color;
  String size;
  String type;
  String quantity;

  String remainingquantity;
  String? title;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title != null ? title.toString() : "Stock"),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: TextEditingController(text: branchName),
              style: GoogleFonts.lato(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              decoration: const InputDecoration(label: const Text("To")),
              enabled: false,
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: TextEditingController(text: product),
              decoration: const InputDecoration(label: Text("Product Name")),
              enabled: false,
              style: GoogleFonts.lato(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: TextEditingController(text: brand),
              decoration: const InputDecoration(label: Text("Brand Name")),
              enabled: false,
              style: GoogleFonts.lato(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: TextEditingController(text: company),
              decoration: const InputDecoration(label: Text("Company Name")),
              enabled: false,
              style: GoogleFonts.lato(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: TextEditingController(text: color),
              decoration: const InputDecoration(label: Text("Color Name")),
              enabled: false,
              style: GoogleFonts.lato(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: TextEditingController(text: size),
              decoration: const InputDecoration(label: Text("Size Number")),
              enabled: false,
              style: GoogleFonts.lato(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: TextEditingController(text: type),
              decoration: const InputDecoration(label: Text("Type")),
              enabled: false,
              style: GoogleFonts.lato(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: TextEditingController(text: quantity),
              decoration: const InputDecoration(label: Text("Quantity")),
              enabled: false,
              style: GoogleFonts.lato(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: TextEditingController(text: remainingquantity),
              decoration:
                  const InputDecoration(label: Text("Remaining Quantity")),
              enabled: false,
              style: GoogleFonts.lato(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
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
