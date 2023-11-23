import 'package:flutter/material.dart';
import 'package:online_classroom/Dashboad/other/dashboard_screen.dart';

import 'package:online_classroom/constants/dimensions.dart';
import 'package:online_classroom/constants/image_refs.dart';
import 'package:online_classroom/grades/grades.dart';
import 'package:online_classroom/profile/profile.dart';
import 'package:online_classroom/quiz/quiz.dart';
import 'package:online_classroom/widget/base.dart';


// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  HomeScreen({super.key, required this.selectedIndex});
  int selectedIndex = 0;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isTeacher = false;

  @override
  Widget build(BuildContext context) {
    // final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    List<Widget> screens = [
      DashboardScreen(),
      // ClassRoomScreen(),
      TaskScreen(),
      const GradesScreen(),
      // isTeacher ? const StudentsProfileScreen() : 
      const ProfileScreen(),
    ];
    List<Widget> screensIcon = [
      navIcon(context, icon: homeIcon, title: 'Home'),
      navIcon(context, icon: taskIcon, title: 'Task'),
      navIcon(context, icon: gradesIcon, title: 'Grades'),
      navIcon(
        context,
        iconData: Icons.person_outline_sharp,
        title: isTeacher ? 'Students' : 'Profile',
        isIcon: true,
      ),
    ];

    return Scaffold(
      body: IndexedStack(
        index: widget.selectedIndex,
        children: screens,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Material(
          elevation: 10,
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).colorScheme.primary,
          child: SizedBox(
            height: height(context) * 0.08,
            width: double.infinity,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: screens.length,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              itemBuilder: (ctx, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  // .copyWith(left: 2),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.selectedIndex = index;
                      });
                    },
                    child: AnimatedContainer(
                      width: 45,
                      duration: const Duration(milliseconds: ROUTE_DURATION),
                      decoration: BoxDecoration(
                        border: widget.selectedIndex == index
                            ? Border(
                                top: BorderSide(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer,
                                  width: 5.0,
                                ),
                              )
                            : null,
                        gradient: widget.selectedIndex == index
                            ? LinearGradient(
                                colors: [
                                  Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer
                                      .withOpacity(0.5),
                                  Theme.of(context).colorScheme.primary
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              )
                            : null,
                      ),
                      child: screensIcon[index],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
