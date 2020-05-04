import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DetailRoutine extends StatefulWidget {

  final String title;
  final String alarmTime;
  final String dayList;

  const DetailRoutine({Key key, this.title, this.alarmTime, this.dayList}) : super(key: key);

  @override
  _DetailRoutineState createState() => _DetailRoutineState(this.title, this.alarmTime, this.dayList);
}

class _DetailRoutineState extends State<DetailRoutine> {

  String title;
  String alarmTime;
  String dayList;

  _DetailRoutineState(this.title, this.alarmTime, this.dayList);

  // ToDo : AppBar UI 수정 하기
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
            '$title',
          style: TextStyle(
            color: Colors.black
          ),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.add_circle_outline,
                color: Colors.black,
              ),
              // ToDo : Add onPressed
              onPressed: null,
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: ListView(
          children: <Widget>[
            detailItem('책 읽기', '30'),
            SizedBox(
              height: 10.0,
            ),
            detailItem('책 읽기', '30'),
            SizedBox(
              height: 10.0,
            ),
            detailItem('책 읽기', '30'),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
      )
    );
  }

  // Todo : 메서드 인자 이름 바꾸기
  Widget detailItem(String title, String time) {
    return Material(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(
            color: Colors.black,
            width: 1.0,
          )
      ),
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.fromLTRB(
            10, 10, 10, 10
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.book,
                  size: 35.0,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  title,
                  style: TextStyle(
                      fontFamily: 'malgunBold',
                      fontSize: 17.0
                  ),
                ),
                SizedBox(
                  width: 5.0,
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Icon(
                  Icons.timer,
                ),
                Text(
                  time + 'min',
                  style: TextStyle(
                    fontFamily: 'malgunBold',
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

}
