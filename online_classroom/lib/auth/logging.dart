import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online_classroom/auth/signup.dart';
import 'package:online_classroom/constants/dimensions.dart';
import 'package:online_classroom/constants/image_refs.dart';
import 'package:online_classroom/main.dart';
import 'package:online_classroom/provider/authProvider.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _form1Key = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool showPass = true;

  _showPass() {
    setState(() {
      showPass = !showPass;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: (height(context) * 0.7) +
                MediaQuery.of(context).viewInsets.bottom,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _form1Key,
                child: Column(
                  children: [
                    Image.asset(
                      authIcon,
                      height: height(context) * 0.25,
                      width: width(context) * 0.45,
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
                    SizedBox(height: height(context) * 0.05),
                    ElevatedButton(
                      onPressed: onSubmit,
                      child: const Text("Login"),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("You don\'t have an account?"),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => SignupScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            "Signup now",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  onSubmit() {
    var isValid = _form1Key.currentState!.validate();
    if (isValid == false) {
      return;
    }

    _form1Key.currentState!.save();
    try {
      onCreateAccount(
        email: _emailController.text,
        pass: _passwordController.text,
      );
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("User is logged-in successfully"),
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

    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => const MyApp()));
  }
}
