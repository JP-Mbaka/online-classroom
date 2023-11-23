import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:online_classroom/constants/dimensions.dart';
import 'package:online_classroom/model/user/userModel.dart';
import 'package:online_classroom/widget/popup.dart';

class AdminDashboardScreen extends StatefulWidget {
  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  final db = FirebaseFirestore.instance;
  final dbf = FirebaseDatabase.instance;
  final userCredential = FirebaseAuth.instance.currentUser;

  final _form3erKey = GlobalKey<FormState>();

  final _schoolNameController = TextEditingController();
  final _schoolCodeController = TextEditingController();

  bool isNSchlEdit = false;
  bool isNSchlCodeEdit = false;

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  void dispose() {
    _schoolCodeController.dispose();
    _schoolNameController.dispose();
    super.dispose();
  }

  getData() async {
    // final res = db.collection("school").doc("Yabatech").get();
    final res = db.collection("school").doc(userCredential!.uid).get();

    res.then((value) {
      final data = value.data() as Map<String, dynamic>;
      // print(data["school"]);
      _schoolNameController.text = data["school"];
      // print(data["schoolId"]);
      _schoolCodeController.text = data["schoolId"];
      return data;
    });
  }

  getschoolNameupdate() async {
    final res = dbf.ref("users/schools/${userCredential!.uid}/");
    await res.update({"school": _schoolNameController.text});
  }

  getschoolIdupdate() async {
    final res = dbf.ref("users/schools/${userCredential!.uid}/");
    await res.update({"schoolId": _schoolCodeController.text});
  }

