import 'dart:math';
import 'package:bank/Models/TransactionTable.dart';
import 'package:bank/Screens/Transact.dart';
import 'package:bank/Utils/db_controller.dart';
import 'package:bank/Utils/transaction_db_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:bank/Models/Customer.dart';
import 'package:intl/intl.dart';

class Profile extends StatefulWidget {
  final List<TransactionTable> transactionsList;
  final Customer customer;
  final List<Customer> customers;
  final DatabaseController databaseController;
  final TransactionDatabaseController transactionDatabaseController;
  const Profile(this.customer, this.customers, this.databaseController,
      this.transactionDatabaseController, this.transactionsList);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    debugPrint("Profile");
    return Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Container(
                  // height: 200,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment((new Random().nextInt(80)) / 100, 0.0),
                          colors: <Color>[
                            Colors.purple,
                            Colors.cyan,
                          ],
                          tileMode: TileMode.mirror)),
                  // child: Container(
                  // width: double.infinity,
                  // height: 200,
                  child: Container(
                    alignment: Alignment(0.0, 1.5),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 30,
                      child: Icon(
                        Icons.person_rounded,
                        color: Colors.indigo,
                        size: 50,
                      ),
                    ),
                  ),
                  // ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              formRows('Name ', widget.customer.name),
              formRows(
                  'Account Number ', widget.customer.accountNumber.toString()),
              formRows('Account Type ', widget.customer.accountType),
              formRows('Email ', widget.customer.email),
              formRows('Balance', formatBalance(widget.customer.balance)),

              //Buttons
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: transferMoney,
                        child: Text(
                          'Transfer',
                          style: textStyle(Colors.white),
                        )),
                    SizedBox(
                      width: 30,
                    ),
                    OutlinedButton(
                        onPressed: backToNavigator,
                        child: Text(
                          'Back',
                          style: textStyle(Colors.blue),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  transferMoney() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TransactAmount(
                widget.customer,
                widget.customers,
                widget.databaseController,
                widget.transactionDatabaseController,
                widget.transactionsList)));
  }

  backToNavigator() {
    Navigator.of(context).pop();
  }

  textStyle(Color color) {
    return TextStyle(fontSize: 20.0, color: color, fontWeight: FontWeight.w400);
  }

  formRows(String field, String value) {
    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child: Column(
        children: [
          Expanded(
            child: Card(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(field, style: textStyle(Colors.black)),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Text(
                          value,
                          textAlign: TextAlign.right,
                          style: textStyle(Colors.black54),
                          maxLines: 2,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  formatBalance(double num) {
    var format = NumberFormat("##,##,###.0#", "en_US");
    return format.format(num);
  }
}
