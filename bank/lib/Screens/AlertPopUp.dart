import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

void showAlert(BuildContext context, String data) {
  Widget okButton = TextButton(
    child: Text('ok'),
    onPressed: () => Navigator.of(context).pop(),
  );

  AlertDialog alertDialog = AlertDialog(
    title: Text('Incomplete Details'),
    content: Text('Please Enter the $data'),
    actions: [
      okButton,
    ],
  );

  showDialog(
      context: context,
      builder: (BuildContext buildContext) {
        return alertDialog;
      });
}
