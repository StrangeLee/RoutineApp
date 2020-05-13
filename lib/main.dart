import 'package:flutter/material.dart';
import 'package:routineapp/add_routines.dart';
import 'package:routineapp/edit_detail_routine.dart';
import 'package:routineapp/show_detail_routines.dart';
import 'package:routineapp/show_routines.dart';
import 'package:routineapp/splash.dart';

void main() => runApp(MyApp());

final routes = {
  '/' : (BuildContext context) => SplashScreen(),
  '/main' : (BuildContext context) => ShowRoutines(),
  '/add' : (BuildContext context) => AddPage(),
  '/detail_list' : (BuildContext context) => DetailRoutine(),
  '/edit' : (BuildContext context) => EditDetailRoutine(),
};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '(MR)Make your Routine',
      home: SplashScreen()
    );
  }
}
