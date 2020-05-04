import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:routineapp/add_routines.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:routineapp/show_detail_routines.dart';

class ShowRoutines extends StatefulWidget {
  // TODO : 생성자 추가
  String routineName;
  bool setAlarm;
  String alarmTime;
  List<bool> dayList;

  ShowRoutines({
    Key key,
    @required this.routineName,
    @required this.setAlarm,
    @required this.alarmTime,
    @required this.dayList
  }) : super(key : key);

  @override
  _ShowRoutinesState createState() => _ShowRoutinesState(routineName, setAlarm, alarmTime, dayList);
}

class _ShowRoutinesState extends State<ShowRoutines> {
  var now = new DateTime.now();

  String routineName;
  bool setAlarm;
  String alarmTime;
  List<bool> dayList;

  _ShowRoutinesState(this.routineName, this.setAlarm, this.alarmTime, this.dayList);

  @override
  Widget build(BuildContext context) {

    if (routineName != null) {
      String days = '';
      for (int i = 0; i < dayList.length; i++) {
        if (dayList[i] == true) {
          days += getDay(i) + ' ';
        }
        days.trim();
      }
      debugPrint('name = $routineName, Alarm is $setAlarm on $alarmTime every ');
    }

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
                    onPressed: () => {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => AddPage()
                      ))
                    },
                  )
                ],
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: TyperAnimatedTextKit(
                  text: [
                    '오늘 하루는 어땠나요?'
                  ],
                  textStyle: TextStyle(
                    fontSize: 25.0,
                    fontFamily: 'LemonMilkMedium',
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start,
                  alignment: AlignmentDirectional.topStart,
                  isRepeatingAnimation: false,
                  speed: new Duration(
                    milliseconds: 200,
                  ),
                )
              ),
              Divider(
                height: 5.0, // 위 아래 합친 60
                color: Colors.grey[850],
                thickness: 0.5,
                endIndent: 10.0,
                indent: 10.0,
              ),
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
                      Icon(
                        Icons.access_alarm
                      ),
                      Text(
                        '$time - ',
                        style: TextStyle(
                          fontSize: 15.0, 
                          fontWeight: FontWeight.bold, 
                          fontFamily: 'LemonMilkLight',
                        ),
                      ),
                      Text(
                        days,
                        style: TextStyle(
                            fontSize: 13.0,
                            fontFamily: 'LemonMilkLight', 
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
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => DetailRoutine(
                    title: title,
                    alarmTime: time,
                    dayList: days,
                  )
                ));
              },
              alignment: Alignment.centerRight,
            )
          ],
        ),
      ),
    );
  }

  String getDay(int number) {
    switch (number) {
      case 0 :
        return 'SunDay';
        break;
      case 1 :
        return 'MonDay';
        break;
      case 2 :
        return 'TuesDay';
        break;
      case 3 :
        return 'WendsDay';
        break;
      case 4 :
        return 'ThursDay';
        break;
      case 5 :
        return 'FriDay';
        break;
      case 6 :
        return 'SaturDay';
        break;
      default :
        return 'error';
    }
  }

}



