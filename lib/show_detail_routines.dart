import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:routineapp/edit_detail_routine.dart';
import 'package:routineapp/startRoutine.dart';
import 'main.dart';

class DetailRoutine extends StatefulWidget {

  final String routineName;
  final String alarmTime;
  final String dayList;

  const DetailRoutine({Key key, this.routineName, this.alarmTime, this.dayList}) : super(key: key);

  @override
  _DetailRoutineState createState() => _DetailRoutineState(this.routineName, this.alarmTime, this.dayList);
}

class _DetailRoutineState extends State<DetailRoutine> {

  String routineName;
  String alarmTime;
  String dayList;

  _DetailRoutineState(this.routineName, this.alarmTime, this.dayList);

  // ToDo : AppBar UI 수정 하기
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
            '$routineName ',
          style: TextStyle(
            color: Colors.black,
            fontSize: 30.0,
            fontFamily: 'LemonMilkMedium',
          ),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.black,
              ),
              // ToDo : Add onPressed
              onPressed: () {
                Navigator.pushNamed(context, '/edit');
              },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  detailItem('책 읽기', 5),
                  SizedBox(
                    height: 10.0,
                  ),
                  detailItem('책 읽기', 1),
                  SizedBox(
                    height: 10.0,
                  ),
                  detailItem('책 읽기', 30),
                  SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            )
          ],
        ),
      )
    );
  }

  // Todo : 메서드 인자 이름 바꾸기
  Widget detailItem(String title, int time) {
    return Material(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(
            color: Colors.black,
            width: 1.0,
          )
      ),
      color: Colors.white,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => StartRoutine(
              title: title,
              timeOut: time,
            )
          ));
        },
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
                    time.toString() + 'min',
                    style: TextStyle(
                      fontFamily: 'malgunBold',
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      )
    );
  }

}
