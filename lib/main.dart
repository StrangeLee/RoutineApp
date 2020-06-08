import 'package:flutter/material.dart';
import 'file:///C:/Programing/Flutter/routine_app/lib/page/add_routines.dart';
import 'file:///C:/Programing/Flutter/routine_app/lib/page/edit_detail_routine.dart';
import 'file:///C:/Programing/Flutter/routine_app/lib/page/show_detail_routines.dart';
import 'file:///C:/Programing/Flutter/routine_app/lib/page/show_routines.dart';
import 'file:///C:/Programing/Flutter/routine_app/lib/page/startRoutine.dart';
import 'page/splash.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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
