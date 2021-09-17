import 'package:bank/Models/Customer.dart';
import 'package:bank/Models/TransactionTable.dart';
import 'package:bank/Screens/TransactionHistory.dart';
import 'package:bank/Utils/db_controller.dart';
import 'package:bank/Utils/transaction_db_controller.dart';
import 'package:flutter/material.dart';

import 'package:bank/Screens/AllCustomers.dart';
import 'package:sqflite/sqflite.dart';

class Home extends StatefulWidget {
  const Home();

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var textStyle = TextStyle(
    fontSize: 25,
    color: Colors.white,
  );
  DatabaseController databaseController = DatabaseController();
  List<Customer> customers;
  int count = 0;
  bool completedUpdate = false;

  final TransactionDatabaseController transactionDatabaseController =
      TransactionDatabaseController();

  List<TransactionTable> transactionsList;
  int transactionCount;
  bool completedTransactionUpdate = false;
  @override
  Widget build(BuildContext context) {
    if (customers == null) {
      customers = <Customer>[];
      debugPrint("_updateCustomers");
      if (!completedUpdate) _updateCustomers();
    }
    if (transactionsList == null) {
      transactionsList = <TransactionTable>[];
      debugPrint("_updateTransactions");
      _updateTranscations();
    }
    
    debugPrint(customers.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (completedUpdate) {
                        onTransaction(AllCustomers(
                            'All Customers',
                            customers,
                            databaseController,
                            transactionDatabaseController,
                            transactionsList));
                      }
                    },
                    child: Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(color: Colors.blueAccent, spreadRadius: 4)
                          ]),
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 30,
                              child: Icon(
                                Icons.supervised_user_circle_rounded,
                                color: Colors.indigo,
                                size: 50,
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Text('All Customers',
                                style: textStyle, textAlign: TextAlign.center),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => {
                      if (completedTransactionUpdate)
                        {setTranscationList();
                          onTransaction(TransactionHistory('Transaction History',
                            transactionsList, transactionDatabaseController))}
                    },
                    child: Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(color: Colors.blueAccent, spreadRadius: 4)
                          ]),
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 30,
                              child: Icon(
                                Icons.receipt_long,
                                color: Colors.indigo,
                                size: 50,
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Text(
                              'Transaction History',
                              style: textStyle,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.info,
        ),
        onPressed: () {
          onTransaction(Home());
        },
      ),
    );
  }

  onTransaction(StatefulWidget swidget) {
    debugPrint("Navigator");
    Navigator.push(context, MaterialPageRoute(builder: (context) => swidget));
  }

  void _updateCustomers() {
    completedUpdate = false;
    debugPrint("_updateCustomers");

    final Future<Database> dbFuture = databaseController.singletonDatabase();
    dbFuture.then((database) {
      Future<List<Customer>> customerListFuture =
          databaseController.customers(database);
      customerListFuture.then((customersList) {
        setState(() {
          debugPrint("Setting State customersList");
          debugPrint(customersList.toString());
          this.customers = customersList;
          this.count = customersList.length;
          completedUpdate = true;
        });
      });
    });
  }

  void _updateTranscations() {
    completedTransactionUpdate = false;
    debugPrint("_updateTranscation");
    final Future<Database> dbFuture =
        transactionDatabaseController.singletonDatabase();
    dbFuture.then((database) {
      transactionDatabaseController.setDatabase(database);
      setTranscationList();
    });
  }

  setTranscationList() {
    Future<List<TransactionTable>> transcationListFuture =
        transactionDatabaseController.getCustomersList();
    transcationListFuture.then((tList) {
      setState(() {
        debugPrint("Setting State Transaction");
        this.transactionsList = tList;
        this.transactionCount = tList.length;
        completedTransactionUpdate = true;
      });
    });
  }
}
