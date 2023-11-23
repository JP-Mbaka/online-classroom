import 'package:flutter/material.dart';

import 'package:online_classroom/constants/dimensions.dart';
import 'package:online_classroom/model/subject/subject_model.dart';
import 'package:online_classroom/model/task/task_mode.dart';

// ignore: must_be_immutable
class DisplayTask extends StatelessWidget {
  DisplayTask(
      {super.key,
      this.lesson,
      this.author,
      this.onNewScreen,
      this.task,
      this.isLesson = false});

  SubjectModel? lesson;
  String? author;
  TaskModel? task;

  void Function()? onNewScreen;
  bool isLesson;

  @override
  Widget build(BuildContext context) {
    Expanded content;
    if (isLesson == true) {
      content = Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(lesson!.subjectTitle),
            Row(
              children: [
                Text(lesson!.level),
                const SizedBox(width: 8),
                Text(lesson!.department),
                const Spacer(),
              ],
            ),
            const Spacer(),
            Text(author ?? ""),
          ],
        ),
      );
    } else {
      content = Expanded(
          child: Center(
        child: Text('Testing'),
      ));
    }
    // } else {
    //   content = Expanded(
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Text(task!.taskTitle ?? 'Task Title Here'),
    //         SizedBox(height: height(context) * 0.02),
    //         Expanded(
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Text(task!.createdAt == null
    //                   ? ''
    //                   : "created: ${task!.formatCreatedDate}"),
    //               const SizedBox(width: 8),
    //               Text(task!.deadlineAt == null
    //                   ? ''
    //                   : "Deadline: ${task!.formatDeadlineDate}"),
    //               const SizedBox(width: 8),
    //               Text(task!.formatExtendedDate == null
    //                   ? ''
    //                   : "Extended: ${task!.formatExtendedDate}"),
    //               const Spacer(),
    //             ],
    //           ),
    //         ),
    //         Text(task!.userId ?? 'Author name here'),
    //       ],
    //     ),
    //   );
    // }
    return InkWell(
      onTap: onNewScreen,
      child: Card(
        margin: const EdgeInsets.only(top: 8),
        elevation: 5,
        child: Container(
          height: height(context) * 0.2,
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [content],
          ),
        ),
      ),
    );
  }
}
