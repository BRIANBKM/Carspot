import 'dart:async';

import 'package:Karspot/pages/login.dart';
import 'package:Karspot/pages/mobileView.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'KarSpot',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AnimatedSplashScreen(
        splash: Image.asset("assets/logo 6.png", width: 170, height: 300),
        duration: 2000,
        splashTransition: SplashTransition.scaleTransition,
        nextScreen: const MainPage(),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool _isConnected = true;

  @override
  void initState() {
    super.initState();

    // Check internet connection
    checkInternet();
  }

  StreamSubscription<ConnectivityResult>? _connectivitySubscription;

  @override
  void dispose() {
    _connectivitySubscription?.cancel();
    super.dispose();
  }

  Future<void> checkInternet() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        _isConnected = false;
      });
    } else {
      setState(() {
        _isConnected = true;
      });
    }

    // Subscribe to connectivity changes
    _connectivitySubscription =
        Connectivity().onConnectivityChanged.listen((result) {
      setState(() {
        _isConnected = result != ConnectivityResult.none;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData && _isConnected) {
            return const MobileView();
          } else if (snapshot.hasData && !_isConnected) {
            return _buildOfflineBar();
          } else {
            return const Login();
          }
        },
      ),
    );
  }

  Widget _buildOfflineBar() {
    return Positioned(
      bottom: 100,
      left: 0,
      right: 0,
      child: Container(
        color: Colors.red,
        height: 30,
        child: Center(
          child: Text(
            'No internet connection. Please connect to the internet.',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
