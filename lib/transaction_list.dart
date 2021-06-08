import 'package:flutter/material.dart';
import 'transaction.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  BorderRadiusGeometry _borderRadius = BorderRadius.circular(8);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
        height: 450,
        child: ListView.builder(
          itemBuilder: (ctx, index) {
            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  side: BorderSide(width: 2, color: Colors.blue[200])),
              color: Colors.pink[200],
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
              elevation: 8,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/d1.png'),
                  backgroundColor: Colors.transparent,
                  radius: 35,
                  child: Padding(
                    padding: EdgeInsets.all(6),
                  ),
                ),
                title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(transactions[index].title,
                          style: Theme.of(context).textTheme.title),
                      SizedBox(
                        height: 4,
                      ),
                      Text('\$${transactions[index].amount}'),
                      Text(
                        DateFormat('EEE, dd MMM yyyy')
                            .format(transactions[index].date),
                      ),
                    ]),
                trailing: IconButton(
                  icon: Icon(Icons.delete_forever),
                  color: Colors.blue[800],
                  onPressed: () {
                    deleteTx(transactions[index].id);
                  },
                ),
              ),
            );
          },
          itemCount: transactions.length,
        ),
      ),
    );
  }
}
