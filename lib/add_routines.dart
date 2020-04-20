import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController _routineNameCtr;
  bool _onAlarm = false;
  List<bool> isSelected = List.generate(2, (index) => false);
  List<String> dayList = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

  @override
  void initState() {
    _routineNameCtr = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Column(
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
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 30),
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
                        '0:00 am >',
                        style: TextStyle(
                            fontFamily: 'LemonMilkLight', color: Colors.grey),
                      ),
                      onTap: () {
                        debugPrint('abc');
                      },
                    ))
              ],
            ),
            SizedBox(
              height: 5.0,
            ),
            Row(
              children: <Widget>[
                dayBox(dayList[0]),
              ],
            )
          ],
        ),
      )),
    );
  }

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

  Widget dayBox(String day) {
    Color borderColor = Colors.white;
    Color bgColor = Colors.black;
    List<Color> colors = [Colors.white, Colors.black];

    return InkWell(
      onTap: () {
        setState(() {
          if (borderColor == Colors.white) {
            borderColor = Colors.black;
            borderColor = Colors.white;
          } else {
            borderColor = Colors.white;
            borderColor = Colors.black;
          }
        });
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        decoration: new BoxDecoration(
            shape: BoxShape.circle,
            color: borderColor,
            border: Border.all(
              color: bgColor,
              width: 2.0,
            )
        ),
        child: Text(
            day,
          style: TextStyle(
              fontFamily: 'malgunBold'
          ),
        ),
      ),
    );
  }
}
