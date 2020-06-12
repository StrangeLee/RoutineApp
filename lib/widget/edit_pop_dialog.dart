import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class Consts {
  Consts._();

  static const double padding = 16.0;
  static const double avatarRadius = 66.0;
}

class EditDialog extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 0.0,
      child: dialogContent(context),
    );
  }

  dialogContent (BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          card('추가', () {
            // ToDo : add Navigor
          },context),
          SizedBox(
            height: 10.0,
          ),
          card('편집', () {
            Toast.show(
                '편집',
                context,
                duration: Toast.LENGTH_SHORT,
                gravity: Toast.BOTTOM
            );
          }, context),
          SizedBox(
            height: 10.0,
          ),
          card('전체 삭제', () {
            Toast.show(
              '전체 삭제',
              context,
              duration: Toast.LENGTH_SHORT,
              gravity: Toast.BOTTOM
            );
          }, context),
          SizedBox(
            height: 10.0,
          ),
        ],
      ),
    );
  }

  Widget card(String title, Function function, BuildContext context) {
    return InkWell(
      onTap: () {
        function();
        Navigator.of(context).pop();
      },
      child: Container(
        padding: EdgeInsets.only(
          top: Consts.padding,
          bottom: Consts.padding,
          left: Consts.padding + Consts.avatarRadius,
          right: Consts.padding + Consts.avatarRadius,
        ),
//      margin: EdgeInsets.only(top: Consts.avatarRadius),
        decoration: new BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(Consts.padding),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5.0,
              offset: const Offset(0.0, 5.0),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // To make the card compact
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

}
