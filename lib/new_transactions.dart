import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectDate;
  String _animationName = 'Idle';

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectDate == null) {
      return;
    }
    print(_selectDate);
    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectDate,
    );

    Navigator.of(context).pop();
  }

  void _onButtonTap() {
    setState(() {
      if (_animationName == 'Idle' || _animationName == 'Restart') {
        _animationName = 'Loading';
      } else {
        _animationName = 'Restart';
      }
    });
  }

  _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: Colors.orange,
              onPrimary: Colors.white,
              surface: Colors.pink[300],
              onSurface: Colors.yellow,
            ),
            dialogBackgroundColor: Colors.black87,
          ),
          child: child,
        );
      },
    ).then((pickedDate) {
      print(pickedDate);
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black87,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(15), topLeft: Radius.circular(15)),
      ),
      child: Stack(
        children: <Widget>[
          ListView(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(1),
            children: <Widget>[
              SizedBox(height: 25.0),
              Row(
                children: <Widget>[
                  // title: new Text('Close'),
                  IconButton(
                    icon: Icon(Icons.close),
                    color: Colors.red,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  Center(
                    child: Text(
                      'Add NewTransaction',
                      style: TextStyle(color: Colors.yellow),
                    ),
                  ),

                  new DropdownButton<String>(
                    items: <String>[
                      'Add Transaction',
                      'Add Transfer',
                      'Add Reminder'
                    ].map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (_) {},
                  )
                ],
              ),
              SizedBox(height: 25.0),
              TextFormField(
                autofocus: true,
                showCursor: true,
                style: TextStyle(fontSize: 20, color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Title",
                  hintStyle: TextStyle(fontSize: 14),
                  border: OutlineInputBorder(), // <-- This is the key
                  labelText: "Title",
                ),
                obscureText: false,
                validator: (value) =>
                    value.isEmpty ? ' Please Enter Title' : null,

                controller: _titleController,
                keyboardType: TextInputType.text,
                // onSubmitted: (_) => _submitData(),
              ),
              SizedBox(
                height: 25.0,
              ),
              TextFormField(
                autofocus: false,
                showCursor: true,
                style: TextStyle(fontSize: 20, color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Amount",
                  hintStyle: TextStyle(fontSize: 14),
                  border: OutlineInputBorder(), // <-- This is the key
                  labelText: "Amount",
                ),
                obscureText: false,
                validator: (value) =>
                    value.isEmpty ? 'Please Enter Amount' : null,

                controller: _amountController,
                keyboardType: TextInputType.number,
                // onSubmitted: (_) => _submitData(),
              ),
              SizedBox(
                height: 25.0,
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _selectDate == null
                            ? 'No Date Choosen!'
                            : 'Picked date: ${DateFormat.yMd().format(_selectDate)}',
                        style: TextStyle(color: Colors.yellow),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    IconButton(
                        icon: Icon(Icons.perm_contact_calendar, size: 30),
                        color: Colors.blue[400],
                        onPressed: _presentDatePicker),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.red)),
                    color: Colors.yellow,
                    textColor: Colors.red,
                    padding: EdgeInsets.all(8.0),
                    onPressed: _submitData,
                    child: Text(
                      "Add to Cart".toUpperCase(),
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
