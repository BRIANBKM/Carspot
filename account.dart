import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/cars/Liked.dart';
import '../components/cars/mycars.dart';
import '../main.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  TextEditingController sendFeedbackController = TextEditingController();
  double screenWidth = 0;
  double screenHeight = 0;
  final email = FirebaseAuth.instance.currentUser!.email;
  final username = FirebaseAuth.instance.currentUser!.displayName;
  final userData = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
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
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            height: screenHeight,
            width: screenHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  height: 120,
                  width: 120,
                  margin: const EdgeInsets.all(10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blue[300],
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 80,
                    ),
                  ),
                ),
                Container(
                  height: screenHeight / 3,
                  width: screenHeight,
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          blurStyle: BlurStyle.solid,
                          offset: Offset(2, 2),
                          blurRadius: 0,
                        )
                      ]),
                  child: Column(
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MyCar()));
                          },
                          child: list("My cars")),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Liked()));
                          },
                          child: list("Liked")),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                          onTap: () {
                            sendFeedback();
                          },
                          child: list(
                            "Send feedback",
                          ))
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton.icon(
                      icon: Icon(
                        Icons.logout,
                        size: screenWidth / 12,
                        color: Colors.green,
                      ),
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      label: const Text(
                        'Sign out',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Nexabold',
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: signout,
                    ),
                  ),
                ),
                
                SizedBox(
                  height: screenHeight / 8,
                ),
                Container(
                  height: screenHeight / 12,
                  width: screenHeight,
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          blurStyle: BlurStyle.solid,
                          offset: Offset(2, 2),
                          blurRadius: 0,
                        )
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        // width: screenWidth / 20,
                        // height: screenWidth / 20,
                        child: ElevatedButton(
                          onPressed: () async {
                            const url =
                                "https://www.instagram.com/karspot_kenya/";
                            // ignore: deprecated_member_use
                            if (await canLaunch(url)) {
                              // ignore: deprecated_member_use
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            backgroundColor: Colors.red[100],
                          ),
                          child: CircleAvatar(
                            backgroundColor: Colors.red[100],
                            radius: screenWidth / 20,
                            backgroundImage: const NetworkImage(
                                "https://img.icons8.com/color/1x/instagram-new.png"),
                          ),
                        ),
                      ),
                      SizedBox(
                        // width: screenWidth / 20,
                        // height: screenWidth / 20,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            backgroundColor: Colors.red[100],
                          ),
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: screenWidth / 20,
                            backgroundImage: const NetworkImage(
                                "https://img.icons8.com/color/1x/facebook-new.png"),
                          ),
                        ),
                      ),
                      SizedBox(
                        // width: screenWidth / 20,
                        // height: screenWidth / 20,
                        child: ElevatedButton(
                          onPressed: () async {
                            const url = "https://twitter.com/KarSpot_kenya";
                            // ignore: deprecated_member_use
                            if (await canLaunch(url)) {
                              // ignore: deprecated_member_use
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            backgroundColor: Colors.red[100],
                          ),
                          child: CircleAvatar(
                            backgroundColor: Colors.red[100],
                            radius: screenWidth / 20,
                            backgroundImage: const NetworkImage(
                                "https://img.icons8.com/fluency/1x/twitter.png"),
                          ),
                        ),
                      ),
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

  Future signout() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      await FirebaseAuth.instance.signOut();
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

  Widget list(
    name,
  ) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(5),
        height: screenHeight / 15,
        width: screenWidth / 2,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 140, 195, 240),
              blurRadius: 10,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              name,
              style: TextStyle(
                  fontSize: screenHeight / 40, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }

  sendFeedback() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Center(
            child: Text(
              'SEND FEEDBACK',
              style: TextStyle(
                fontSize: screenWidth / 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          content: Container(
            height: screenHeight / 5,
            width: double.infinity,
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: sendFeedbackController,
                  maxLength: 100,
                  cursorColor: Colors.red,
                ),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      Navigator.of(context).pop();
                      String feedback = sendFeedbackController.text.trim();
                      if (feedback.isNotEmpty) {
                        final Email email = Email(
                          body: feedback,
                          subject: 'KarSpot FEEDBACK MESSAGES',
                          recipients: ['brianmaina900@gmail.com'],
                          isHTML: false,
                        );
                        try {
                          await FlutterEmailSender.send(email);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "SUCCESS",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              backgroundColor: Color.fromARGB(255, 219, 25, 11),
                            ),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "FAILED!! ${e.toString()}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              backgroundColor:
                                  const Color.fromARGB(255, 219, 25, 11),
                            ),
                          );
                        }
                        Navigator.of(context).pop();
                      }
                    },
                    icon: const Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Send Feedback',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
