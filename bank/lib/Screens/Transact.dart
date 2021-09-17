import 'package:bank/Models/Customer.dart';
import 'package:bank/Models/TransactionTable.dart';
import 'package:bank/Screens/AlertPopUp.dart';
import 'package:bank/Utils/db_controller.dart';
import 'package:bank/Utils/transaction_db_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class TransactAmount extends StatefulWidget {
  final List<TransactionTable> transactionsList;
  final Customer customer;
  final DatabaseController databaseController;
  final TransactionDatabaseController transactionDatabaseController;
  const TransactAmount(this.customer, this.customers, this.databaseController,
      this.transactionDatabaseController, this.transactionsList);
  final List<Customer> customers;

  @override
  _TransactAmountState createState() => _TransactAmountState();
}

class _TransactAmountState extends State<TransactAmount> {
  String amount = "";
  Customer selectedCustomer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Transfer Money '),
        ),
        body: buildTransactionList());
  }

  Widget buildTransactionList() {
    return Container(
      padding: EdgeInsets.all(30),
      child: Flexible(
        flex: 1,
        child: Column(
          children: [
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: Row(
                      children: [
                        Text('Account Holder ', style: textStyle(Colors.black)),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          widget.customer.name,
                          style: textStyle(Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Card(
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: Row(
                      children: [
                        Text('Beneficiary Name',
                            style: textStyle(Colors.black)),
                        SizedBox(
                          width: 10,
                        ),
                        DropdownButton(
                          hint: Text('Beneficiary Name'),
                          value: selectedCustomer,
                          onChanged: (newCustomer) {
                            setState(() {
                              selectedCustomer = newCustomer;
                            });
                          },
                          items: widget.customers.map((singleCustomer) {
                            return DropdownMenuItem(
                              child: Text(singleCustomer.name),
                              value: singleCustomer,
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 3,
              fit: FlexFit.tight,
              child: Container(
                // padding: EdgeInsets.all(20),
                //   child: Expanded(
                child: Center(
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter Amount '),
                    onChanged: (text) {
                      amount = text;
                    },
                  ),
                ),
                // ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              child: Text('TRANSFER'),
              onPressed: transactionButtonPressed,
            ),
          ],
        ),
      ),
    );
  }

  transactionButtonPressed() {
    if (selectedCustomer == null) {
      showAlert(
          context, 'Incomplete Details', 'Please Enter the Beneficiary Name');
      debugPrint("Beneficiary");
    } else {
      if (amount == "") {
        showAlert(context, 'Incomplete Details ', 'Please Enter the Amount');
        debugPrint("Amount");
      }
      if (widget.customer.balance < int.parse(amount)) {
        showAlert(
            context, 'Insufficient Balance ', 'Amount Exceeded the balance ');
        debugPrint("Amount");
      } else {
        //update Transactions

        //update Customers
        widget.customer.balance -= int.parse(amount);
        selectedCustomer.balance += int.parse(amount);

        debugPrint("widget.customer.balance ");
        debugPrint(widget.customer.balance.toString());
        debugPrint("selectedCustomer.balance");
        debugPrint(selectedCustomer.balance.toString());

        widget.databaseController.updateCustomer(widget.customer);
        widget.databaseController.updateCustomer(selectedCustomer);
        var data = newTransaction(widget.customer, selectedCustomer);
        widget.transactionDatabaseController.insertCustomer(data);

        showHomeAlert(
            context, 'Transcation Successful', 'Rupees $amount debited');
      }
    }
  }

  newTransaction(Customer customer, Customer selectedCustomer) {
    return new TransactionTable(
        id: widget.transactionsList.length + 1,
        sender: customer.name,
        receiver: selectedCustomer.name,
        amount: double.parse(amount),
        date: DateTime.now().toLocal().toString());
  }

  textStyle(Color color) {
    return TextStyle(fontSize: 15.0, color: color, fontWeight: FontWeight.w400);
  }
}
