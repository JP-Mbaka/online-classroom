import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_classroom/auth/logging.dart';
import 'package:online_classroom/constants/dimensions.dart';
import 'package:online_classroom/provider/subject/subject_provider.dart';
import 'package:online_classroom/provider/userProvider.dart';
import 'package:online_classroom/screens/lesson/create_lesson.dart';
import 'package:online_classroom/screens/lesson/create_subject.dart';
import 'package:online_classroom/widget/base.dart';
import 'package:online_classroom/widget/displayTask.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
//Dropdown controlls
  dynamic createRes = 0;

  List<DropdownMenuItem> resourceList = [
    const DropdownMenuItem(value: 0, 
      child: Text("Select"),),
    const DropdownMenuItem(
      value: "Subject",
      child: Text("Create Subject"),
    ),
    const DropdownMenuItem(
      value: "Lesson",
      child: Text("Create Lesson"),
    ),
    const DropdownMenuItem(
      value: "Task",
      child: Text("Create Task"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final userInfo = ref.watch(UserInfoProvider);

    ref.read(subjectProvider.notifier).loadAllMySubjects(userInfo);

    //perfect
    String? teacher;
    // List<SubjectsModel> lessons = [];
    List lessons = [];
    final mySubject = ref.watch(subjectProvider);
    // List mySubject = [];
    // final allSubject = ref.watch(subjectListProvider);
    List allSubject = [];

    for (var items in mySubject) {
      for (var t in allSubject) {
        if (items.subjectCode == t.subjectCode) {
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
          // if (userInfo.userType == "Teacher")
            SizedBox(
              width: width(context) * 0.3,
              child: DropdownButtonFormField(
                value: createRes,
                items: resourceList,
                isExpanded: true,
                decoration: const InputDecoration(
                  icon: Icon(Icons.add),
                  isCollapsed: true,
                  disabledBorder: InputBorder.none,
                ),
                onChanged: (val) {
                  setState(() {
                    createRes = val;
                    if (val == "Subject") {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => CreateSubjectScreen()));
                    } else if (val == "Lesson") {
                      //Load the subject first then push the subject
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => CreateLessonScreen()));
                    } else {}
                  });
                },
              ),
            ),
          // IconButton(
          //   onPressed: () {
          //     if (userInfo.userType == "teacher") {
          //       //Lets have a drop down here
          //
          //     }
          //   },
          //   icon: userInfo.userType == "Student" && userInfo.userType != "Admin"
          //       ? const Icon(Icons.notifications)
          //       : const Icon(Icons.add),
          // ),
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => LoginScreen()));
            },
            icon: const Icon(Icons.logout),
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
