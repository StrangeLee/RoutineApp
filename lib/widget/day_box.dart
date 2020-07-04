import 'package:flutter/material.dart';
import 'package:routineapp/main.dart';

// ignore: must_be_immutable
class DayButton extends StatefulWidget {
  String day;
  bool clicked;
  DayButton({@required this.day, @required this.clicked});

  @override
  _DayButtonState createState() => _DayButtonState(day, clicked);

  bool getClicked() {
    return this.clicked;
  }
}

class _DayButtonState extends State<DayButton> {
  bool clicked; // if false : not clicked, true : clicked
  String day;

  _DayButtonState(this.day, this.clicked);

  @override
  Widget build(BuildContext context) {
    return dayBox(day);
  }

  Widget dayBox(String day) {
    return Padding(
      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
      child: InkWell(
        onTap: () {
          setState(() {
            widget.clicked = !widget.clicked;
            debugPrint('$day is $clicked');
            print(day);
          });
        },
        child: Container(
          width: 50,
          height: 50,
          padding: EdgeInsets.all(10.0),
          alignment: Alignment.center,
          decoration: new BoxDecoration(
              shape: BoxShape.circle,
              color: widget.clicked ? MyApp.colorLightBlue : Colors.white,
              border: Border.all(
                color: MyApp.colorLightBlue,
                width: 2.0,
              )
          ),
          child: Text(
            day,
            style: TextStyle(
                fontFamily: 'malgunBold',
                color: widget.clicked ? Colors.white : Colors.black,
                fontSize: 16.0
            ),
          ),
        ),
      ),
    );
  }
}


