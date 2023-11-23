import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:online_classroom/constants/image_refs.dart';
import 'package:online_classroom/constants/text.dart';

Widget test(data) => Center(child: Text(data));

Widget singleTask({title}) => Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(children: [
          SvgPicture.asset(
            taskIcon,
            height: 45,
          ),
          const SizedBox(width: 8.0),
          Text(title),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios)
        ]),
      ),
    );

Widget questionCard(context, {questNo, question, color, textColor}) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: RichText(
            text: TextSpan(
                style: mediumBodyStyle(
                  weight: FontWeight.w600,
                  color: textColor ?? Theme.of(context).colorScheme.background,
                ),
                children: [
                  TextSpan(text: 'Q$questNo: '),
                  TextSpan(text: '$question?'),
                ]),
          ),
        ),
      ),
    );

Widget answer(iconColor, color, answer, {isMulti = false}) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              if (!isMulti)
                CircleAvatar(
                  radius: 5.5,
                  backgroundColor: iconColor == null ? Colors.amber : null,
                  child: CircleAvatar(
                    radius: 5,
                    backgroundColor: iconColor ?? Colors.white,
                  ),
                ),
              if (isMulti)
                Container(
                  width: 15,
                  height: 15,
                  padding: const EdgeInsets.all(2.0),
                  color: iconColor == null ? Colors.amber : null,
                  child: Container(
                    width: 10,
                    height: 10,
                    color: iconColor ?? Colors.white,
                  ),
                ),
              const SizedBox(width: 8),
              Text(answer),
            ],
          ),
        ),
      ),
    );

Widget navIcon(context, {icon, iconData, title, isIcon = false}) => Column(
      children: [
        const SizedBox(height: 2),
        isIcon
            ? Icon(
                iconData,
                size: 35,
                color: Theme.of(context).colorScheme.onSecondaryContainer,
              )
            : SvgPicture.asset(
                icon,
                height: 35,
                width: 35,
                color: Theme.of(context).colorScheme.onSecondaryContainer,
              ),
        const SizedBox(height: 2),
        FittedBox(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 10,
              color: Theme.of(context).colorScheme.secondaryContainer,
            ),
          ),
        ),
      ],
    );
