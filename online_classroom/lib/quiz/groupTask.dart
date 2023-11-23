import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_classroom/quiz/single_quiz.dart';
import 'package:online_classroom/widget/base.dart';

class AllTask extends ConsumerStatefulWidget {
  const AllTask({super.key});

  @override
  ConsumerState<AllTask> createState() => _AllTaskState();
}

class _AllTaskState extends ConsumerState<AllTask> {
  @override
  void initState() {
    // Future(() {
    //   loadTasks();
    // });

    super.initState();
  }

  // loadTasks() {
  //   for (var i in task) {
  //     ref.read(taskProvider.notifier).loadTask(TaskModel.fromJson(i));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // final allTasks = ref.watch(taskProvider);
    List allTasks = [];

    return Column(
      children: allTasks.map(
        (e) {
          if (e.showNow != true) {
            return Container();
          }
          return InkWell(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => QuizScreen(task: e)));
            },
            child: singleTask(title: e.taskTitle),
          );
        },
      ).toList(),
    );
  }
}
