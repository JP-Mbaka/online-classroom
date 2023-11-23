import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:online_classroom/constants/dimensions.dart';
import 'package:online_classroom/constants/image_refs.dart';
import 'package:online_classroom/auth/logging.dart';
import 'package:online_classroom/model/school/school_model.dart';
import 'package:online_classroom/provider/userProvider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _form2Key = GlobalKey<FormState>();

  final _form3eKey = GlobalKey<FormState>();

  final _adminSchoolController = TextEditingController();
  final _adminSchoolCodeController = TextEditingController();

  final _adminIDController = TextEditingController();

  final _fnameController = TextEditingController();
  final _lnameController = TextEditingController();
  final _othernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _schoolController = TextEditingController();
  final _schoolIdController = TextEditingController();
  final _userIdController = TextEditingController();
  final _userTypeController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  //Passord Controlls

  bool showPass = true;
  bool showConPass = true;

  bool isNAdmin = true;

  _showPass() {
    setState(() {
      showPass = !showPass;
    });
  }

  _showConPass() {
    setState(() {
      showConPass = !showConPass;
    });
  }

//Dropdown controlls
  dynamic userTypeValue = 0;

  List<DropdownMenuItem> usertypeList = [
    const DropdownMenuItem(
      value: 0,
      child: Text("Select usertype"),
    ),
    const DropdownMenuItem(
      value: "Student",
      child: Text("Student"),
    ),
    const DropdownMenuItem(
      value: "Teacher",
      child: Text("Teacher"),
    ),
    const DropdownMenuItem(
      value: "Admin",
      child: Text("Admin"),
    ),
  ];

  @override
  void dispose() {
    _fnameController.dispose();
    _lnameController.dispose();
    _othernameController.dispose();
    _emailController.dispose();
    _schoolIdController.dispose();
    _schoolController.dispose();
    _userIdController.dispose();
    _userTypeController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _adminSchoolCodeController.dispose();
    _adminSchoolController.dispose();
    _adminIDController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
                key: _form2Key,
                child: Column(
                  children: [
                    Image.asset(
                      createIcon,
                      height: height(context) * 0.35,
                      width: width(context) * 0.45,
                    ),
                    // SizedBox(height: height(context) * 0.02),
                    TextFormField(
                      controller: _fnameController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Must contain Characters";
                        } else if (value.trim().length < 3) {
                          return "Please enter a valid name";
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                          label: Text("Firstname"),
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(height: height(context) * 0.02),
                    TextFormField(
                      controller: _othernameController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Must contain Characters";
                        } else if (value.trim().length < 3) {
                          return "Please enter a valid name";
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                          label: Text("Othername"),
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(height: height(context) * 0.02),
                    TextFormField(
                      controller: _lnameController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Must contain Characters";
                        } else if (value.trim().length < 3) {
                          return "Please enter a valid name";
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                          label: Text("Lastname"),
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(height: height(context) * 0.02),
                    TextFormField(
                      controller: _emailController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Must contain Characters";
                        } else if (value.trim().length < 3 ||
                            !value.trim().contains("@")) {
                          return "Please enter a valid email address";
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                          label: Text("Email"),
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(height: height(context) * 0.02),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: showPass,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Must contain *Characters \n *numbers \n *special Characters";
                        } else if (value.trim().length < 6) {
                          return "Please enter a valid password 6 characters & above";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          label: const Text("Password"),
                          prefixIcon: const Icon(Icons.password),
                          suffixIcon: IconButton(
                            onPressed: _showPass,
                            icon: const Icon(Icons.remove_red_eye),
                          ),
                          border: const OutlineInputBorder()),
                    ),
                    SizedBox(height: height(context) * 0.02),
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: showConPass,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Must contain *Characters \n *numbers \n *special Characters";
                        } else if (value.trim().length < 6) {
                          return "Please enter a valid password 6 characters & above";
                        } else if (value != _passwordController.text) {
                          return "Incorrect. Please confirm your password";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          label: const Text("Confirm Password"),
                          prefixIcon: const Icon(Icons.password_outlined),
                          suffixIcon: IconButton(
                            onPressed: _showConPass,
                            icon: const Icon(Icons.remove_red_eye),
                          ),
                          border: const OutlineInputBorder()),
                    ),
                    //NEw step starts from here
                    SizedBox(height: height(context) * 0.02),
                    DropdownButtonFormField(
                      value: userTypeValue,
                      items: usertypeList,
                      isExpanded: true,
                      decoration: const InputDecoration(),
                      onChanged: (val) {
                        setState(() {
                          userTypeValue = val;
                          _userIdController.text = generateuserID(val);
                          if (val == "Admin") {
                            isNAdmin = false;
                            showMore();
                          }
                        });
                      },
                    ),
                    SizedBox(height: height(context) * 0.02),
                    TextFormField(
                      controller: _userIdController,
                      enabled: false,
                      decoration: const InputDecoration(
                          label: Text("User ID"),
                          prefixIcon: Icon(Icons.person_4),
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(height: height(context) * 0.02),
                    TextFormField(
                      controller: _schoolController,
                      enabled: isNAdmin,
                      decoration: const InputDecoration(
                          label: Text("School Name"),
                          prefixIcon: Icon(Icons.school),
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(height: height(context) * 0.02),
                    TextFormField(
                      controller: _schoolIdController,
                      enabled: isNAdmin,
                      decoration: const InputDecoration(
                          label: Text("School Code"),
                          prefixIcon: Icon(Icons.school_outlined),
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(height: height(context) * 0.02),
                    TextFormField(
                      controller: _userIdController,
                      decoration: const InputDecoration(
                          label: Text("Admin ID"),
                          prefixIcon: Icon(Icons.person_4),
                          border: OutlineInputBorder()),
                      onEditingComplete: () async {
                        final db = FirebaseDatabase.instance.ref();
                        final snapshot = await db
                            .child("users/schools/${_adminIDController.text}")
                            .get();

                        if (snapshot.exists) {
                          print(snapshot.value);
                          final ar =
                              schoolInfoFromJson(snapshot.value.toString());
                          print(ar.school);
                          print(ar.schoolId);
                        } else {
                          print("No data available");
                        }
                      },
                    ),
                    SizedBox(height: height(context) * 0.05),
                    ElevatedButton(
                      onPressed: onSubmit,
                      child: const Text("Create Account"),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account"),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (_) => LoginScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }

  String generateuserID(val) {
    var r = Random().nextInt(9999) + 20;
    if (val == "Student") {
      return "s$r";
    } else if (val == "Teacher") {
      return "t$r";
    } else if (val == "Admin") {
      return "a$r";
    }
    return "";
  }

  onSubmit() {
    var isValid = _form2Key.currentState!.validate();
    if (isValid == false) {
      return;
    }

    _form2Key.currentState?.save();

    _form3eKey.currentState?.save();
    try {
      onCreateAccount(
        email: _emailController.text,
        pass: _passwordController.text,
        isLogin: false,
        fname: _fnameController.text,
        lname: _lnameController.text,
        othername: _othernameController.text,
        school: _schoolController.text,
        schoolId: _schoolIdController.text,
        userId: _userIdController.text,
        userType: userTypeValue,
        adminID: _adminIDController.text,
      );
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("User account is created successfully"),
        ),
      );

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => LoginScreen(),
        ),
      );
    } on FirebaseAuthException catch (er) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(er.message ?? "Authentication failed"),
        ),
      );
    }
  }

  showMore() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isDismissible: false,
        builder: (_) => SingleChildScrollView(
              child: Container(
                color: Colors.transparent,
                child: Column(
                  children: [
                    IconButton.filled(
                      style: IconButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.onBackground,
                          foregroundColor:
                              Theme.of(context).colorScheme.background),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.close,
                        size: 28,
                        color: Theme.of(context).colorScheme.onBackground,
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
                            key: _form3eKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: _adminSchoolController,
                                  validator: (value) {
                                    if (value == null ||
                                        value.trim().isEmpty ||
                                        value.trim().length < 3) {
                                      return "Must contain Characters";
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: const InputDecoration(
                                      label: Text("School Name"),
                                      border: OutlineInputBorder()),
                                ),
                                SizedBox(height: height(context) * 0.02),
                                TextFormField(
                                  controller: _adminSchoolCodeController,
                                  validator: (value) {
                                    if (value == null ||
                                        value.trim().isEmpty ||
                                        value.trim().length < 3) {
                                      return "Must contain Characters";
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: const InputDecoration(
                                      label: Text("School Code"),
                                      border: OutlineInputBorder()),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        var isValid =
                                            _form3eKey.currentState?.validate();
                                        if (isValid == false) {
                                          return;
                                        }
                                        _schoolController.text =
                                            _adminSchoolController.text;
                                        _schoolIdController.text =
                                            _adminSchoolCodeController.text;
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("Save")),
                                ),
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
