import 'package:flutter/material.dart';

class MyPopUp extends StatelessWidget {
  static showMyDialog(context, {mWidget}) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.transparent,
        content: mWidget,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return showMyDialog(context);
  }
}
