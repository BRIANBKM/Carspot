import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class Topdeals extends StatefulWidget {
  const Topdeals({super.key});

  @override
  State<Topdeals> createState() => _TopdealsState();
}

class _TopdealsState extends State<Topdeals> {
  double screenHeight = 0;
  double screenWidth = 0;
  NumberFormat currencyFormat = NumberFormat.currency(
    symbol: "Ksh: ",
    decimalDigits: 2,
  );
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
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: screenHeight / 8,
                width: screenWidth / 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // color: Colors.white,
                  image: const DecorationImage(
                    image: NetworkImage(
                        "https://img.icons8.com/3d-fluency/1x/fire-element.png"),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              const Text(
                'Top Deals',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 30),
              ),
            ],
          ),
          backgroundColor: Color.fromARGB(255, 143, 194, 236),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: screenWidth,
                height: screenHeight,
                color: Colors.white10,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("Roll Royce")
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      final snap = snapshot.data!.docs;
                      return snap.isEmpty
                          ? Center(
                              child: Text(
                                "No cars available",
                                style: TextStyle(
                                    fontSize: screenHeight / 40,
                                    color: Colors.black),
                              ),
                            )
                          : ListView.builder(
                              itemCount: snap.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  height: screenHeight / 2.2,
                                  width: screenWidth,
                                  margin: EdgeInsets.only(
                                      top: index > 0 ? 15 : 10,
                                      left: 6,
                                      right: 6),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black,
                                          blurRadius: 10,
                                          offset: Offset(2, 2)),
                                    ],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                          height: screenHeight / 3.3,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                _getImageUrl(
                                                    snap[index]["images"]),
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          )),
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                " ${snap[index]["brand"]}",
                                                style: TextStyle(
                                                    fontSize: screenHeight / 40,
                                                    color: Colors.black),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Text(
                                                capitalizeFirst(
                                                    snap[index]["model"]),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: screenHeight / 35,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    height: screenHeight / 15,
                                                    width: screenWidth / 20,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      // color: Colors.white,
                                                      image:
                                                          const DecorationImage(
                                                        image: NetworkImage(
                                                            "https://img.icons8.com/windows/512/fuel-gas.png"),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    capitalizeFirst(snap[index]
                                                        ["fuelType"]),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize:
                                                            screenHeight / 35,
                                                        color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    height: screenHeight / 20,
                                                    width: screenWidth / 20,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      // color: Colors.white,
                                                      image:
                                                          const DecorationImage(
                                                        image: NetworkImage(
                                                            "https://img.icons8.com/ios/512/place-marker.png"),
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    "${snap[index]["location"]}",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize:
                                                            screenHeight / 35,
                                                        color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    height: screenHeight / 20,
                                                    width: screenWidth / 20,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      // color: Colors.white,
                                                      image:
                                                          const DecorationImage(
                                                        image: NetworkImage(
                                                            "https://img.icons8.com/ios-filled/512/price-tag.png"),
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  // ignore: prefer_interpolation_to_compose_strings
                                                  Text(
                                                    currencyFormat.format(
                                                        int.parse(snap[index]
                                                            ["price"])),
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize:
                                                          screenHeight / 35,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                    } else {
                      return const Text("NO ENTRY");
                    }
                  },
                ),
              )
            ],
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

  String _getImageUrl(dynamic imagesData) {
    if (imagesData is List && imagesData.isNotEmpty) {
      // assuming the first image URL is a string
      return "https://firebasestorage.googleapis.com/v0/b/carspot-444ed.appspot.com/o/${Uri.encodeComponent(imagesData[0].toString())}?alt=media&token=91734acf-e7dc-4880-929d-9fbfdcc513e2";
    } else if (imagesData is String) {
      return "https://firebasestorage.googleapis.com/v0/b/carspot-444ed.appspot.com/o/${Uri.encodeComponent(imagesData)}?alt=media&token=91734acf-e7dc-4880-929d-9fbfdcc513e2";
    } else {
      // return a default image URL if imagesData is not a list or a string
      return "https://example.com/default-image.jpg";
    }
  }
}
