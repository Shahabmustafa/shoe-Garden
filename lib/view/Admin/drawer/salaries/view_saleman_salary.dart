import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewSalemanSalaries extends StatelessWidget {
  ViewSalemanSalaries(
      {required this.salesmanName,
      required this.branch,
      required this.contact,
      required this.address,
      required this.salary,
      required this.commission,
      required this.netSalary,
      required this.totalSale,
      super.key});

  String salesmanName;
  String branch;
  String contact;
  String address;
  String salary;
  String commission;
  String netSalary;
  String totalSale;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Saleman Salary Detail"),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: TextEditingController(text: salesmanName),
              style: GoogleFonts.lato(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              decoration: InputDecoration(label: Text("Saleman Name")),
              enabled: false,
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: TextEditingController(text: branch),
              style: GoogleFonts.lato(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              decoration: InputDecoration(label: Text("Branch Name")),
              enabled: false,
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: TextEditingController(text: contact),
              style: GoogleFonts.lato(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              decoration: InputDecoration(label: Text("Contact")),
              enabled: false,
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: TextEditingController(text: address),
              style: GoogleFonts.lato(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              decoration: InputDecoration(label: Text("Address")),
              enabled: false,
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: TextEditingController(text: salary),
              style: GoogleFonts.lato(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              decoration: InputDecoration(label: Text("Salary")),
              enabled: false,
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: TextEditingController(text: commission),
              style: GoogleFonts.lato(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              decoration: InputDecoration(label: Text("Commission")),
              enabled: false,
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: TextEditingController(text: netSalary),
              style: GoogleFonts.lato(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              decoration: InputDecoration(label: Text("Net Salary")),
              enabled: false,
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
          ],
        ),
      ),
    );
  }
}
