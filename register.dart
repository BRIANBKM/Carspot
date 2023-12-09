import 'package:Karspot/pages/login.dart';
import 'package:Karspot/pages/mobileView.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../main.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  double screenHeight = 0;
  double screenWidth = 0;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  void navigateToLogin() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Login()));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    DateTime? timeBackPressed;
    bool _obscureText = true;

    return WillPopScope(
      onWillPop: () async {
        final difference =
            DateTime.now().difference(timeBackPressed ?? DateTime.now());
        final isExitWarning = difference >= const Duration(seconds: 2);
        timeBackPressed = DateTime.now();

        if (isExitWarning) {
          const message = 'Press back again to exit';
          Fluttertoast.showToast(msg: message, fontSize: 18);
          return false;
        } else {
          Fluttertoast.cancel();
          return true;
        }
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        height: screenHeight,
        width: screenWidth,
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: const Color.fromARGB(255, 149, 63, 63),
                width: 2,
              ),
            ),
            height: screenHeight / 1.6,
            width: screenWidth / 1.2,
            child: Scaffold(
              backgroundColor: Colors.white,
              resizeToAvoidBottomInset: false,
              body: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: const [
                          CircleAvatar(
                            backgroundColor: Color.fromARGB(255, 182, 181, 181),
                            radius: 45,
                            backgroundImage: NetworkImage(
                                "https://img.icons8.com/color-glass/256/guest-male.png"),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      TextFormField(
                        controller: usernameController,
                        cursorColor: Colors.white,
                        textInputAction: TextInputAction.next,
                        decoration:
                            const InputDecoration(labelText: "Username"),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      TextFormField(
                        controller: emailController,
                        cursorColor: Colors.white,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(labelText: "Email"),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (email) =>
                            email != null && !EmailValidator.validate(email)
                                ? "Enter a valid email"
                                : null,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      TextFormField(
                        controller: passwordController,
                        cursorColor: Colors.white,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            child: Icon(
                              _obscureText
                                  ? Icons.visibility
                                  // ignore: dead_code
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        obscureText: _obscureText,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value?.trim().isEmpty == true) {
                            return 'Enter your password';
                          }
                          if (value != null && value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      ElevatedButton(
                        onPressed: signUp,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text('Sign up'),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: const Text(
                              "Already have  an account? ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ),
                          InkWell(
                            onTap: navigateToLogin,
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    decoration: TextDecoration.underline,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: const Text("KARSPOT"),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future signUp() async {
    try {
      // Show progress indicator while waiting for Firebase response
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );

      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      var collection = FirebaseFirestore.instance
          .collection('Users')
          .doc(emailController.text.trim());
      collection.set({
        'name': usernameController.text.trim(),
        'email': emailController.text.trim(),
      });

      await userCredential.user?.updateDisplayName(
        usernameController.text.trim(),
      );
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MobileView()),
      );
    } on FirebaseAuthException catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.message ?? 'An error occurred',
            style: const TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 219, 25, 11),
        ),
      );
      Navigator.pop(context);
    }
  }
}
