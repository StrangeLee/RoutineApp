import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'day_box.dart';
import 'show_routines.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController _routineNameCtr; // TextFields' Controller

  bool _onAlarm = false;
  String _alarmTime = '0:00 AM >';

  TimeOfDay _picked; // user selected time value;

  Future<Null> selectTime(BuildContext context) async {
    _picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);

    setState(() {
      if (_picked != null) {
        print(_picked);
        _alarmTime = localizations.formatTimeOfDay(_picked) + ' >';
      }
    });
  }

  @override
  void initState() {
    _routineNameCtr = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'New Routine',
                      style: TextStyle(
                        fontFamily: 'LemonMilkMedium',
                        fontSize: 30.0,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 25),
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: '루틴 이름 입력',
                                hintStyle: TextStyle(
                                    color: Colors.grey[400],
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
                                color: Colors.grey[500],
                                fontSize: 18.0,
                                fontFamily: 'malgunBold'),
                          ),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        DayButton(day: '일'),
                        DayButton(day: '월'),
                        DayButton(day: '화'),
                        DayButton(day: '수'),
                        DayButton(day: '목'),
                        DayButton(day: '금'),
                        DayButton(day: '토'),
                      ],
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(5, 10, 0, 5),
                      child: Text(
                        '습관 종료 알림',
                        style: TextStyle(
                            color: Colors.grey[500],
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
        )
      ),
    );
  }

  // 회색 뷰
  Widget settingBox(String title, Widget widget) {
    return Material(
      color: Colors.grey[200],
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
                debugPrint('routineName is ' + _routineNameCtr.text);
                debugPrint('Selected TIme  is $_picked');

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
}
