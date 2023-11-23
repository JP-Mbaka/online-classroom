import 'package:flutter/material.dart';
import 'package:online_classroom/constants/dimensions.dart';
import 'package:online_classroom/model/task/question_model.dart';
import 'package:online_classroom/widget/answer/anwser.dart';
import 'package:online_classroom/widget/base.dart';


// ignore: must_be_immutable
class IsMultichoice extends StatefulWidget {
  Question? question;
  int questNo;

  IsMultichoice({super.key, this.question, required this.questNo});

  @override
  State<IsMultichoice> createState() => _IsMultichoiceState();
}

class _IsMultichoiceState extends State<IsMultichoice> {
  // int questNo = 0;

  @override
  Widget build(BuildContext context) {
    print(widget.questNo);
    return SizedBox(
      width: double.infinity,
      child: Column(children: [
        SizedBox(
          width: double.infinity,
          child: questionCard(context,
              questNo: widget.questNo,
              question: widget.question!.question,
              color: Theme.of(context).colorScheme.onBackground),
        ),
        SizedBox(height: height(context) * 0.02),
        ...widget.question!.answers.map((a) {
          print(ValueKey(a.answerId));
          return AnswerCard(
            key: ValueKey(a.answerId),
            answer: a.answer,
          );
        }).toList(),
      ]),
    );
  }
}
