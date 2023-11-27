import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_classroom/Dashboad/admin_dashboard.dart';
import 'package:online_classroom/Dashboad/other/home.dart';
import 'package:online_classroom/provider/userProvider.dart';

class MainDashboardScreen extends ConsumerStatefulWidget {
  const MainDashboardScreen({super.key});

  @override
  ConsumerState<MainDashboardScreen> createState() =>
      _MainDashboardScreenState();
}

class _MainDashboardScreenState extends ConsumerState<MainDashboardScreen> {
  @override
  void initState() {
    Future(() => loadUser());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userInfo = ref.watch(UserInfoProvider);
    return Scaffold(
      body: SafeArea(
        child: userInfo.userType == "Admin"
            ? AdminDashboardScreen()
            : HomeScreen(selectedIndex: 0),
      ),
    );
  }

  loadUser() {
    final uuid = FirebaseAuth.instance.currentUser!.uid;
    ref.read(UserInfoProvider.notifier).getUser(uuid);
  }
}
