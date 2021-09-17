import 'package:bank/Models/TransactionTable.dart';
import 'package:bank/Screens/Profile.dart';
import 'package:bank/Utils/db_controller.dart';
import 'package:bank/Models/Customer.dart';
import 'package:bank/Utils/transaction_db_controller.dart';

import 'package:flutter/material.dart';

class AllCustomers extends StatefulWidget {
  final String title;
  final List<Customer> customers;
  final DatabaseController databaseController;
  final TransactionDatabaseController transactionDatabaseController;
  final List<TransactionTable> transactionsList;
  const AllCustomers(this.title, this.customers, this.databaseController,
      this.transactionDatabaseController, this.transactionsList);

  @override
  _AllCustomersState createState() => _AllCustomersState();
}

class _AllCustomersState extends State<AllCustomers> {
  var colourList = [
    Colors.blue[400],
    Colors.blue[500],
    Colors.blue[600],
    Colors.blue[700],
    Colors.blue[800],
    Colors.blue[900],
    Colors.blue[800],
    Colors.blue[700],
    Colors.blue[600],
    Colors.blue[500],
  ];

  @override
  Widget build(BuildContext context) {
    debugPrint("allCustomers : Constructor");
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: buildCustomersList());
  }

  ListView buildCustomersList() {
    debugPrint("Return List");
    return ListView.builder(
      itemCount: widget.customers.length,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: colourList[position % colourList.length],
              child: Text(getInitailLetters(widget.customers[position].name),
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            title: Text(widget.customers[position].name,
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(
              (widget.customers[position].accountNumber).toString(),
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            onTap: () {
              debugPrint("tap $position");
              onTransaction(Profile(
                  widget.customers[position],
                  widget.customers,
                  widget.databaseController,
                  widget.transactionDatabaseController,
                  widget.transactionsList));
            },
          ),
        );
      },
    );
  }

  getInitailLetters(String title) {
    return title.substring(0, 2);
  }

  onTransaction(StatefulWidget swidget) {
    debugPrint("Navigator");
    Navigator.push(context, MaterialPageRoute(builder: (context) => swidget));
  }
}
