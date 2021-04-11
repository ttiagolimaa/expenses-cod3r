import 'dart:io';
import 'dart:math';
import 'package:expenses/components/chart.dart';
import 'package:flutter/material.dart';

import 'components/transaction_form.dart';
import 'components/transaction_list.dart';
import 'models/transaction.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              button: TextStyle(color: Colors.white)),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                      headline6: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )))),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showChart = false;
  final List<Transaction> _transactions = [
    // Transaction(
    //     id: Random().nextDouble().toString(),
    //     title: 'title',
    //     value: 10.0,
    //     date: DateTime.now()),
    // Transaction(
    //     id: Random().nextDouble().toString(),
    //     title: 'title',
    //     value: 10.0,
    //     date: DateTime.now()),
    // Transaction(
    //     id: Random().nextDouble().toString(),
    //     title: 'title',
    //     value: 10.0,
    //     date: DateTime.now()),
    // Transaction(
    //     id: Random().nextDouble().toString(),
    //     title: 'title',
    //     value: 10.0,
    //     date: DateTime.now()),
    // Transaction(
    //     id: Random().nextDouble().toString(),
    //     title: 'title',
    //     value: 10.0,
    //     date: DateTime.now()),
    // Transaction(
    //     id: Random().nextDouble().toString(),
    //     title: 'title',
    //     value: 10.0,
    //     date: DateTime.now()),
    // Transaction(
    //     id: Random().nextDouble().toString(),
    //     title: 'title',
    //     value: 10.0,
    //     date: DateTime.now()),
    // Transaction(
    //     id: Random().nextDouble().toString(),
    //     title: 'title',
    //     value: 10.0,
    //     date: DateTime.now()),
    // Transaction(
    //     id: Random().nextDouble().toString(),
    //     title: 'title',
    //     value: 10.0,
    //     date: DateTime.now()),
    // Transaction(
    //     id: Random().nextDouble().toString(),
    //     title: 'title',
    //     value: 10.0,
    //     date: DateTime.now()),
    // Transaction(
    //     id: Random().nextDouble().toString(),
    //     title: 'title',
    //     value: 10.0,
    //     date: DateTime.now()),
    // Transaction(
    //     id: Random().nextDouble().toString(),
    //     title: 'title',
    //     value: 10.0,
    //     date: DateTime.now()),
  ];

  List<Transaction> get _recentTransactions {
    return _transactions
        .where((element) =>
            element.date.isAfter(DateTime.now().subtract(Duration(days: 7))))
        .toList();
  }

  _addTransaction(
      {required String title, required double value, required DateTime date}) {
    final newTransaction = Transaction(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        date: date);

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((element) => element.id == id);
    });
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15.0))),
      // builder: (ctx) {
      //   return TransactionForm(_addTransaction);
      // backgroundColor: Colors.red,
      isScrollControlled: true,

      builder: (ctx) => TransactionForm(_addTransaction),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    final appBar = AppBar(
      title: Text('Despesas Pessoais'),
      actions: <Widget>[
        if (isLandscape)
          IconButton(
              icon: Icon(_showChart ? Icons.list : Icons.bar_chart),
              onPressed: () {
                setState(() {
                  _showChart = !_showChart;
                });
              }),
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _openTransactionFormModal(context)),
      ],
    );

    final availableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Container(
          color: Colors.grey[200],
          height: availableHeight,
          // padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if (_showChart || !isLandscape)
                Container(
                  child: Chart(_recentTransactions),
                  height: availableHeight * (isLandscape ? 0.7 : 0.3),
                ),
              if (!_showChart || !isLandscape)
                Container(
                  child: TransactionList(_transactions, _deleteTransaction),
                  height: availableHeight * (isLandscape ? 1 : 0.7),
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: Platform.isIOS
          ? Container()
          : FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => _openTransactionFormModal(context),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
