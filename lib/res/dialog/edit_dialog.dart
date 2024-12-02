import 'package:flutter/material.dart';
import 'package:sofi_shoes/res/color/app_color.dart';

class EditDialog extends StatelessWidget {
  EditDialog({this.title, this.accept, this.reject, super.key});
  VoidCallback? accept;
  VoidCallback? reject;
  String? title;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title == null
          ? Text("Do you want to Delete")
          : Text(title.toString()),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.redColor,
              minimumSize: Size(80, 30), // Set width and height
            ),
            onPressed: reject,
            child: Text("Reject"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              minimumSize: Size(80, 30), // Set width and height
            ),
            onPressed: accept,
            child: Text("Accept"),
          ),
        ],
      ),
    );
  }
}
