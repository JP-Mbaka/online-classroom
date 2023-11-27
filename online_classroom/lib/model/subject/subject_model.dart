import 'package:cloud_firestore/cloud_firestore.dart';

class SubjectModel {
  String subjectTitle;
  String level;
  String department;
  String subjectId;
  String userId; //the teacher
  String subjectCode;
  List<dynamic>? lesson;
  // DateTime? year;
  // bool? carryOver;
  // DateTime? whichYear;
  // int? units;
  // int? CA;
  // int? practical;
  // int? exam;

  SubjectModel({
    required this.subjectTitle,
    required this.level,
    required this.department,
    required this.subjectCode,
    required this.subjectId,
    required this.userId,
    required this.lesson,
  });

  factory SubjectModel.fromJson(Map<String, dynamic> json) => SubjectModel(
        subjectTitle: json["subjectTitle"],
        level: json["level"],
        department: json["department"],
        subjectCode: json["subjectCode"],
        subjectId: json["subjectId"],
        userId: json["userId"],
        lesson: List<LessonModel>.from(
            json["lesson"].map((x) => LessonModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "subjectTitle": subjectTitle,
        "level": level,
        "department": department,
        "subjectCode": subjectCode,
        "subjectId": subjectId,
        "userId": userId,
        "lesson": List<dynamic>.from(lesson!.map((x) => x.toJson())),
      };

  factory SubjectModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return SubjectModel(
      subjectTitle: data?["subjectTitle"],
      level: data?["level"],
      department: data?["department"],
      subjectCode: data?["subjectCode"],
      subjectId: data?["subjectId"],
      userId: data?["userId"],
      lesson: data?['lesson'] is Iterable ? List.from(data?['lesson']) : null,
    );
  }
}

class LessonModel {
  String lessonTopic;
  String lessonDesc;
  String lessonUrl;
  String? imgUrl;
  String level;
  String semester;
  // List<TaskModel>? task;

  LessonModel({
    required this.lessonTopic,
    required this.lessonDesc,
    required this.lessonUrl,
    this.imgUrl,
    required this.level,
    required this.semester,
    // this.task,
  });

  factory LessonModel.fromJson(Map<String, dynamic> json) => LessonModel(
      lessonTopic: json["lessonTopic"],
      lessonDesc: json["lessonDesc"],
      lessonUrl: json["lessonUrl"],
      level: json["level"],
      semester: json["semester"]);

  Map<String, dynamic> toJson() => {
        "lessonTopic": lessonTopic,
        "lessonDesc": lessonDesc,
        "lessonUrl": lessonUrl,
        "level": level,
        "semester": semester,
      };
}
