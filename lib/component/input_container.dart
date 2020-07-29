import 'package:easy_blood/constant.dart';
import 'package:flutter/material.dart';
class InputContainer extends StatelessWidget {
  final Widget child;
  const InputContainer({
    Key key,
    this.child,
}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 60.0,
      margin: EdgeInsets.symmetric(vertical: 15),
      padding: EdgeInsets.symmetric(vertical: 9,horizontal: 20),
      width: size.width*0.8,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 7,
            spreadRadius: 4,
          )
        ]
      ),
      child: child,
    );
  }
}