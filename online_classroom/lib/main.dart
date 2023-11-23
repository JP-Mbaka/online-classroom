import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_classroom/Dashboad/main_dashboard.dart';
import 'package:online_classroom/auth/logging.dart';
import 'package:online_classroom/firebase_options.dart';
import 'package:online_classroom/widget/test.dart';

var kColorScheme = ColorScheme.fromSeed(seedColor: const Color(0x001D2647));
var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color(0x00BEC7FF),
);
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
  // runApp(MaterialApp(
  //   home: MainDashboardScreen(),
  // ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Online Classroom',
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkColorScheme,
        // useMaterial3: true,
      ),
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        // useMaterial3: true,
      ),
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(
                  body: test(
                "Online Classroom",
                big: Theme.of(context).textTheme.headlineLarge,
              ));
            }
            if (snapshot.hasData) {
              return MainDashboardScreen();
            }
            return LoginScreen();
          }),
    );
  }
}
