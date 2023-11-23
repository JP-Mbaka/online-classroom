import 'dart:convert';

SchoolInfo schoolInfoFromJson(String str) =>
    SchoolInfo.fromJson(json.decode(str));

class SchoolInfo {
  String admin;
  String school;
  String schoolId;
  String term;
  String year;

  SchoolInfo({
    required this.admin,
    required this.school,
    required this.schoolId,
    required this.term,
    required this.year,
  });
  factory SchoolInfo.fromJson(Map<String, dynamic> json) => SchoolInfo(
        admin: json["admin"],
        school: json["school"],
        schoolId: json["schoolId"],
        term: json["term"],
        year: json["year"],
      );

  Map<String, dynamic> toJson() => {
        "admin": admin,
        "school": school,
        "schoolId": schoolId,
        "term": term,
        "year": year,
      };
}
