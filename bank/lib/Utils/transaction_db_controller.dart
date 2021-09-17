import 'dart:async';

import 'package:bank/Models/TransactionTable.dart';
import 'package:flutter/widgets.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:bank/Models/Customer.dart';
import 'package:bank/Test/data.dart';

class TransactionDatabaseController {
  static TransactionDatabaseController _databaseController;
  static Database _database;

  setDatabase(Database database) {
    _database = database;
  }

  TransactionDatabaseController._createInstance();

  factory TransactionDatabaseController() {
    if (_databaseController == null) {
      debugPrint("Creating Singleton Controller");
      _databaseController = TransactionDatabaseController._createInstance();
    }
    return _databaseController;
  }

  Future<Database> singletonDatabase() async {
    if (_database == null) {
      debugPrint("Initailizing the singleton database transaction");
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    debugPrint("Opening Database");
    final database = openDatabase(
      join(await getDatabasesPath(), 'transaction_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE transactions(id INTEGER PRIMARY KEY, sender TEXT,receiver INTEGER, date TEXT,amount REAL)',
        );
      },
      version: 1,
    );
    return database;
  }

  Future<void> insertCustomer(TransactionTable transactionTable) async {
    debugPrint("Inserting Transaction");
    // final db = await singletonDatabase();

    await _database.insert(
      'transactions',
      transactionTable.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    debugPrint(_database.toString());
  }

  // Future<List<Customer>> customersBasic() async {
  //   final db = await singletonDatabase();

  //   final List<Map<String, dynamic>> maps = await db.query('transactions');
//
  //   // List<Map<String, dynamic> --> List<Customer>.
  //   return List.generate(maps.length, (i) {
  //     return Customer(
  //       id: maps[i]['id'],
  //       name: maps[i]['name'],
  //       email: maps[i]['email'],
  //     );
  //   });
  // }

  Future<List<TransactionTable>> getCustomersList() async {
    final db = await singletonDatabase();
    final List<Map<String, dynamic>> maps = await db.query('transactions');
    return List.generate(maps.length, (i) {
      return TransactionTable(
        id: maps[i]['id'],
        sender: maps[i]['sender'],
        receiver: maps[i]['receiver'],
        date: maps[i]['date'],
        amount: maps[i]['amount'],
      );
    });
  }

  Future<void> updateCustomer(TransactionTable transactionTable) async {
    final db = await singletonDatabase();

    await db.update(
      'transactions',
      transactionTable.toMap(),
      where: 'id = ?',
      whereArgs: [transactionTable.id],
    );
  }

  Future<void> deleteCustomer(int id) async {
    final db = await singletonDatabase();

    await db.delete(
      'transactions',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
