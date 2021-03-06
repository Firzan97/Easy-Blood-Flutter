import 'package:easy_blood/constant/constant.dart';
import 'package:flutter/material.dart';

class ButtonRound extends StatelessWidget {
  final String text;
  final Function press;
  final Color color,textColor;
  const ButtonRound({
    Key key,
    this.text,
    this.press,
    this.color,
    this.textColor=Colors.white,
}) : super(key: key) ;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      width: size.width * 0.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(29),
color: kPrimaryColor,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29.0),
        child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 2.0),
          onPressed: press,
          child: Text(text,
            style: TextStyle(color: textColor,
            fontFamily: "Muli",
            fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}
