import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewCustomer extends StatelessWidget {
  ViewCustomer(
      {required this.title,
      required this.companyName,
      required this.email,
      required this.phoneNumber,
      required this.address,
      required this.opBalance,
      required this.date,
      super.key});
  String title;
  String companyName;
  String email;
  String phoneNumber;
  String address;
  String opBalance;
  String date;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: TextEditingController(text: companyName),
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
              controller: TextEditingController(text: email),
              style: GoogleFonts.lato(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              decoration: InputDecoration(label: Text("Email")),
              enabled: false,
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: TextEditingController(text: phoneNumber),
              style: GoogleFonts.lato(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              decoration: InputDecoration(label: Text("Phone Number")),
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
              controller: TextEditingController(text: opBalance),
              style: GoogleFonts.lato(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              decoration: InputDecoration(label: Text("Opening Balance")),
              enabled: false,
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: TextEditingController(text: date),
              style: GoogleFonts.lato(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              decoration: InputDecoration(label: Text("Date")),
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
