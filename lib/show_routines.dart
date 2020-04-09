import 'package:flutter/cupertino.dart';
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    // TODO : onPressed 함수 추가 및 새 페이지 만들기
                    onPressed: null,
                  )
                ],
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Text(
                  '오늘 하루는 어땠나요?',
                  style: TextStyle(
                    fontSize: 25.0,
                    fontFamily: 'LemonMilkMedium',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // TODO : Bottom Line 추가
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0)
              ),
              Expanded( // 왜 Expanded 로 감싸지?
                  child: ListView(
                    children: <Widget>[
                      routineItem('Morning Routine', '월, 화, 수, 목, 금', '7:00'),
                      routineItem('Lunch Routine', '월, 화, 수, 목, 금', '12:00'),
                      routineItem('Night Routine', '일, 월, 화, 수, 목, 금, 토', '21:00'),
                    ],
                  )
              )
            ],
          ),
      )
    );
  }

  Widget routineItem(String title, String days, String time) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Material(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.grey[200],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 15, 0, 5),
                  child: Text(
                    title,
                    style: TextStyle(
                        fontSize: 20.0
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 10),
                  child: Row(
                    children: <Widget>[
                      Text(
                        '$time - ',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        days,
                        style: TextStyle(
                            fontSize: 13.0,
                        ),
                      ),
                    ],
                  )
                )
              ],
            ),
            IconButton(
              icon: Icon(
                  Icons.arrow_forward_ios
              ),
              // TODO : onPressed 함수 추가 및 새 페이지 만들기
              onPressed: null,
              alignment: Alignment.centerRight,
            )
          ],
        ),
      ),
    );
  }

}



