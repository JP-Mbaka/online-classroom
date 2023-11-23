import 'package:flutter/material.dart';

TextStyle headerStyle({color, fontSize}) {
  return TextStyle(
      color: color ?? Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: fontSize ?? 25);
}

TextStyle subHeaderStyle({color}) {
  return TextStyle(
      color: color ?? Colors.black, fontWeight: FontWeight.bold, fontSize: 16);
}

TextStyle mediumBodyStyle({color, weight, fontSize}) {
  return TextStyle(
      color: color ?? Colors.black,
      fontWeight: weight ?? FontWeight.w200,
      fontSize: fontSize ?? 14);
}

TextStyle smallBodyStyle({color, weight}) {
  return TextStyle(
      color: color ?? Colors.black,
      fontWeight: weight ?? FontWeight.w200,
      fontSize: 12);
}

TextStyle bodyStyle({color}) {
  return TextStyle(color: color ?? Colors.black);
}

TextStyle underlineBodyStyle({color, weight}) {
  return TextStyle(
      color: color ?? Colors.black,
      decoration: TextDecoration.underline,
      fontWeight: weight);
}

TextStyle buttonTextStyle({color}) {
  return TextStyle(
      height: 1.3, color: color ?? Colors.black, fontWeight: FontWeight.w700);
}

TextStyle underlineButtonTextStyle({color}) {
  return TextStyle(
      height: 1.3,
      color: color ?? Colors.amberAccent,
      fontWeight: FontWeight.w700,
      decoration: TextDecoration.underline,
      fontSize: 16);
}
