import 'package:bank/Models/TransactionTable.dart';
import 'package:bank/Screens/Profile.dart';
import 'package:bank/Utils/db_controller.dart';
import 'package:bank/Models/Customer.dart';
import 'package:bank/Utils/transaction_db_controller.dart';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:animations/animations.dart';

class AllCustomers extends StatefulWidget {
  final String title;
  final List<Customer> customers;
  final DatabaseController databaseController;
  final TransactionDatabaseController transactionDatabaseController;
  final List<TransactionTable> transactionsList;
  const AllCustomers(this.title, this.customers, this.databaseController,
      this.transactionDatabaseController, this.transactionsList);

  @override
  _AllCustomersState createState() => _AllCustomersState();
}

class _AllCustomersState extends State<AllCustomers> {
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
    debugPrint("allCustomers : Constructor");
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: buildCustomersList());
  }

  ListView buildCustomersList() {
    debugPrint("Return List");
    return ListView.builder(
      itemCount: widget.customers.length,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: colourList[position % colourList.length],
              child: Text(getInitailLetters(widget.customers[position].name),
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            title: Text(widget.customers[position].name,
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(
              (widget.customers[position].accountNumber).toString(),
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            onTap: () {
              debugPrint("tap $position");
              onTransaction(Profile(
                  widget.customers[position],
                  widget.customers,
                  widget.databaseController,
                  widget.transactionDatabaseController,
                  widget.transactionsList));
              // navigateToDetail(this.customers[position], 'Edit');
              // OpenContainer(
              //   openBuilder: (context, _) =>
              //       Profile(customers[position], customers, databaseController),
              //   closedBuilder: (context, _) => Container(
              //     decoration: BoxDecoration(
              //       color: colourList[position % colourList.length],
              //     ),
              //   ),
              // );
            },
          ),
        );
      },
    );
  }

  getInitailLetters(String title) {
    return title.substring(0, 2);
  }

  onTransaction(StatefulWidget swidget) {
    debugPrint("Navigator");
    Navigator.push(context, MaterialPageRoute(builder: (context) => swidget));
  }
}














// void main() {
//   runApp(
//     MyApp(
//       items: List<ListItem>.generate(
//         1000,
//         (i) => i % 6 == 0
//             ? HeadingItem('Heading $i')
//             : MessageItem('Sender $i', 'Message body $i'),
//       ),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   final List<ListItem> items;

//   const MyApp({required this.items});

//   @override
//   Widget build(BuildContext context) {
//     const title = 'Mixed List';

//     return MaterialApp(
//       title: title,
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text(title),
//         ),
//         body: ListView.builder(
//           // Let the ListView know how many items it needs to build.
//           itemCount: items.length,
//           // Provide a builder function. This is where the magic happens.
//           // Convert each item into a widget based on the type of item it is.
//           itemBuilder: (context, index) {
//             final item = items[index];

//             return ListTile(
//               title: item.buildTitle(context),
//               subtitle: item.buildSubtitle(context),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// /// The base class for the different types of items the list can contain.
// abstract class ListItem {
//   /// The title line to show in a list item.
//   Widget buildTitle(BuildContext context);

//   /// The subtitle line, if any, to show in a list item.
//   Widget buildSubtitle(BuildContext context);
// }

// /// A ListItem that contains data to display a heading.
// class HeadingItem implements ListItem {
//   final String heading;

//   HeadingItem(this.heading);

//   @override
//   Widget buildTitle(BuildContext context) {
//     return Text(
//       heading,
//       style: Theme.of(context).textTheme.headline5,
//     );
//   }

//   @override
//   Widget buildSubtitle(BuildContext context) => const SizedBox.shrink();
// }

// /// A ListItem that contains data to display a message.
// class MessageItem implements ListItem {
//   final String sender;
//   final String body;

//   MessageItem(this.sender, this.body);

//   @override
//   Widget buildTitle(BuildContext context) => Text(sender);

//   @override
//   Widget buildSubtitle(BuildContext context) => Text(body);
// }
