import 'package:flutter/material.dart';
import 'package:routineapp/main.dart';

class DayButton extends StatefulWidget {
  final String day;
  DayButton({Key key, @required this.day}) : super(key : key);

  @override
  _DayButtonState createState() => _DayButtonState(day);
}

class _DayButtonState extends State<DayButton> {
  bool clicked = true; // if false : not clicked, true : clicked
  String day;

  _DayButtonState(this.day);

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
            clicked = !clicked;
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
              color: clicked ? MyApp.colorLightBlue : Colors.white,
              border: Border.all(
                color: MyApp.colorLightBlue,
                width: 2.0,
              )
          ),
          child: Text(
            day,
            style: TextStyle(
                fontFamily: 'malgunBold',
                color: clicked ? Colors.white : Colors.black,
                fontSize: 16.0
            ),
          ),
        ),
      ),
    );
  }
}


