import 'package:flutter/material.dart';

import 'package:online_classroom/constants/dimensions.dart';
import 'package:online_classroom/constants/image_refs.dart';
import 'package:online_classroom/model/task/task_mode.dart';
import 'package:online_classroom/widget/answer/controls/is_discussion.dart';
import 'package:online_classroom/widget/answer/controls/is_true_false.dart';
import 'package:online_classroom/widget/answer/controls/is_upload.dart';
import 'package:online_classroom/widget/answer/controls/multichoice.dart';
import 'package:online_classroom/widget/popups.dart';

// ignore: must_be_immutable
class QuizScreen extends StatefulWidget {
  QuizScreen({super.key, required this.task});

  TaskModel? task;

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final _formKey = GlobalKey<FormState>();

  int questNo = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Row(
              children: [
                IconButton.filled(
                  onPressed: () {
                    PopDialogs.popDialogs(
                        context: context,
                        title: 'Exit',
                        message: 'Do you want to exit?',
                        onPressYes: () {
                          PopDialogs.alertMessage(
                            context: context,
                            icon: errorDeleteIcon,
                            message: 'You will automatically fail the test',
                          );
                          // Navigator.of(context).pop();
                        });
                  },
                  icon: const Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Icon(Icons.arrow_back_ios),
                  ),
                ),
                SizedBox(width: width(context) * 0.05),
                Text(widget.task!.taskTitle ?? ""),
                const Spacer(),
                const CircularProgressIndicator(), //Here we implement countdown with time
                // IconButton(onPressed: (){}, icon: const Icon(icon))
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: getQuestions(context) ?? Container(),
                  )
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Submit'),
            ),
          ),
        ],
      )),
    );
  }

  Widget? getQuestions(context) {
    if (widget.task == null || widget.task!.questions.isEmpty) {
      return Container();
    } else {
      return Column(
        children: widget.task!.questions.map((q) {
          setState(() {
            questNo += 1;
          });
          print(questNo);

          if (q.isTrueFalse) {
            return IsTrueFalse(
              questNo: questNo,
              question: q,
            );
          } else if (q.isDiscussion) {
            return IsDiscussion(
              questNo: questNo,
              question: q,
            );
          } else if (q.isUpload) {
            return IsUpload(
              questNo: questNo,
              question: q,
            );
          } else {
            return IsMultichoice(
              questNo: questNo,
              question: q,
            );
          }
        }).toList(),
      );
    }
  }
}
