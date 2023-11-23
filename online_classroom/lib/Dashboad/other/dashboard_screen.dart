import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_classroom/widget/base.dart';
import 'package:online_classroom/widget/displayTask.dart';

// ignore: must_be_immutable
class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String? teacher;
    // List<SubjectsModel> lessons = [];
    List lessons = [];
    // final mySubject = ref.watch(mySubjectProvider);
    List mySubject = [];
    // final allSubject = ref.watch(subjectListProvider);
    List allSubject = [];

    for (var items in mySubject) {
      for (var t in allSubject) {
        if (items.coursId == t.subjectCode) {
          lessons.add(t);
        }
      }
    }
    // final teachers = ref.watch(teachersProvider);
    List teachers = [];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
        ),
        title: const Text('Classroom'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: SafeArea(
          child: Column(
        children: [
          if (lessons.isNotEmpty)
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 8)
                      .copyWith(bottom: 4),
                  itemCount: lessons.length,
                  itemBuilder: ((context, index) {
                    if (lessons.isEmpty) {
                      return test('No lessons available');
                    }
                    for (var t in teachers) {
                      if (lessons[index].userId == t.userId) {
                        teacher = '${t.fName} ${t.lName}';
                      }
                    }
                    return DisplayTask(
                        lesson: lessons[index],
                        author: teacher,
                        isLesson: true,
                        onNewScreen: () {
                          // Navigator.of(context).push(
                          // MaterialPageRoute(
                          //   builder: (_) => GroupLesson(
                          //     courseId: lessons[index].subjectCode,
                          //     subject: lessons[index].subjectTitle,
                          //     date: lessons[index].year,
                          //     courseCode: lessons[index].subjectCode,
                          //   ),
                          // ),
                          // );
                        });
                  })),
            ),
        ],
      )),
    );
  }
}
