import 'package:flutter/material.dart';

Widget test(msg, {big}) {
  return Center(
    child: Text(
      msg,
      style: big,
    ),
  );
}
