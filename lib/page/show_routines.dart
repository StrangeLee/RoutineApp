import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'file:///C:/Programing/Flutter/routine_app/lib/page/show_detail_routines.dart';
import 'package:routineapp/main.dart';

class ShowRoutines extends StatefulWidget {
  // TODO : 생성자 추가
  final String routineName;
  final bool setAlarm;
  final String alarmTime;
  final List<bool> dayList;

  ShowRoutines(
      {@required this.routineName,
      @required this.setAlarm,
      @required this.alarmTime,
      @required this.dayList});

  @override
  _ShowRoutinesState createState() =>
      _ShowRoutinesState(routineName, setAlarm, alarmTime, dayList);
}

class _ShowRoutinesState extends State<ShowRoutines> {
  var now = new DateTime.now();

  // constructor parameter
  String routineName;
  bool setAlarm;
  String alarmTime;
  List<bool> dayList;

  _ShowRoutinesState(
      this.routineName, this.setAlarm, this.alarmTime, this.dayList);

  int _navyIndex = 0; // bottomNavigation Index

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
      debugPrint(
          'name = $routineName, Alarm is $setAlarm on $alarmTime every ');
    }

    return WillPopScope(
      onWillPop: () {
        print('abcdef');
        return exitDialog();
      },
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: false,
          showSelectedLabels: false,
          currentIndex: _navyIndex,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.arrow_back,
              ),
              title: Text('back'),
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.assessment,
                ),
                title: Text('stat')),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                ),
                title: Text('setting'))
          ],
          onTap: (value) {
            setState(() {
              _navyIndex = value;
            });
            navigationStuff(_navyIndex);
          },
        ),
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                end: Alignment.topLeft,
                begin: Alignment.bottomRight,
                colors: [Colors.lightBlueAccent, Colors.blue[100]]
              )
            ),
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
                            fontSize: 15.0, fontFamily: 'LemonMilkLight'),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.add_circle_outline),
                      onPressed: () =>
                      {Navigator.of(context).pushNamed('/add')},
                    )
                  ],
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: TyperAnimatedTextKit(
                      text: ['오늘 하루는 어땠나요?'],
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
                    )),
                Divider(
                  height: 5.0, // 위 아래 합친 60
                  color: Colors.grey[850],
                  thickness: 0.5,
                  endIndent: 10.0,
                  indent: 10.0,
                ),
                Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
                Expanded(
                  // 왜 Expanded 로 감싸지?
                    child: ListView(
                      children: <Widget>[
                        routineItem('Morning Routine', '월, 화, 수, 목, 금', '7:00'),
                        routineItem('Lunch Routine', '월, 화, 수, 목, 금', '12:00'),
                        routineItem(
                            'Night Routine', '일, 월, 화, 수, 목, 금, 토', '21:00'),
                        routineItem('Night 1', '일, 월, 화, 수, 목, 금, 토', '21:00'),
                        routineItem(
                            'Night Ro2utine', '일, 월, 화, 수, 목, 금, 토', '21:00'),
                        routineItem(
                            'Night Rout3ine', '일, 월, 화, 수, 목, 금, 토', '21:00'),
                        routineItem(
                            'Night Rout6ine', '일, 월, 화, 수, 목, 금, 토', '21:00'),
                        routineItem(
                            'Night Rout4ine', '일, 월, 화, 수, 목, 금, 토', '21:00'),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ListView Item
  Widget routineItem(String title, String days, String time) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white
        ),
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
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 10),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.access_alarm),
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
                    ))
              ],
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () {
                print('Head Routine Item is $title');
                Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new DetailRoutine(
                    routineName: title, alarmTime: time, dayList: days)));
              },
              alignment: Alignment.centerRight,
            )
          ],
        ),
      ),
    );
  }

  // 요일을 얻는 메서드
  String getDay(int number) {
    switch (number) {
      case 0:
        return 'SunDay';
        break;
      case 1:
        return 'MonDay';
        break;
      case 2:
        return 'TuesDay';
        break;
      case 3:
        return 'WendsDay';
        break;
      case 4:
        return 'ThursDay';
        break;
      case 5:
        return 'FriDay';
        break;
      case 6:
        return 'SaturDay';
        break;
      default:
        return 'error';
    }
  }

  void navigationStuff(int index) {
    print('now index = $index');
    switch (index) {
      case 0:
        exitDialog();
        break;
      case 1:
        break;
      case 2:
        break;
    }
  }

  // app exit dialog
  Future<void> exitDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('나갈거에욥?!'),
          content: Text('Chose one'),
          actions: <Widget>[
            FlatButton(
                child: Text('아니용!'),
                onPressed: () {
                  print('do nothing');
                  Navigator.of(context).pop();
                }),
            FlatButton(
              child: Text('넹!'),
              onPressed: () {
                SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              },
            ),
          ],
        );
      },
    );
  }
}
