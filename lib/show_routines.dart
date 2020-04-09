import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ShowRoutines extends StatefulWidget {
  @override
  _ShowRoutinesState createState() => _ShowRoutinesState();
}

class _ShowRoutinesState extends State<ShowRoutines> {

  var now = new DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 15, 0, 15),
                    child: Text(
                      new DateFormat('MM.dd (EEE) hh:mm').format(now),
                      style: TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'LemonMilkLight'
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                        Icons.add_circle_outline
                    ),
                    onPressed: null,
                  )
                ],
              ),
            ],
          )
      )
    );
  }
}
