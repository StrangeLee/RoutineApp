import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:routineapp/data/routine.dart';
import 'package:routineapp/firebase/firebase_crud.dart';
import 'file:///C:/Programing/Flutter/routine_app/lib/page/show_detail_routines.dart';
import 'package:routineapp/main.dart';

// 2020/07/03 Todo : List<dynamic> to List<Routines> 변환 방법 찾기
class ShowRoutines extends StatefulWidget {
  @override
  _ShowRoutinesState createState() => _ShowRoutinesState();
}

class _ShowRoutinesState extends State<ShowRoutines> {
  var now = new DateTime.now();

  int _navyIndex = 0; // bottomNavigation Index

  CrudMethods crudObj = new CrudMethods();
  var streamList; // CrudMethods.getData() 에서 받아온 Stream<QuerySnapshot> 을 담는 리스트
  List<Routine> routineList = new List<Routine>();

  List<dynamic> details = List<dynamic>();

  @override
  void initState() {
    crudObj.getData().then((results) {
      setState(() {
        streamList = results;
      });
    });
//    routineList = crudObj.getData().documents.map((e) => Routine(
//      times: e.data['time'],
//      details: e.data['details'],
//      title: e.data['title'],
//      days: e.data['days'],
//    )).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                  )
                ),
                Divider(
                  height: 5.0, // 위 아래 합친 60
                  color: Colors.grey[850],
                  thickness: 0.5,
                  endIndent: 10.0,
                  indent: 10.0,
                ),
                Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
                Expanded(
//                  child: ListView.builder(
//                    itemCount: routineList.length,
//                    itemBuilder: (context, i) {
//                      return routineItem(
//                        routineList[i].title,
//                        routineList[i].days,
//                        routineList[i].times,
//                        i
//                      );
//                    }
//                  ),
                  child: StreamBuilder(
                    stream: streamList,
                    builder: (context, snapshot) {
                      if (snapshot.data != null) {
                        return ListView.builder(
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, i) { // 2020/06/25 TODO : deails를 빼낼 알고리즘 생각하기 item builder 의 for문 때문에 데이터가 많으 면 시간이 오래걸림... -> 해결함(2020/06/26) -> 못함
                            details.add(snapshot.data.documents[i]['details']);
//                            print(snapshot.data.documents[i]['details'][0]["name"]);
//                            print(snapshot.data.documents[i]['details'].length);
//                            print(snapshot.data.documents[i].data['title'] + " " + details.toString());

                            return routineItem(
                              snapshot.data.documents[i].data['title'],
                              snapshot.data.documents[i].data['days'],
                              snapshot.data.documents[i].data['time'],
                              i
                            );
                          }
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        ); // loading progress
                      }
                    }
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ListView Item
  Widget routineItem(String title, String days, String time, int position) {
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
                  builder: (BuildContext context) {
                    return new DetailRoutine(details: details);
                  }
                ));
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

  // navigation 이벤트
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

  // true, false 반환
  bool getBool(String str) {
    if (str == 'true') {
      return true;
    } else {
      return false;
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


