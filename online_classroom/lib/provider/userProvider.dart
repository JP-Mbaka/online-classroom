import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_classroom/model/user/userModel.dart';

final loginProvider = Provider(
    // final userCredential =
    (ref) => null);

onCreateAccount({email, pass, isLogin = true}) async {
  final _firebase = FirebaseAuth.instance;
  if (isLogin == true) {
    final userCredential = await _firebase.signInWithEmailAndPassword(
        email: email, password: pass);
  } else {
    final userCredential = await _firebase.createUserWithEmailAndPassword(
        email: email, password: pass);
  }
}

onCreateUserInfo(
    {email,
    fname,
    lname,
    othername,
    school,
    schoolId,
    userId,
    userType}) async {
  DatabaseReference ref = FirebaseDatabase.instance.ref("users");
  final userInfo = UserModel(
      email: email,
      fName: fname,
      lName: lname,
      otherName: othername,
      school: school,
      schoolId: schoolId,
      userId: userId,
      userType: userType);
  await ref
      .set(userInfo.toJson().toString())
      .then((value) => print("Submitted successfully"));
}
