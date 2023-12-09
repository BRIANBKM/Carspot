import 'package:Karspot/pages/pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../components/colors.dart';

class MobileView extends StatefulWidget {
  const MobileView({super.key});

  @override
  State<MobileView> createState() => _MobileViewState();
}

class _MobileViewState extends State<MobileView> {
  int _page = 0;
  late PageController pageController;
  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  void onPageChange(int page) {
    setState(() {
      _page = page;
    });
  }

  void onNavigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
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
        body: PageView(
          controller: pageController,
          onPageChanged: onPageChange,
          children: homeScreenItems,
        ),
        bottomNavigationBar: CupertinoTabBar(
          backgroundColor: mobileBackgroundColor,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined,
                    size: 40, color: (_page == 0) ? Colors.red : Colors.blue),
                label: "",
                backgroundColor: primaryColor),
            BottomNavigationBarItem(
                icon: Icon(Icons.local_fire_department_outlined,
                    size: 40, color: (_page == 1) ? Colors.red : Colors.blue),
                label: "",
                backgroundColor: primaryColor),
            BottomNavigationBarItem(
                icon: Icon(Icons.attach_money_outlined,
                    size: 40, color: (_page == 2) ? Colors.red : Colors.blue),
                label: "",
                backgroundColor: primaryColor),
            BottomNavigationBarItem(
                icon: Icon(Icons.person,
                    size: 40, color: (_page == 3) ? Colors.red : Colors.blue),
                label: "",
                backgroundColor: primaryColor)
          ],
          onTap: onNavigationTapped,
          currentIndex: _page,
        ),
      ),
    );
  }
}
