import 'package:flutter/material.dart';
import 'package:routineapp/splash.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '(MR)Make your Routine',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: SplashScreen()
    );
  }
}
