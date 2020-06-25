import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:routineapp/data/routine.dart';
import '../main.dart';
import 'file:///C:/Programing/Flutter/routine_app/lib/page/startRoutine.dart';
import 'package:routineapp/widget/edit_pop_dialog.dart';

class DetailRoutine extends StatefulWidget {
  Routine routine;

  DetailRoutine({this.routine});

  @override
  _DetailRoutineState createState() =>
      _DetailRoutineState(routine);
}

class _DetailRoutineState extends State<DetailRoutine> {
  Routine routine;

  // menu icon 세팅
  bool isMenu = true;
  Icon menuIcon = Icon(
    Icons.menu,
    color: Colors.black,
  );
  Icon cancelIcon = Icon(
    Icons.cancel,
    color: Colors.black,
  );

  _DetailRoutineState(this.routine);

  int _navyIndex = 0;

  @override
  void initState() {
    routine.details.forEach((element) {
      print(element.name + ', ${element.time}');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
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
        appBar: AppBar(
          backgroundColor: Colors.blue[100],
          elevation: 0.0,
          automaticallyImplyLeading: false,
          title: GradientText(
            routine.title,
            gradient: LinearGradient(
                colors: [MyApp.colorDeepBlue, MyApp.colorLightBlue]),
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontFamily: 'LemonMilkMedium',
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: menuIcon,
              onPressed: () {
                setState(() {
                  showGeneralDialog(
                    barrierColor: Colors.black.withOpacity(0.5),
                    transitionBuilder: (context, a1, a2, widget) {
                      return Transform.scale(
                        scale: a1.value,
                        child: Opacity(
                          opacity: a1.value,
                          child: EditDialog(),
                        ),
                      );
                    },
                    transitionDuration: Duration(milliseconds: 200),
                    barrierDismissible: true,
                    barrierLabel: '',
                    context: context,
                    pageBuilder: (context, animation1, animation2) {},
                  );
                });
              },
            )
          ],
        ),
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                end: Alignment.topCenter,
                begin: Alignment.bottomCenter,
                colors: [Colors.lightBlueAccent, Colors.blue[100]]
              )
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        detailItem('책 읽기', 5, true),
                        SizedBox(
                          height: 10.0,
                        ),
                        detailItem('책 읽기', 1, false),
                        SizedBox(
                          height: 10.0,
                        ),
                        detailItem('책 읽기', 30, false),
                        SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /**
   * 인자 중 isFinish 로 완료 햇는지 안했는지 결정
   */
  Widget detailItem(String title, int time, bool isFinish) {
    var titleText;
    if (isFinish) {
      titleText = Text(
          title,
          style: TextStyle(
              fontFamily: 'malgunBold',
              fontSize: 17.0,
              decoration: TextDecoration.lineThrough,
              color: Colors.white,
          )
      );
    } else {
      titleText = Text(
          title,
          style: TextStyle(
              fontFamily: 'malgunBold',
              fontSize: 17.0,
          )
      );
    }
    return Material(
//      shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.circular(15.0),
//          side: BorderSide(
//            color: Colors.black,
//            width: 1.0,
//          )
//      ),
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if (isFinish) {
               showDialog(
                 context: context,
                 barrierDismissible: false,
                 builder: (BuildContext context) {
                   return AlertDialog(
                     title: Text('알림'),
                     content: Text('이미 완료한 루틴입니다.'),
                     actions: [
                       FlatButton(
                         child: Text('확인'),
                         onPressed: () {
                           Navigator.of(context).pop();
                         },
                       )
                     ],
                   );
                 }
               );
            } else {
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) =>
                  new StartRoutine(title: title, timeOut: time))
              );
            }
          },
          child: Container(
            padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
            decoration: new BoxDecoration(
                color: isFinish ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(
                  color: Colors.black,
                  width: 1.0,
                )),
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
                      color: isFinish ? Colors.white : Colors.black,
                      size: 35.0,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    titleText,
                    SizedBox(
                      width: 5.0,
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.timer,
                      color: isFinish ? Colors.white : Colors.black,
                    ),
                    Text(
                      time.toString() + 'min',
                      style: TextStyle(
                        fontFamily: 'malgunBold',
                        color: isFinish ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }

  void navigationStuff(int index) {
    print('now index = $index');
    switch (index) {
      case 0:
        Navigator.pop(context);
        break;
      case 1:
        break;
      case 2:
        break;
    }
  }
}
