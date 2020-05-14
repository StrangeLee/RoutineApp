import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class StartRoutine extends StatefulWidget {

  final String title;
  final int timeOut;

  const StartRoutine({
    Key key,
    this.title,
    this.timeOut
  }) : super(key: key);

  @override
  _StartRoutineState createState() => _StartRoutineState(title, timeOut);
}

class _StartRoutineState extends State<StartRoutine> {

  String title;
  int timeOut;

  _StartRoutineState(this.title, this.timeOut);

  Icon playIcon = Icon(
      Icons.play_circle_outline
  );
  bool isPlay = false; // 정지 시작 확인 변수
  String showTime; // 남은 시간

  Timer _timer;

  @override
  void initState() {
    super.initState();
    timeOut *= 60;
    if (timeOut >= 60) {
       showTime = (timeOut / 60).toString() + ' : ' + (timeOut % 60).toString();
    } else {
      showTime = timeOut.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
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
                        fontSize: 20.0
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isPlay = !isPlay;
                        if (isPlay) { // 멈추기, true 동작 중일때 누르는거 즉 icon 을 Play로
                          playIcon = Icon(
                              Icons.stop
                          );
                          startTimer();
                        } else { // 시작하기
                          playIcon = Icon(
                              Icons.play_circle_outline
                          );
                          startTimer();
                        }
                      });
                    },
                    icon: playIcon,
                  )
                ],
              )
            ],
          )
      ),
    );
  }

    void startTimer() async {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      setState(() {
        if (timeOut < 1) {
          timer.cancel();
          // Todo : Timer 가 0일때 메서드 추가
        } else if (!isPlay) {
          timer.cancel();
        } else {
          timeOut -= 1;
        }

        if (timeOut >= 60) {
          showTime = (timeOut / 60).floor().toString() + ' : ' + (timeOut % 60).toString();
        } else {
          showTime = timeOut.toString();
        }
      });
    });
  }

}
