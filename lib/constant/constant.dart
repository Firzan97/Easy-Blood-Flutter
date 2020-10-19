import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xffd72323);
const kSecondaryColor = Color(0xFFa80038);
const kThirdColor = Color(0XFF343a69);
const kFourthColor = Color(0xFFff304f);
const kGradient1 = Color(0xffff867f);
const kGradient2 = Color(0xffd72323);

const kAnimationDuration = Duration(milliseconds: 200);

const colorgradient = LinearGradient(
begin: Alignment.topRight,
end: Alignment.bottomLeft,
colors: [kGradient1, kGradient2]);

const colorgradient2 = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [kGradient2, kGradient1]);

const apiURL="http://192.168.49.122:8000/api/";

const double padding = 16.0;
const double avatarRadius = 66.0;

