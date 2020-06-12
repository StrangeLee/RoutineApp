import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:routineapp/main.dart';

class StartRoutine extends StatefulWidget {

  final String title;
  final int timeOut;

  StartRoutine({
    @required this.title,
    @required this.timeOut
  });

  @override
  _StartRoutineState createState() => _StartRoutineState(title, timeOut);
}

class _StartRoutineState extends State<StartRoutine> {

  String title;
  int timeOut;

  _StartRoutineState(this.title, this.timeOut);

  Icon playIcon = Icon(
    Icons.play_circle_outline,
    size: 25.0,
  );
  bool isPlay = false; // 정지 시작 확인 변수
  String showTime; // 남은 시간

  Timer _timer;

  @override
  void initState() {
    super.initState();
    print('time = $timeOut');
    timeOut *= 60;
    if (timeOut >= 60) {
       showTime = (timeOut / 60).floor().toString() + ' : ' + (timeOut % 60).toString();
    } else {
      showTime = timeOut.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyApp.colorPurple,
      appBar: AppBar(
        backgroundColor: MyApp.colorPurple,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [MyApp.colorPurple, MyApp.colorPlum, MyApp.colorDeepBlue]
          )
        ),
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.book,
                  size: 250.0,
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'malgunBold',
                    fontSize: 30.0,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      showTime,
                      style: TextStyle(
                          fontSize: 30.0
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if (mounted) {
                          setState(() {
                            isPlay = !isPlay;
                            if (isPlay) { // 멈추기, true 동작 중일때 누르는거 즉 icon 을 Play로
                              playIcon = Icon(
                                Icons.stop,
                                size: 25.0,
                              );
                              startTimer();
                            } else { // 시작하기
                              playIcon = Icon(
                                Icons.play_circle_outline,
                                size: 25.0,
                              );
                              startTimer();
                            }
                          });
                        }
                      },
                      icon: playIcon,
                    ),
                  ],
                )
              ],
            )
        ),
      )
    );
  }

    void startTimer() async {
    const oneSec = Duration(seconds: 1);
    if (isPlay) {
      _timer = Timer.periodic(oneSec, (timer) {
        if (mounted) {
          setState(() {
            if (timeOut < 1) {
              timer.cancel();
              // Todo : Timer 가 0일때 메서드 추가
            } else {
              timeOut -= 1;
            }

            if (timeOut >= 60) {
              showTime = (timeOut / 60).floor().toString() + ' : ' + (timeOut % 60).toString();
            } else {
              showTime = timeOut.toString();
            }
          });
        }
      });
    } else {
      _timer.cancel();
    }
  }

}
