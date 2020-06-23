import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:intl/intl.dart';
import 'package:routineapp/firebase/firebase_crud.dart';
import 'package:routineapp/main.dart';
import '../widget/day_box.dart';
import 'show_routines.dart';

crudMedthods crudObj = new crudMedthods();

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController _routineNameCtr; // TextFields' Controller

  bool _onAlarm = false;
  String _alarmTime = '0:00 AM >';

  TimeOfDay _picked; // user selected time value;

  String selectedDays = ""; // daybox 의 clicked 가 true인 요일를 담은 변수

  List<DayButton> dayButtons = new List<DayButton>();
  List<String> days = List.unmodifiable(['일', '월', '화', '수', '목', '금', '토']);

  var testBtn = DayButton(
    day: '월',
    clicked: true,
  );

  // time dialog
  Future<Null> selectTime(BuildContext context) async {
    _picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);

    setState(() {
      if (_picked != null) {
        _alarmTime = localizations.formatTimeOfDay(_picked) + ' >';
      }
    });
  }

  @override
  void initState() {
    _routineNameCtr = TextEditingController();
    days.forEach((element) { // DayButton 객체 생성 (일~월 까지)
      dayButtons.add(
        new DayButton(
          day: element,
          clicked: true,
        )
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              end: Alignment.topLeft,
              begin: Alignment.bottomRight,
              colors: [Colors.lightBlueAccent, Colors.blue[100]]
            )
          ),
          child: Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      GradientText(
                        'New Routine',
                        gradient: LinearGradient(
                          colors: [MyApp.colorDeepBlue, MyApp.colorLightBlue, MyApp.colorBlue]
                        ),
                        style: TextStyle(
                          fontFamily: 'LemonMilkMedium',
                          fontSize: 30.0,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: '루틴 이름 입력',
                                  hintStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide.none,
                                  )),
                              controller: _routineNameCtr,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(5, 5, 0, 5),
                            child: Text(
                              '루틴 알람',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontFamily: 'malgunBold'),
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          settingBox(
                              '알림 상태',
                              Switch(
                                value: _onAlarm,
                                onChanged: (value) {
                                  setState(() {
                                    _onAlarm = value;
                                  });
                                },
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          settingBox(
                              '알림 시간',
                              InkWell(
                                child: Text(
                                  _alarmTime,
                                  style: TextStyle(
                                      fontFamily: 'LemonMilkLight',
                                      color: Colors.grey),
                                ),
                                onTap: () {
                                  selectTime(context);
                                },
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: dayButtons,
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 0, 0, 10),
                        child: Text(
                          '습관 종료 알림',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontFamily: 'malgunBold'),
                        ),
                      ),
                      settingBox(
                        '알림 종류',
                        InkWell(
                          onTap: null, // Todo : Firebase Push Notification
                          child: Text(
                            '기본 >',
                            style: TextStyle(
                                fontFamily: 'LemonMilkLight',
                                color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      SizedBox(
                        width: 150.0,
                        height: 45.0,
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => ShowRoutines()));
                          },
                          elevation: 5.0,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Text('취소'),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 150.0,
                        height: 45.0,
                        child: RaisedButton(
                          onPressed: () {
                            confirmFunction();
                          },
                          elevation: 5.0,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Text('확인'),
                        ),
                      ),
                    ],
                  ),
                ],
              )
          ),
        )
      ),
    );
  }

  // 컨테이너 뷰
  Widget settingBox(String title, Widget widget) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20.0),
      elevation: 1.0,
      child: Container(
        height: 55,
        child: Padding(
          padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(fontSize: 16.0, fontFamily: 'malgunBold'),
              ),
              widget
            ],
          ),
        ),
      ),
    );
  }

  // null exception 일때 뛰우는 dialog
  Future<void> noticeDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('알림'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('입력하지않은 부분이 있습니다.'),
                Text('제목과 시간설정을 확인해주세요.'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('확인'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // 데이터 추가 확인 dialog
  Future<void> saveDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('알림'),
          content: Text('이 설정대로 루틴을 만들겠습니까?'),
          actions: <Widget>[
            FlatButton(
              child: Text('취소'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('확인'),
              onPressed: () {
                 dayButtons.forEach((element) { // 요일 체크
                  if (element.clicked == true) {
                    setState(() {
                      selectedDays += "${element.day.toString()}, ";
                    });
                  }
                });
                setState(() {
                  selectedDays = selectedDays.substring(0, selectedDays.length - 2);
                });

                _addRoutines( // firebase db 에 data 추가
                  _routineNameCtr.text,
                  DateFormat('HH:mm').format(DateTime(2002, 04, 17, _picked.hour, _picked.minute)),
                  selectedDays
                );

                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => ShowRoutines(
                    alarmTime: _picked.toString(),
                  ),
                ));
              },
            ),
          ],
        );
      },
    );
  }

  // 확인 버튼 동작 메서드
  void confirmFunction() {
    if (_routineNameCtr.text == null || _picked == null) {
      noticeDialog(); // ignore: unnecessary_statements
      debugPrint('Something is null');
    } else {
      saveDialog();
    }
  }

// firebase 로 데이터 전송
  void _addRoutines(String title, String times, String days) {
    crudObj.addData({
      "title" : title,
      "time" : times,
      "days" : days,
      "details" : {
      }
    }).then((value) => print("success add data"));
  }
}
