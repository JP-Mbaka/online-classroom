import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:online_classroom/constants/dimensions.dart';
import 'package:online_classroom/constants/text.dart';
import 'package:online_classroom/quiz/groupTask.dart';
import 'package:online_classroom/quiz/single_quiz.dart';
import 'package:online_classroom/widget/base.dart';

// ignore: must_be_immutable
class TaskScreen extends ConsumerWidget {
  TaskScreen({super.key, this.courseId, this.subject});

  String? courseId;
  String? subject;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //Delete me ooooooooooooooo 
    var taskProvider;
    final subjectTask =
        ref.read(taskProvider.notifier).displayOnlySubject(courseId);
    return (courseId == '' || courseId == null)
        ? SafeArea(
            child: Column(
            children: [
              SizedBox(height: height(context) * 0.02),
              Text(
                'All Quiz',
                style: headerStyle(),
              ),
              SizedBox(height: height(context) * 0.02),
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SingleChildScrollView(child: AllTask()),
                ),
              )
            ],
          ))
        : Scaffold(
            body: SafeArea(
                child: Column(
              children: [
                SizedBox(height: height(context) * 0.02),
                Text(
                  '$subject Quiz',
                  style: headerStyle(),
                ),
                SizedBox(height: height(context) * 0.02),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: subjectTask.map(
                          (e) {
                            if (e.showNow != true) {
                              return Container();
                            }
                            return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => QuizScreen(task: e)));
                                },
                                child: singleTask(title: e.taskTitle));
                          },
                        ).toList(),
                      ),
                    ),
                  ),
                )
              ],
            )),
          );
  }
}
