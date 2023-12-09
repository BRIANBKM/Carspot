import 'package:Karspot/main.dart';
import 'package:Karspot/pages/register.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'mobileView.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  double screenHeight = 0;
  double screenWidth = 0;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController resetController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _obscureText = true;

  void navigateToSignUp() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Register()));
  }

  @override
  void dispose() {
    super.dispose();
    passwordController.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    DateTime? timeBackPressed;

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
            height: screenHeight / 1.4,
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
                        onPressed: login,
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
                        child: const Text('Login'),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: screenHeight / 12,
                        width: screenWidth / 1.8,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25.0),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0.0, 5.0),
                              blurRadius: 8.0,
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () => handleGoogleSignup(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.white,
                                backgroundImage: NetworkImage(
                                    "https://img.icons8.com/color/256/google-logo.png"),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Sign up with Google',
                                style: TextStyle(
                                    fontSize: screenWidth / 30,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight / 40,
                      ),
                      InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(
                                    "Reset Password",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: screenHeight / 35,
                                        color: Colors.red),
                                  ),
                                  content: SizedBox(
                                    height: screenHeight / 6,
                                    width: screenWidth / 1.5,
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          controller: resetController,
                                          cursorColor: Colors.white,
                                          textInputAction: TextInputAction.next,
                                          decoration: const InputDecoration(
                                              labelText: "Email"),
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          validator: (email) => email != null &&
                                                  !EmailValidator.validate(
                                                      email)
                                              ? "Enter a valid email"
                                              : null,
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            resetPassword();
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.lightGreen,
                                            textStyle: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 50, vertical: 15),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          child: const Text('Reset'),
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text("Close"),
                                    ),
                                  ],
                                );
                              });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: const Text(
                            "Forgot Password",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                decoration: TextDecoration.underline,
                                color: Colors.black),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: const Text(
                              "Don't have an account? ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ),
                          InkWell(
                            onTap: navigateToSignUp,
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: const Text(
                                "Sign Up",
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

  Future<void> login() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MobileView()),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage;

      switch (e.code) {
        case 'invalid-email':
          errorMessage = 'Invalid email';
          break;
        case 'user-not-found':
          errorMessage = 'User not found';
          break;
        case 'wrong-password':
          errorMessage = 'Wrong password';
          break;
        default:
          errorMessage = e.message ?? 'An error occurred';
          break;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            errorMessage,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          // ignore: prefer_const_constructors
          backgroundColor: Color.fromARGB(255, 219, 25, 11),
        ),
      );
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  Future<void> resetPassword() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      await _auth.sendPasswordResetEmail(email: resetController.text.trim());
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Done",
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          // ignore: prefer_const_constructors
          backgroundColor: Colors.green,
        ),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
            style: const TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          // ignore: prefer_const_constructors
          backgroundColor: Color.fromARGB(255, 219, 25, 11),
        ),
      );
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  Future<void> handleGoogleSignup() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      final googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final UserCredential authResult =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final User user = authResult.user!;
      final userData = {
        'username': user.displayName!,
        'email': user.email!,
      };
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(user.uid)
          .set(userData);

      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MobileView()),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
            style: const TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 219, 25, 11),
        ),
      );
    } finally {
      // Hide loading indicator
      Navigator.pop(context);
    }
  }
}
