import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double sAmount;
  final double pctTotal;

  ChartBar({this.label, this.sAmount, this.pctTotal});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraint) {
        return Column(
          children: <Widget>[
            Container(
              height: constraint.maxHeight * 0.15,
              child: FittedBox(
                  child: Text(
                '\$${sAmount.toStringAsFixed(0)}',
                style: TextStyle(color: Colors.black87),
              )),
            ),
            SizedBox(
              height: constraint.maxHeight * 0.05,
            ),
            Container(
                height: constraint.maxHeight * 0.6,
                width: 10,
                child: Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey[300],
                          width: 8.0,
                        ),
                        color: Colors.blue[200],
                        // borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    FractionallySizedBox(
                      heightFactor: pctTotal,
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Color(0xFF66BB6A),
                              Color(0xFFE91E63),
                              Color(0xFF1E88E5),
                              Color.fromARGB(10, 20, 20, 2)
                            ],
                          ),
                          // borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    )
                  ],
                )),
            SizedBox(
              height: 4,
            ),
            Text(
              label,
              style: TextStyle(color: Colors.black87),
            ),
          ],
        );
      },
    );
  }
}