  getTeachers() async {
    // print("working workimngnrkjerk $res");
    String? teacher;
    await db
        .collection("school")
        .doc(userCredential!.uid)
        .collection("teachers")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        print(element["userId"]);
        _loadTeacherInfo(element["userId"]);
      });
      // print("${teacher}   Working working");
      // return null;
    });
  }

  _loadTeacherInfo(teacher) async {
    try {
      final snapshot = await dbf.ref("users/${teacher!}/").once();

      final zee = snapshot.snapshot.value;

      print(jsonEncode(zee));
      // if (snapshot.exists) {
      //   print("Working DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD");
      // //   print(snapshot.value);
      UserModel ar = userModelFromJson(jsonEncode(zee).toString());
      // ar.toJson(json.encode(snapshot.snapshot.value));
      print(ar.school);
      print(ar.fName);
      print(ar.otherName);
      print(ar.userId);
    } catch (e) {
      print("this is the problem ooooooooooooo: $e");
    }
  }

  getSubjects() async {
    QuerySnapshot res = await db
        .collection("school")
        .doc(userCredential!.uid)
        .collection("subjects")
        .get();
    List subject = [];

    res.docs.forEach((element) {
      subject.add(element);
    });
  }

  @override
  Widget build(BuildContext context) {
    getTeachers();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                  key: _form3erKey,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("School name"),
                          IconButton.outlined(
                            onPressed: () {
                              if (isNSchlEdit == true) {
                                db
                                    .collection("school")
                                    .doc(userCredential!.uid)
                                    .set({"school": _schoolNameController.text},
                                        SetOptions(merge: true));
                                getschoolNameupdate();
                              }
                              setState(() {
                                isNSchlEdit = !isNSchlEdit;
                              });
                            },
                            icon: Icon(isNSchlEdit ? Icons.done : Icons.edit),
                          ),
                        ],
                      ),
                      TextFormField(
                        controller: _schoolNameController,
                        enabled: isNSchlEdit,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("School code"),
                          IconButton.outlined(
                            onPressed: () {
                              if (isNSchlCodeEdit == true) {
                                db
                                    .collection("school")
                                    .doc(userCredential!.uid)
                                    .set({
                                  "schoolId": _schoolCodeController.text
                                }, SetOptions(merge: true));
                                getschoolIdupdate();
                              }
                              setState(() {
                                isNSchlCodeEdit = !isNSchlCodeEdit;
                              });
                            },
                            icon:
                                Icon(isNSchlCodeEdit ? Icons.done : Icons.edit),
                          ),
                        ],
                      ),
                      TextFormField(
                        controller: _schoolCodeController,
                        enabled: isNSchlCodeEdit,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: height(context) * 0.02),
                      // SizedBox(
                      //   width: double.infinity,
                      //   child: ElevatedButton(
                      //     onPressed: () {},
                      //     child: const Text("Save"),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                //Listview of all school teachers orderby their department
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Teachers",
                      textAlign: TextAlign.left,
                    ),
                    IconButton(
                      onPressed: () {
                        MyPopUp.showMyDialog(context,
                            mWidget: Container(
                              color: Colors.white,
                              child: Form(
                                  child: Column(
                                children: [
                                  TextFormField(
                                    decoration: const InputDecoration(
                                        label: Text("Firstname"),
                                        border: OutlineInputBorder()),
                                  ),
                                  TextFormField(
                                    decoration: const InputDecoration(
                                        label: Text("Othername"),
                                        border: OutlineInputBorder()),
                                  ),
                                  TextFormField(
                                    decoration: const InputDecoration(
                                        label: Text("Surname"),
                                        border: OutlineInputBorder()),
                                  ),
                                  TextFormField(
                                    decoration: const InputDecoration(
                                        label: Text("email"),
                                        border: OutlineInputBorder()),
                                  ),
                                  TextFormField(
                                    decoration: const InputDecoration(
                                        label: Text("Password"),
                                        border: OutlineInputBorder()),
                                  ),
                                  TextFormField(
                                    decoration: const InputDecoration(
                                        label: Text("Department"),
                                        border: OutlineInputBorder()),
                                  ),
                                ],
                              )),
                            ));
                      },
                      icon: const Icon(Icons.add, size: 28),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    // padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                    child: ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        ListTile(
                          leading: Text("1"),
                          title: Text(
                            "Name of Teacher",
                          ),
                          titleTextStyle:
                              Theme.of(context).textTheme.titleSmall,
                          subtitle: const Text("Departments"),
                          trailing: SizedBox(
                            width: 100,
                            child: FittedBox(
                              child: Row(
                                children: [
                                  IconButton.outlined(
                                    onPressed: showMore,
                                    icon: const Icon(Icons.remove_red_eye),
                                  ),
                                  IconButton.outlined(
                                    onPressed: showMore,
                                    icon: const Icon(Icons.edit),
                                  ),
                                  IconButton.outlined(
                                    onPressed: showMore,
                                    icon: const Icon(Icons.delete),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Text(
                  "Subjects",
                  textAlign: TextAlign.left,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                    child: ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                    ),
                  ),
                ),

                //Delete me below

                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Admin ID: ${userCredential!.uid}"),
                      TextButton(
                          onPressed: () {
                            FirebaseAuth.instance.signOut();
                          },
                          child: const Text("Log me out")),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  showMore() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (_) => SingleChildScrollView(
              child: Container(
                color: Colors.transparent,
                child: Column(
                  children: [
                    IconButton.filled(
                      style: IconButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.background,
                          foregroundColor:
                              Theme.of(context).colorScheme.onBackground),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.close,
                        size: 28,
                        color: Theme.of(context).colorScheme.background,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onBackground,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(15),
                          topLeft: Radius.circular(15),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 8.0)
                          .copyWith(top: 16.0),
                      child: Column(
                        children: [
                          Form(
                            child: Column(
                              children: [
                                TextFormField(
                                  // controller: _emailController,
                                  // validator: (value) {
                                  //   if (value == null || value.trim().isEmpty) {
                                  //     return "Must contain Characters";
                                  //   } else if (value.trim().length < 3 ||
                                  //       !value.trim().contains("@")) {
                                  //     return "Please enter a valid email address";
                                  //   } else {
                                  //     return null;
                                  //   }
                                  // },
                                  decoration: const InputDecoration(
                                      label: Text("Name"),
                                      border: OutlineInputBorder()),
                                ),
                                SizedBox(height: height(context) * 0.02),
                                TextFormField(
                                  // controller: _emailController,
                                  // validator: (value) {
                                  //   if (value == null || value.trim().isEmpty) {
                                  //     return "Must contain Characters";
                                  //   } else if (value.trim().length < 3 ||
                                  //       !value.trim().contains("@")) {
                                  //     return "Please enter a valid email address";
                                  //   } else {
                                  //     return null;
                                  //   }
                                  // },
                                  decoration: const InputDecoration(
                                      label: Text("Department"),
                                      border: OutlineInputBorder()),
                                ),
                                ElevatedButton(
                                    onPressed: () {},
                                    child: const Text("save")),
                              ],
                            ),
                          ),
                          const Text(
                            "Subjects",
                            textAlign: TextAlign.left,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                border: Border.all(),
                              ),
                              child: ListView(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                              ),
                            ),
                          ),
                          SizedBox(height: height(context) * 0.05),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}
