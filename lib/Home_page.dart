import 'package:expense_app/charts.dart';
import 'package:expense_app/new_transactions.dart';
import 'package:expense_app/transaction.dart';
import 'package:expense_app/transaction_list.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:breathing_rotating_button/breathing_rotating_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'flutter app',
      theme: ThemeData.dark().copyWith(
          primaryColor: Colors.black,
          textTheme: GoogleFonts.latoTextTheme(
            Theme.of(context).textTheme,
          ),
          accentColor: Colors.teal[200],
          scaffoldBackgroundColor: Colors.grey[300]),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: 'r1',
      title: 'shopping bills',
      amount: 53.63,
      date: DateTime.now(),
    ),
    Transaction(
      id: 'r2',
      title: 'rent',
      amount: 57.99,
      date: DateTime.now(),
    ),
  ];

  // bool _showChart = true;
  final today = DateTime.now();
  final firstdate = DateTime(DateTime.now().year, 1); // 1,1,2019

  List<Transaction> get _recentTransactions {
    print("Date diff: ");
    print(today.difference(firstdate).inDays);
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(
            days: 365,
          ),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: ctx,
      isScrollControlled: true,
      isDismissible: false,
      builder: (_) {
        return DraggableScrollableSheet(
            initialChildSize: 0.8,
            //set this as you want
            maxChildSize: 0.8,
            //set this as you want
            minChildSize: 0.8,
            //set this as you want
            expand: true,
            builder: (context, scrollController) {
              return Container(
                margin: EdgeInsets.all(0),
                padding: EdgeInsets.all(0),
                height: 35,
                width: double.infinity,
                child: NewTransaction(_addNewTransaction),
              ); //whatever you're returning, does not have to be a Container
            });
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((fx) {
        return fx.id == id;
      });
    });
    print(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: new AppBar(
        title: new Center(
          child: Text(
            'Expense App',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey, fontSize: 30),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            color: Colors.yellowAccent,
            onPressed: () => _startAddNewTransaction(context),
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 15.0),
              SizedBox(height: 5.0),
              Expanded(
                child: MediaQuery.of(context).orientation ==
                        Orientation.portrait
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.3,
                            child: Chart(_recentTransactions),
                          ),
                          Expanded(
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.7,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(25.0),
                                    topRight: Radius.circular(25.0),
                                  ),
                                  color: Colors.black87),
                              child: TransactionList(
                                  _userTransactions, _deleteTransaction),
                            ),
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            // height: MediaQuery.of(context).size.height* 0.2,
                            child: Chart(_recentTransactions),
                          ),
                          Expanded(
                            child: Container(
                              // height: MediaQuery.of(context).size.height * 0.6,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(25.0),
                                  bottomLeft: Radius.circular(25.0),
                                ),
                                color: Theme.of(context).canvasColor,
                              ),
                              child: TransactionList(
                                  _userTransactions, _deleteTransaction),
                            ),
                          ),
                        ],
                      ),
              ),
            ],
          ),
          Positioned(
            bottom: 18.0,
            right: 18.0,
            child: FloatingActionButton(
              backgroundColor: Colors.pink[200],
              child: BreathingRotatingButton(
                background: Colors.pink[200],
                foreground: Colors.white,
                icon: Icons.add_circle,
                iconColor: Colors.blue[800],
                radius: 20,
                rotate: true,
              ),
              onPressed: () => _startAddNewTransaction(context),
            ),
          ),
        ],
      ),
    );
  }
}
