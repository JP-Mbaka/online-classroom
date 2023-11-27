import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_classroom/model/user/userModel.dart';

class UserInfoNotifier extends StateNotifier<UserModel> {
  UserInfoNotifier()
      : super(UserModel(
          email: "",
          fName: "",
          lName: "",
          otherName: "",
          school: "",
          schoolId: "",
          userId: "",
          userType: "",
        ));

  getUser(uid) {
    DatabaseReference starCountRef =
        FirebaseDatabase.instance.ref('users/$uid');
    starCountRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      // updateStarCount(data);
      // print(data);
      final ar = userModelFromJson(json.encode(data).toString());
      // print(ar.email);
      // print(ar.fName);
      // print(ar.lName);

      state = ar;
    });
    // return state;
  }
}

final UserInfoProvider = StateNotifierProvider<UserInfoNotifier, UserModel>(
    (ref) => UserInfoNotifier());
