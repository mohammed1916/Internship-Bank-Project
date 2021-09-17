import 'dart:async';

import 'package:flutter/widgets.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:bank/Models/Customer.dart';
import 'package:bank/Test/data.dart';

class DatabaseController {
  static DatabaseController _databaseController;
  static Database _database;

  DatabaseController._createInstance();

  factory DatabaseController() {
    if (_databaseController == null) {
      debugPrint("Creating Singleton Controller");
      _databaseController = DatabaseController._createInstance();
    }
    return _databaseController;
  }

  Future<Database> singletonDatabase() async {
    if (_database == null) {
      debugPrint("Initailizing the singleton database");
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    debugPrint("Opening Database");
    final database = openDatabase(
      join(await getDatabasesPath(), 'customer_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE customers(id INTEGER PRIMARY KEY, name TEXT,accountNumber INTEGER, email TEXT,balance REAL, accountType TEXT)',
        );
      },
      version: 1,
    );
    return database;
  }

  Future<void> insertCustomer(Customer customer, Database db) async {
    debugPrint("Inserting Customer");
    // final db = await singletonDatabase();

    await db.insert(
      'customers',
      customer.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    debugPrint(db.toString());
  }

  Future<List<Customer>> customersBasic() async {
    final db = await singletonDatabase();

    final List<Map<String, dynamic>> maps = await db.query('customers');

    // List<Map<String, dynamic> --> List<Customer>.
    return List.generate(maps.length, (i) {
      return Customer(
        id: maps[i]['id'],
        name: maps[i]['name'],
        email: maps[i]['email'],
      );
    });
  }

  Future<List<Customer>> customers(Database db) async {
    debugPrint("retrieving Customers");
    await InitializeDummyData().initializeDummy(_databaseController, db);
    debugPrint(db.toString());

    return getCustomersList(db);
  }

  Future<List<Customer>> getCustomersList(Database db) async {
    final List<Map<String, dynamic>> maps = await db.query('customers');
    return List.generate(maps.length, (i) {
      return Customer(
          id: maps[i]['id'],
          name: maps[i]['name'],
          accountNumber: maps[i]['accountNumber'],
          email: maps[i]['email'],
          balance: maps[i]['balance'],
          accountType: maps[i]['accountType']);
    });
  }

  Future<void> updateCustomer(Customer customer) async {
    final db = await singletonDatabase();
    debugPrint(customer.toString());
    await db.update(
      'customers',
      customer.toMap(),
      where: 'id = ?',
      whereArgs: [customer.id],
    );
  }

  Future<void> deleteCustomer(int id) async {
    final db = await singletonDatabase();

    await db.delete(
      'customers',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
