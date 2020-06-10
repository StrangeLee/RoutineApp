import 'package:flutter/material.dart';
import 'file:///C:/Programing/Flutter/routine_app/lib/page/add_routines.dart';
import 'file:///C:/Programing/Flutter/routine_app/lib/page/edit_detail_routine.dart';
import 'file:///C:/Programing/Flutter/routine_app/lib/page/show_detail_routines.dart';
import 'file:///C:/Programing/Flutter/routine_app/lib/page/show_routines.dart';
import 'file:///C:/Programing/Flutter/routine_app/lib/page/startRoutine.dart';
import 'page/splash.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  static const Color colorPlum = const Color(0xFFC004D9); // flutter 에서 color 코드를 쓸려면 0xFf + color code 를 인자로 줘야한다.
  static const Color colorDeepBlue = const Color(0xff5A13F2);
  static const Color colorPurple = const Color(0xffAB05F2);
  static const Color colorBlue = const Color(0xff2745F2);
  static const Color colorLightBlue = const Color(0xff1B78F2);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '(MR)Make your Routine',
      home: SplashScreen(),
      routes: <String, WidgetBuilder>{
        '/main' : (BuildContext context) => ShowRoutines(),
        '/add' : (BuildContext context) => AddPage(),
        '/detail_list' : (BuildContext context) => DetailRoutine(),
        '/edit' : (BuildContext context) => EditDetailRoutine(),
        '/start' : (BuildContext context) => StartRoutine(),
      },
    );
  }
}
