class TransactionTable {
  final int id;
  final String sender;
  final String receiver;
  final String date;
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
