import 'package:bank/Screens/Home.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

void showAlert(BuildContext context, String title, String details) {
  Widget okButton = TextButton(
    child: Text('ok'),
    onPressed: () => Navigator.of(context).pop(),
  );

  AlertDialog alertDialog = AlertDialog(
    title: Text(title),
    content: Text(details),
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

void showHomeAlert(BuildContext context, String title, String details) {
  Widget homeButton = TextButton(
    child: Text('Back to Home'),
    onPressed: () => Navigator.push(
        context, MaterialPageRoute(builder: (context) => Home())),
  );

  AlertDialog alertDialog = AlertDialog(
    title: Text(title),
    content: Text(details),
    actions: [
      homeButton,
    ],
  );

  showDialog(
      context: context,
      builder: (BuildContext buildContext) {
        return alertDialog;
      });
}
