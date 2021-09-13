import 'package:bank/Models/Customer.dart';

class TransactionTable {
  final int id;
  final String sender;
  final String receiver;
  final DateTime date;
  double amount;

  TransactionTable({
    this.id,
    this.sender,
    this.receiver,
    this.date,
    this.amount,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sender': sender,
      'receiver': receiver,
      'date': date,
      'amount': amount,
    };
  }

  @override
  String toString() {
    return 'TransactionTable{id: $id, sender: $sender,receiver: $receiver, date: $date, amount: $amount}';
  }
}
