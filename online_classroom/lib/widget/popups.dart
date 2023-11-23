import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:online_classroom/constants/dimensions.dart';
import 'package:online_classroom/constants/image_refs.dart';
import 'package:online_classroom/constants/text.dart';

class PopDialogs extends StatefulWidget {
  PopDialogs({
    super.key,
    required this.title,
    required this.message,
    required this.onPressYes,
  });
  final String title;
  final String message;
  final void Function() onPressYes;

  @override
  State<PopDialogs> createState() => _PopDialogsState();

  static alertMessage({required context, icon, message, goback = false}) {
    showDialog(
        context: context,
        builder: (context) => _alertMessage(
              context: context,
              icon: icon,
              message: message,
              goback: goback,
            ));
  }

  static Widget _alertMessage({context, icon, message, goback}) {
    return AlertDialog(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: (icon != null)
          ? CircleAvatar(
              radius: height(context) * 0.06,
              backgroundColor: Colors.redAccent.withOpacity(0.2),
              child: SvgPicture.asset(
                icon,
                height: height(context) * 0.08,
              ),
            )
          : CircleAvatar(
              radius: height(context) * 0.06,
              backgroundColor: Colors.greenAccent.withOpacity(0.2),
              child: SvgPicture.asset(
                successIcon,
                height: height(context) * 0.08,
              ),
            ),
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: mediumBodyStyle(),
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: [
        Container(
          padding: const EdgeInsets.all(8.0),
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text('Close'),
          ),
        ),
        // primaryButton(
        //   text: 'Close',
        //   hPadding: width(context) * 0.15,
        //   onClick: () {
        //     // Get.back();
        //     // Get.back();
        //     // if (goback) {
        //     //   Get.back();
        //     // }
        //   },
        // ),
        SizedBox(height: height(context) * 0.05),
      ],
    );
  }

  static popDialogs({
    required context,
    title,
    message,
    onPressYes,
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => PopDialogs(
        title: title,
        message: message,
        onPressYes: onPressYes,
      ),
    );
  }
}

class _PopDialogsState extends State<PopDialogs> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: Text(
        widget.title,
        textAlign: TextAlign.center,
        style: mediumBodyStyle(
          weight: FontWeight.bold,
          fontSize: 16.0,
        ),
      ),
      content: Text(
        widget.message,
        textAlign: TextAlign.center,
        style: mediumBodyStyle(color: Colors.grey.withOpacity(0.6)),
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: [
        TextButton(
            onPressed: widget.onPressYes,
            child: Text(
              'YES',
              style: mediumBodyStyle(
                color: Colors.red,
                weight: FontWeight.w500,
              ),
            )),
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'No, cancel',
              style: mediumBodyStyle(weight: FontWeight.w500),
            )),
        SizedBox(height: height(context) * 0.05),
      ],
    );
  }
}
