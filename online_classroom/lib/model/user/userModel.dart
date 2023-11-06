import 'dart:convert';

import 'package:flutter/material.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

enum UserType { student, teacher, admin }

class UserModel with ChangeNotifier {
  String email;
  String fName;
  String lName;
  String otherName;
  String school;
  String schoolId;
  String userId;
  UserType userType;

  UserModel({
    required this.email,
    required this.fName,
    required this.lName,
    required this.otherName,
    required this.school,
    required this.schoolId,
    required this.userId,
    required this.userType,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json["email"],
        fName: json["fName"],
        lName: json["lName"],
        otherName: json["otherName"],
        school: json["school"],
        schoolId: json["schoolId"],
        userId: json["userId"],
        userType: json["userType"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "fName": email,
        "lName": email,
        "otherName": email,
        "school": email,
        "schoolId": email,
        "userId": email,
        "userType": email,
      };
}
