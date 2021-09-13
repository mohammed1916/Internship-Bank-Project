import 'dart:math';
import 'package:bank/Screens/Transact.dart';
import 'package:bank/Utils/db_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:bank/Models/Customer.dart';

class Profile extends StatefulWidget {
  final Customer customer;
  final List<Customer> customers;
  final DatabaseController databaseController;
  const Profile(this.customer, this.customers, this.databaseController);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextStyle textStyle = TextStyle(
      fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.w400);

  @override
  Widget build(BuildContext context) {
    debugPrint("Profile");
    return SafeArea(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment((new Random().nextInt(80)) / 100, 0.0),
                    colors: <Color>[
                      Color(0x189AB4),
                      Color(0x75E6DA),
                    ],
                    tileMode: TileMode.repeated)),
            child: Container(
              width: double.infinity,
              height: 200,
              child: Container(
                alignment: Alignment(0.0, 2.5),
                child: Icon(
                  Icons.person,
                  color: Colors.blueAccent,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50,
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
                        Text('Name', style: textStyle),
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
                        Text('Account Type', style: textStyle),
                        Text(
                          widget.customer.accountType,
                          style: textStyle,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),

          //Buttons
          Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  ElevatedButton(
                      onPressed: transferMoney(),
                      child: Text(
                        'Transfer',
                        style: textStyle,
                      )),
                  SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                      onPressed: backToNavigator(),
                      child: Text(
                        'Back To Home',
                        style: textStyle,
                      )),
                ],
              )),
        ],
      ),
    );
  }

  transferMoney() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TransactAmount(
                widget.customer, widget.customers, widget.databaseController)));
  }

  backToNavigator() {
    Navigator.of(context).pop();
  }
}
