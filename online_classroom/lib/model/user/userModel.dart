import 'dart:convert';

import 'package:flutter/material.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));


enum UserType { student, teacher, admin }

class UserModel {
  String email;
  String fName;
  String lName;
  String otherName;
  String school;
  String schoolId;
  String userId;
  String userType;
  String? adminID;

  UserModel({
    required this.email,
    required this.fName,
    required this.lName,
    required this.otherName,
    required this.school,
    required this.schoolId,
    required this.userId,
    required this.userType,
    this.adminID,
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
        adminID: json["adminID"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "fName": fName,
        "lName": lName,
        "otherName": otherName,
        "school": school,
        "schoolId": schoolId,
        "userId": userId,
        "userType": userType,
        "adminID": adminID,
      };
}
