import 'package:flutter/material.dart';
import 'package:online_classroom/Dashboad/admin_dashboard.dart';
import 'package:online_classroom/Dashboad/other/home.dart';

class MainDashboardScreen extends StatelessWidget {
  const MainDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: HomeScreen(selectedIndex: 0),
        //AdminDashboardScreen(),
      ),
    );
  }
}
