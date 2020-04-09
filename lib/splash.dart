import 'dart:async';
import 'package:flutter/material.dart';
import 'package:routineapp/show_routines.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.limeAccent,
      body: Center(
        child: Text(
          'Make Your Routine',
          style: TextStyle(
            fontSize: 50.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => ShowRoutines()
      ));
    });
  }
}
