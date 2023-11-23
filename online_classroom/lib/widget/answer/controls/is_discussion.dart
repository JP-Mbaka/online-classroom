import 'package:flutter/material.dart';

import 'package:online_classroom/constants/dimensions.dart';
import 'package:online_classroom/model/task/question_model.dart';
import 'package:online_classroom/widget/base.dart';


// ignore: must_be_immutable
class IsDiscussion extends StatefulWidget {
  Question? question;
  int questNo;

  IsDiscussion({super.key, this.question, required this.questNo});

  @override
  State<IsDiscussion> createState() => _IsDiscussionState();
}

class _IsDiscussionState extends State<IsDiscussion> {
  final _answerController = TextEditingController();

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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: TextFormField(
            maxLines: 20,
            enableSuggestions: false,
            controller: _answerController,
            decoration: const InputDecoration(
                hintText: "Type your anwser", border: OutlineInputBorder()),
          ),
        ),
      ]),
    );
  }
}
