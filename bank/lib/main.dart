import 'package:bank/Screens/Home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }

//   List<String> names = ["aaa", "aaaa"];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: ListView.builder(
//           itemCount: names.length,
//           padding: EdgeInsets.all(10.0),
//           itemBuilder: (context, index) {
//             // if (index.isOdd) {
//             //   return Divider();
//             // }
//             return _transaction(names[index]);
//           }),
//     );
//   }

//   Widget _transaction(String s) {
//     print("111111111111111111111");
//     return ListTile(
//       title: Text(
//         s,
//         style: TextStyle(fontSize: 18),
//       ),
//     );
//   }
// }
