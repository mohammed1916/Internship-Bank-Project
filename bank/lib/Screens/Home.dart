import 'package:flutter/material.dart';

import 'package:bank/Screens/AllCustomers.dart';

class Home extends StatefulWidget {
  const Home();

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var textStyle = TextStyle(
    fontSize: 25,
    color: Colors.white,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => onTransaction(AllCustomers('All Customers')),
                    child: Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(color: Colors.lightBlue),
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.supervised_user_circle,
                              color: Colors.white,
                            ),
                            SizedBox(height: 20.0),
                            Text('All Customers', style: textStyle),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => onTransaction(AllCustomers('All Customers')),
                    child: Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(color: Colors.lightBlue[500]),
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.receipt_long,
                              color: Colors.white,
                            ),
                            SizedBox(height: 20.0),
                            Text('All Customers', style: textStyle),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.home,
        ),
        onPressed: () {
          onTransaction(Home());
        },
      ),
    );
  }

  onTransaction(StatefulWidget swidget) {
    debugPrint("Navigator");
    Navigator.push(context, MaterialPageRoute(builder: (context) => swidget));
  }
}
