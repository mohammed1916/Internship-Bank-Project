import 'dart:math';
import 'package:flutter/widgets.dart';

import 'package:bank/Models/Customer.dart';
import 'package:bank/Utils/db_controller.dart';
import 'package:sqflite/sqflite.dart';

class InitializeDummyData {
  int length = 10;
  List<String> accType = [
    'Current account',
    'Salary account',
    'Savings account',
    'Fixed deposit account',
    'Recurring deposit account'
  ];

  Future<List<Customer>> createCustomers() async {
    debugPrint("Generating Dummy List");

    return List.generate(length, (i) {
      debugPrint("$i Customer created");
      var bal = (new Random().nextDouble()) * 100000.0;

      debugPrint("Double");
      debugPrint(bal.toString());

      return new Customer(
        id: i,
        name: 'Customer_$i',
        accountNumber: 125500927 + i,
        email: 'email$i@gmail.com',
        balance: bal,
        accountType: accType[new Random().nextInt(4)],
      );
    });
  }

  initializeDummy(DatabaseController databaseController, Database db) async {
    debugPrint("Inserting Customer in Dummy");
    createCustomers().then((resultCustomers) {
      for (int i = 0; i < length; i++) {
        databaseController.insertCustomer(resultCustomers[i], db);
        debugPrint("Inserted Customer");
        debugPrint(resultCustomers[i].toString());
      }
    });
  }
}
