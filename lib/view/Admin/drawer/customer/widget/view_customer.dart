import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewCustomer extends StatelessWidget {
  ViewCustomer(
      {required this.title,
      required this.customerName,
      required this.email,
      required this.phoneNumber,
      required this.address,
      required this.opBalance,
      required this.date,
      super.key});
  String title;
  String customerName;
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
              controller: TextEditingController(text: customerName),
              style: GoogleFonts.lato(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              decoration: const InputDecoration(label: Text("Name")),
              enabled: false,
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: TextEditingController(text: email),
              style: GoogleFonts.lato(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              decoration: const InputDecoration(label: Text("Email")),
              enabled: false,
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: TextEditingController(text: phoneNumber),
              style: GoogleFonts.lato(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              decoration: const InputDecoration(label: Text("Phone Number")),
              enabled: false,
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: TextEditingController(text: address),
              style: GoogleFonts.lato(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              decoration: const InputDecoration(label: Text("Address")),
              enabled: false,
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: TextEditingController(text: opBalance),
              style: GoogleFonts.lato(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              decoration: const InputDecoration(label: Text("Last Balance")),
              enabled: false,
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: TextEditingController(text: date),
              style: GoogleFonts.lato(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              decoration: const InputDecoration(label: Text("Date")),
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
