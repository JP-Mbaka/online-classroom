import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:online_classroom/constants/dimensions.dart';
import 'package:online_classroom/model/subject/subject_model.dart';
import 'package:online_classroom/model/task/task_mode.dart';
import 'package:online_classroom/model/user/userModel.dart';
import 'package:online_classroom/provider/subject/subject_provider.dart';

// ignore: must_be_immutable
class DisplayTask extends ConsumerWidget {
  DisplayTask(
      {super.key,
      this.mySubject,
      this.author,
      this.onNewScreen,
      this.task,
      this.isLesson = false});

  SubjectModel? mySubject;
  UserModel? author;
  TaskModel? task;

  void Function()? onNewScreen;
  bool isLesson;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final mySubject = ref.watch(subjectProvider);

    Expanded content;
    if (isLesson == true) {
      content = Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(mySubject!.subjectTitle),
            Row(
              children: [
                Text(mySubject!.level),
                const SizedBox(width: 8),
                Text(mySubject!.department),
                const Spacer(),
              ],
            ),
            const Spacer(),
            Text("${author?.lName} ${author?.fName}"),
          ],
        ),
      );
    } else {
      content = const Expanded(
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
