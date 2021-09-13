import 'package:bank/Models/Customer.dart';
import 'package:bank/Screens/AlertPopUp.dart';
import 'package:bank/Utils/db_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class TransactAmount extends StatefulWidget {
  final Customer customer;
  final DatabaseController databaseController;
  const TransactAmount(this.customer, this.customers, this.databaseController);
  final List<Customer> customers;

  @override
  _TransactAmountState createState() => _TransactAmountState();
}

class _TransactAmountState extends State<TransactAmount> {
  String amount = "";
  Customer selectedCustomer;
  TextStyle textStyle = TextStyle(
      fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.w400);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text('Transfer From', style: textStyle),
                        Text(
                          widget.customer.name,
                          style: textStyle,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text('Beneficiary Name', style: textStyle),
                        DropdownButton(
                          hint: Text('Beneficiary '),
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
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: ElevatedButton(
              child: Text('TRANSFER'),
              onPressed: transactionButtonPressed(),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: TextField(
              onChanged: (text) {
                amount = text;
              },
            ),
          ),
        ],
      ),
    );
  }

  transactionButtonPressed() {
    if (selectedCustomer == null) {
      showAlert(context, 'Beneficiary');
    } else {
      if (widget.customer.balance < int.parse(amount)) {
        showAlert(context, 'Amount');
      } else {
        //update Transactions

        //update Customers
        widget.customer.balance -= int.parse(amount);
        selectedCustomer.balance += int.parse(amount);

        widget.databaseController.updateCustomer(widget.customer);
        widget.databaseController.updateCustomer(selectedCustomer);
      }
    }
  }
}
