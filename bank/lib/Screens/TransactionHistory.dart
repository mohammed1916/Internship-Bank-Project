import 'package:bank/Models/TransactionTable.dart';
import 'package:bank/Utils/transaction_db_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionHistory extends StatefulWidget {
  const TransactionHistory(
    this.title,
    this.transactionsList,
    this.transactionDatabaseController,
  );
  final String title;
  final TransactionDatabaseController transactionDatabaseController;
  final List<TransactionTable> transactionsList;

  @override
  _TransactionHistoryState createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
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
    List<TransactionTable> transactions = widget.transactionsList;
    debugPrint("alltransactionsList : Constructor");
    var futureList = widget.transactionDatabaseController.getCustomersList();
    futureList.then((list) => transactions = list);

    debugPrint(widget.transactionsList.toString());
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: transactions.length == 0
            ? emptyListView()
            : buildtransactionsListList(transactions));
  }

  ListView buildtransactionsListList(List<TransactionTable> transactions) {
    debugPrint("Return List");
    return ListView.builder(
      itemCount: widget.transactionsList.length,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: colourList[position % colourList.length],
              child: Text(getInitailLetters(transactions[position].sender),
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            title: Text(transactions[position].sender,
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(
              ("Rupees " +
                      formatBalance(transactions[position].amount) +
                      " transferred to " +
                      transactions[position].receiver +
                      " on " +
                      transactions[position].date)
                  .toString(),
              style: TextStyle(fontWeight: FontWeight.w600),
              maxLines: 2,
              overflow: TextOverflow.fade,
            ),
          ),
        );
      },
    );
  }

  emptyListView() {
    return Center(
        child: CircleAvatar(
      backgroundColor: Colors.blue,
      radius: 175,
      child: Text(
        'No Transactions Commited',
        overflow: TextOverflow.fade,
        maxLines: 2,
        textScaleFactor: 2.5,
        textAlign: TextAlign.center,
      ),
    ));
  }

  getInitailLetters(String title) {
    return title.substring(0, 2);
  }

  formatBalance(double num) {
    var format = NumberFormat("##,##,###.0#", "en_US");
    return format.format(num);
  }
}
