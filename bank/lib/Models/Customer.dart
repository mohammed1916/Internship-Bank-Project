class Customer {
  final int id;
  final String name;
  final int accountNumber;
  final String email;
  double balance;
  final String accountType;

  Customer({
    this.id,
    this.name,
    this.accountNumber,
    this.email,
    this.balance,
    this.accountType,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'accountNumber': accountNumber,
      'email': email,
      'balance': balance,
      'accountType': accountType
    };
  }

  @override
  String toString() {
    return 'Customer{id: $id, name: $name,accountNumber: $accountNumber, email: $email, balance: $balance, account_type: $accountType}';
  }
}
