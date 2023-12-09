import 'dart:core';
import 'package:Karspot/components/cars/bentley.dart';
import 'package:Karspot/components/cars/bmw.dart';
import 'package:Karspot/components/cars/ford.dart';
import 'package:Karspot/components/cars/gmc.dart';
import 'package:Karspot/components/cars/honda.dart';
import 'package:Karspot/components/cars/hyundai.dart';
import 'package:Karspot/components/cars/isuzu.dart';
import 'package:Karspot/components/cars/jaguar.dart';
import 'package:Karspot/components/cars/jeep.dart';
import 'package:Karspot/components/cars/land_rover.dart';
import 'package:Karspot/components/cars/lexus.dart';
import 'package:Karspot/components/cars/mazda.dart';
import 'package:Karspot/components/cars/mercedes_benz.dart';
import 'package:Karspot/components/cars/mistubishi.dart';
import 'package:Karspot/components/cars/nissan.dart';
import 'package:Karspot/components/cars/peugeot.dart';
import 'package:Karspot/components/cars/porche.dart';
import 'package:Karspot/components/cars/proton.dart';
import 'package:Karspot/components/cars/renault.dart';
import 'package:Karspot/components/cars/rollRoyce.dart';
import 'package:Karspot/components/cars/subaru.dart';
import 'package:Karspot/components/cars/suzuki.dart';
import 'package:Karspot/components/cars/toyota.dart';
import 'package:Karspot/components/cars/volkswagen.dart';
import 'package:Karspot/components/cars/volvo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../components/cars/audi.dart';
import '../components/cars/chevrolet.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double screenHeight = 0;
  double screenWidth = 0;
  bool isListSelected = true;
  late TextEditingController _searchController = TextEditingController();

  final username = FirebaseAuth.instance.currentUser!.displayName;
  int date = DateTime.now().day;
  String day = DateFormat('a').format(DateTime.now());
  String hour = DateFormat('hh ').format(DateTime.now());
  DateTime back = DateTime.now();

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  String greeting() {
    String greetingText;

    switch (day) {
      case 'PM':
        if (hour.compareTo('04') > 0 && hour.compareTo('12') < 0) {
          greetingText = 'Good Evening!';
        } else {
          greetingText = 'Good Afternoon!';
        }
        break;
      default:
        greetingText = 'Good Morning!';
    }

    return greetingText;
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
          const message = 'Press again to exit';
          Fluttertoast.showToast(msg: message, fontSize: 18);
          return false;
        } else {
          Fluttertoast.cancel();
          return true;
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: screenHeight / 7,
                color: const Color.fromARGB(179, 226, 234, 231),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "${greeting()}👋",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: "NexaRegular",
                            fontSize: screenWidth / 19),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Welcome ${capitalizeFirst(username.toString())}",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: "NexaRegular",
                            fontSize: screenWidth / 21),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: const EdgeInsets.all(3),
                  // height: screenHeight / 1.4,
                  width: screenWidth,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 10,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Choose a brand:',
                            style: TextStyle(
                                fontSize: screenHeight / 35,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            width: screenWidth / 4,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                isListSelected = true;
                              });
                            },
                            child: Container(
                              height: screenHeight / 35,
                              width: screenWidth / 12,
                              decoration: BoxDecoration(
                                color: !isListSelected
                                    ? Colors.white
                                    : const Color.fromARGB(255, 202, 94, 222),
                                borderRadius: BorderRadius.circular(1),
                                image: const DecorationImage(
                                  image: NetworkImage(
                                      'https://img.icons8.com/metro/256/activity-grid-2.png'),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: screenWidth / 60,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                isListSelected = false;
                              });
                            },
                            child: Container(
                              height: screenHeight / 30,
                              width: screenWidth / 10,
                              decoration: BoxDecoration(
                                color: !isListSelected
                                    ? const Color.fromARGB(255, 202, 94, 222)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                image: const DecorationImage(
                                  image: NetworkImage(
                                      'https://img.icons8.com/ios-glyphs/256/overview-pages-3--v2.png'),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      isListSelected
                          ? Column(
                              children: [
                                SizedBox(
                                  height: screenHeight / 80,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: screenWidth / 80,
                                    ),
                                    carBrands(
                                        "https://img.icons8.com/ios-filled/2x/audi.png",
                                        "Audi",
                                        const Audi()),
                                    SizedBox(
                                      width: screenWidth / 80,
                                    ),
                                    carBrands(
                                        "https://img.icons8.com/color/2x/bentley.png",
                                        "Bentley",
                                        const Bentley()),
                                    SizedBox(
                                      width: screenWidth / 80,
                                    ),
                                    carBrands(
                                        "https://img.icons8.com/plasticine/2x/bmw.png",
                                        "BMW",
                                        const BMW()),
                                    SizedBox(
                                      width: screenWidth / 80,
                                    ),
                                    carBrands(
                                        "https://img.icons8.com/color/2x/chevrolet.png",
                                        "Chevrolet",
                                        const Chevrolet()),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: screenWidth / 80,
                                    ),
                                    carBrands(
                                        "https://img.icons8.com/plasticine/2x/ford.png",
                                        "Ford",
                                        const Ford()),
                                    SizedBox(
                                      width: screenWidth / 80,
                                    ),
                                    carBrands(
                                        "https://img.icons8.com/color/512/gmc.png",
                                        "GMC",
                                        const GMC()),
                                    SizedBox(
                                      width: screenWidth / 80,
                                    ),
                                    carBrands(
                                        "https://img.icons8.com/ios-filled/2x/honda.png",
                                        "Honda",
                                        const Honda()),
                                    SizedBox(
                                      width: screenWidth / 80,
                                    ),
                                    carBrands(
                                        "https://img.icons8.com/color/2x/hyundai.png",
                                        "Hyundai",
                                        const HyundaI()),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: screenWidth / 80,
                                    ),
                                    carBrands(
                                        "https://img.icons8.com/external-tal-revivo-color-tal-revivo/512/external-isuzu-is-a-japanese-commercial-vehicle-and-diesel-engine-manufacturing-company-automotive-color-tal-revivo.png",
                                        "Isuzu",
                                        const Isuzu()),
                                    SizedBox(
                                      width: screenWidth / 80,
                                    ),
                                    carBrands(
                                        "https://img.icons8.com/color/2x/jaguar-logo.png",
                                        "Jaguar",
                                        const Jaguar()),
                                    SizedBox(
                                      width: screenWidth / 80,
                                    ),
                                    carBrands(
                                        "https://img.icons8.com/ios-filled/2x/jeep.png",
                                        "Jeep",
                                        const Jeep()),
                                    SizedBox(
                                      width: screenWidth / 80,
                                    ),
                                    carBrands(
                                        "https://img.icons8.com/color/512/land-rover.png",
                                        "Land Rover",
                                        const LandRover()),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: screenWidth / 80,
                                    ),
                                    carBrands(
                                        "https://img.icons8.com/external-tal-revivo-filled-tal-revivo/512/external-lexus-is-the-luxury-vehicle-division-of-the-japanese-automaker-toyota-automotive-filled-tal-revivo.png",
                                        "Lexus",
                                        const Lexus()),
                                    SizedBox(
                                      width: screenWidth / 80,
                                    ),
                                    carBrands(
                                        "https://img.icons8.com/color/2x/mazda.png",
                                        "Mazda",
                                        const Mazda()),
                                    SizedBox(
                                      width: screenWidth / 80,
                                    ),
                                    carBrands(
                                        "https://img.icons8.com/external-others-inmotus-design/2x/external-Mercedes-mercedes-and-bmw-others-inmotus-design-3.png",
                                        "Mercedes Benz",
                                        const MercedesBenz()),
                                    SizedBox(
                                      width: screenWidth / 80,
                                    ),
                                    carBrands(
                                        "https://img.icons8.com/material-rounded/512/mitsubishi.png",
                                        "Mistubishi",
                                        const Mistubishi()),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: screenWidth / 80,
                                    ),
                                    carBrands(
                                        "https://img.icons8.com/officel/512/nissan.png",
                                        "Nissan",
                                        const Nissan()),
                                    SizedBox(
                                      width: screenWidth / 80,
                                    ),
                                    carBrands(
                                        "https://img.icons8.com/external-tal-revivo-bold-tal-revivo/256/external-peugeot-is-a-french-automotive-manufacturer-part-of-groupe-psa-automotive-bold-tal-revivo.png",
                                        "Peugeot",
                                        const Peugeot()),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    carBrands(
                                        "https://th.bing.com/th/id/R.6aea722d82eddfaf9e5fbaf53a3534d0?rik=1neHdBm6Su9i6A&pid=ImgRaw&r=0",
                                        "Proton",
                                        const Proton()),
                                    SizedBox(
                                      width: screenWidth / 80,
                                    ),
                                    carBrands(
                                        "https://img.icons8.com/color/2x/porsche.png",
                                        "Porche",
                                        const Porche()),
                                    SizedBox(
                                      width: screenWidth / 80,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: screenWidth / 80,
                                    ),
                                    carBrands(
                                        "https://img.icons8.com/external-tal-revivo-bold-tal-revivo/512/external-renault-is-a-french-multinational-automobile-manufacturer-automotive-bold-tal-revivo.png",
                                        "Renault",
                                        const Renault()),
                                    SizedBox(
                                      width: screenWidth / 80,
                                    ),
                                    carBrands(
                                        "https://img.icons8.com/ios/512/rolls-royce.png",
                                        "Roll Royce",
                                        const RollRoyce()),
                                    SizedBox(
                                      width: screenWidth / 80,
                                    ),
                                    carBrands(
                                        "https://img.icons8.com/ios/2x/subaru.png",
                                        "Subaru",
                                        const Subaru()),
                                    SizedBox(
                                      width: screenWidth / 80,
                                    ),
                                    carBrands(
                                        "https://img.icons8.com/ios-filled/2x/suzuki.png",
                                        "Suzuki",
                                        const Suzuki()),
                                    SizedBox(
                                      width: screenWidth / 80,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(children: [
                                  SizedBox(
                                    width: screenWidth / 80,
                                  ),
                                  carBrands(
                                      "https://img.icons8.com/external-tal-revivo-regular-tal-revivo/512/external-toyota-motor-corporation-is-a-japanese-multinational-automotive-manufacturer-automotive-regular-tal-revivo.png",
                                      "Toyota",
                                      const Toyota()),
                                  SizedBox(
                                    width: screenWidth / 80,
                                  ),
                                  carBrands(
                                      "https://img.icons8.com/ios-filled/2x/volkswagen.png",
                                      "Volkswagen",
                                      const Volkswagen()),
                                  SizedBox(
                                    width: screenWidth / 80,
                                  ),
                                  carBrands(
                                      "https://img.icons8.com/ios-filled/2x/volvo--v2.png",
                                      "Volvo",
                                      const Volvo()),
                                  SizedBox(
                                    width: screenWidth / 80,
                                  ),
                                ]),
                              ],
                            )
                          : Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                carBrandsList(
                                    "https://img.icons8.com/ios-filled/2x/audi.png",
                                    "Audi",
                                    const Audi()),
                                const SizedBox(
                                  height: 10,
                                ),
                                carBrandsList(
                                    "https://img.icons8.com/color/2x/bentley.png",
                                    "Bentley",
                                    const Bentley()),
                                const SizedBox(
                                  height: 10,
                                ),
                                carBrandsList(
                                    "https://img.icons8.com/plasticine/2x/bmw.png",
                                    "BMW",
                                    const BMW()),
                                const SizedBox(
                                  height: 10,
                                ),
                                carBrandsList(
                                    "https://img.icons8.com/color/2x/chevrolet.png",
                                    "Chevrolet",
                                    const Chevrolet()),
                                const SizedBox(
                                  height: 10,
                                ),
                                carBrandsList(
                                    "https://img.icons8.com/plasticine/2x/ford.png",
                                    "Ford",
                                    const Ford()),
                                const SizedBox(
                                  height: 10,
                                ),
                                carBrandsList(
                                    "https://img.icons8.com/color/512/gmc.png",
                                    "GMC",
                                    const GMC()),
                                const SizedBox(
                                  height: 10,
                                ),
                                carBrandsList(
                                    "https://img.icons8.com/ios-filled/2x/honda.png",
                                    "Honda",
                                    const Honda()),
                                const SizedBox(
                                  height: 10,
                                ),
                                carBrandsList(
                                    "https://img.icons8.com/color/2x/hyundai.png",
                                    "Hyundai",
                                    const HyundaI()),
                                const SizedBox(
                                  height: 10,
                                ),
                                carBrandsList(
                                    "https://img.icons8.com/external-tal-revivo-color-tal-revivo/512/external-isuzu-is-a-japanese-commercial-vehicle-and-diesel-engine-manufacturing-company-automotive-color-tal-revivo.png",
                                    "Isuzu",
                                    const Isuzu()),
                                const SizedBox(
                                  height: 10,
                                ),
                                carBrandsList(
                                    "https://img.icons8.com/color/2x/jaguar-logo.png",
                                    "Jaguar",
                                    const Jaguar()),
                                const SizedBox(
                                  height: 10,
                                ),
                                carBrandsList(
                                    "https://img.icons8.com/ios-filled/2x/jeep.png",
                                    "Jeep",
                                    const Jeep()),
                                const SizedBox(
                                  height: 10,
                                ),
                                carBrandsList(
                                    "https://img.icons8.com/color/512/land-rover.png",
                                    "Land Rover",
                                    const LandRover()),
                                const SizedBox(
                                  height: 10,
                                ),
                                carBrandsList(
                                    "https://img.icons8.com/external-tal-revivo-filled-tal-revivo/512/external-lexus-is-the-luxury-vehicle-division-of-the-japanese-automaker-toyota-automotive-filled-tal-revivo.png",
                                    "Lexus",
                                    const Lexus()),
                                const SizedBox(
                                  height: 10,
                                ),
                                carBrandsList(
                                    "https://img.icons8.com/color/2x/mazda.png",
                                    "Mazda",
                                    const Mazda()),
                                const SizedBox(
                                  height: 10,
                                ),
                                carBrandsList(
                                    "https://img.icons8.com/external-others-inmotus-design/2x/external-Mercedes-mercedes-and-bmw-others-inmotus-design-3.png",
                                    "Mercedes Benz",
                                    const MercedesBenz()),
                                const SizedBox(
                                  height: 10,
                                ),
                                carBrandsList(
                                    "https://img.icons8.com/material-rounded/512/mitsubishi.png",
                                    "Mistubishi",
                                    const Mistubishi()),
                                const SizedBox(
                                  height: 10,
                                ),
                                carBrandsList(
                                    "https://img.icons8.com/officel/512/nissan.png",
                                    "Nissan",
                                    const Nissan()),
                                const SizedBox(
                                  height: 10,
                                ),
                                carBrandsList(
                                    "https://img.icons8.com/external-tal-revivo-bold-tal-revivo/256/external-peugeot-is-a-french-automotive-manufacturer-part-of-groupe-psa-automotive-bold-tal-revivo.png",
                                    "Peugeot",
                                    const Peugeot()),
                                const SizedBox(
                                  height: 10,
                                ),
                                carBrandsList(
                                    "https://th.bing.com/th/id/R.6aea722d82eddfaf9e5fbaf53a3534d0?rik=1neHdBm6Su9i6A&pid=ImgRaw&r=0",
                                    "Proton",
                                    const Proton()),
                                const SizedBox(
                                  height: 10,
                                ),
                                carBrandsList(
                                    "https://img.icons8.com/color/2x/porsche.png",
                                    "Porche",
                                    const Porche()),
                                const SizedBox(
                                  height: 10,
                                ),
                                carBrandsList(
                                    "https://img.icons8.com/external-tal-revivo-bold-tal-revivo/512/external-renault-is-a-french-multinational-automobile-manufacturer-automotive-bold-tal-revivo.png",
                                    "Renault",
                                    const Renault()),
                                const SizedBox(
                                  height: 10,
                                ),
                                carBrandsList(
                                    "https://img.icons8.com/ios/512/rolls-royce.png",
                                    "Roll Royce",
                                    const RollRoyce()),
                                const SizedBox(
                                  height: 10,
                                ),
                                carBrandsList(
                                    "https://img.icons8.com/ios/2x/subaru.png",
                                    "Subaru",
                                    const Subaru()),
                                const SizedBox(
                                  height: 10,
                                ),
                                carBrandsList(
                                    "https://img.icons8.com/ios-filled/2x/suzuki.png",
                                    "Suzuki",
                                    const Suzuki()),
                                const SizedBox(
                                  height: 10,
                                ),
                                carBrandsList(
                                    "https://img.icons8.com/external-tal-revivo-regular-tal-revivo/512/external-toyota-motor-corporation-is-a-japanese-multinational-automotive-manufacturer-automotive-regular-tal-revivo.png",
                                    "Toyota",
                                    const Toyota()),
                                const SizedBox(
                                  height: 10,
                                ),
                                carBrandsList(
                                    "https://img.icons8.com/ios-filled/2x/volkswagen.png",
                                    "Volkswagen",
                                    const Volkswagen()),
                                const SizedBox(
                                  height: 10,
                                ),
                                carBrandsList(
                                    "https://img.icons8.com/ios-filled/2x/volvo--v2.png",
                                    "Volvo",
                                    const Volvo()),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget carBrands(url, name, page) {
    return Center(
      child: InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => page));
        },
        child: Container(
          margin: const EdgeInsets.all(5),
          height: screenHeight / 10,
          width: screenWidth / 5,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                blurRadius: 10,
                offset: Offset(2, 2),
              ),
            ],
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(url),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }

  String capitalizeFirst(String string) {
    if (string.isEmpty) {
      return string;
    }
    return "${string[0].toUpperCase()}${string.substring(1)}";
  }

  Widget carBrandsList(url, name, page) {
    return Center(
      child: InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => page));
        },
        child: Container(
          margin: const EdgeInsets.all(5),
          height: screenHeight / 15,
          width: screenWidth,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                blurRadius: 10,
                offset: Offset(2, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                height: screenHeight / 15,
                width: screenWidth / 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(url),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                name,
                style: TextStyle(
                    fontSize: screenHeight / 40, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
