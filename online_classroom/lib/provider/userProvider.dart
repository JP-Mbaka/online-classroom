import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_classroom/model/user/userModel.dart';

final loginProvider = Provider(
    // final userCredential =
    (ref) => null);

onCreateAccount({
  isLogin = true,
  email,
  pass,
  fname,
  lname,
  othername,
  school,
  schoolId,
  userId,
  userType,
  adminID,
}) async {
  // UserCredential userCredential;
  final _firebase = FirebaseAuth.instance;
  if (isLogin == true) {
    await _firebase.signInWithEmailAndPassword(email: email, password: pass);
  } else {
    await _firebase
        .createUserWithEmailAndPassword(email: email, password: pass)
        .then(
          (value) => onCreateUserInfo(
            uid: value.user!.uid,
            email: email,
            fname: fname,
            lname: lname,
            othername: othername,
            school: school,
            schoolId: schoolId,
            userId: userId,
            userType: userType,
            adminID: adminID,
          ),
        );
  }

  // return userCredential.user!.uid;
}

onCreateUserInfo({
  uid,
  email,
  fname,
  lname,
  othername,
  school,
  schoolId,
  userId,
  userType,
  adminID,
}) async {
  DatabaseReference ref = FirebaseDatabase.instance.ref("users/$uid/");
  if (userType != "Admin") {
    final userInfo = UserModel(
      email: email,
      fName: fname,
      lName: lname,
      otherName: othername,
      school: school,
      schoolId: schoolId,
      userId: userId,
      userType: userType,
      adminID: adminID,
    );
    await ref
        .set(userInfo.toJson())
        .then((value) => print("Submitted successfully"));
  } else {
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
        .set(userInfo.toJson())
        .then((value) => print("Submitted successfully"));
    if (userType == "Admin") {
      DatabaseReference ref =
          FirebaseDatabase.instance.ref("users/schools/$uid/");
      await ref.set({
        "school": school,
        "schoolId": schoolId,
        "admin": uid,
        "term": "",
        "year": ""
      });

      final db = FirebaseFirestore.instance;
      final schoolInfo = <String, String>{
        "school": school,
        "schoolId": schoolId,
        "admin": uid,
        "term": "",
        "year": ""
      };
      await db
          .collection("school")
          .doc(uid)
          .set(schoolInfo)
          .onError((error, stackTrace) => print("$error: Error has occured"));
    }
  }
}
