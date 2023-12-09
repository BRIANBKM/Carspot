import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class SellMyCar extends StatefulWidget {
  const SellMyCar({Key? key}) : super(key: key);

  @override
  State<SellMyCar> createState() => _SellMyCarState();
}

class _SellMyCarState extends State<SellMyCar> {
  final email = FirebaseAuth.instance.currentUser!.email;
  double screenHeight = 0;
  double screenWidth = 0;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController transmissioController = TextEditingController();
  final TextEditingController sellingPriceController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController mileageController = TextEditingController();
  FirebaseAppCheck firebaseAppCheck = FirebaseAppCheck.instance;

  @override
  void dispose() {
    modelController.dispose();
    transmissioController.dispose();
    yearController.dispose();
    mileageController.dispose();
    numberController.dispose();
    sellingPriceController.dispose();
    super.dispose();
  }

  String selectedcarFuelType = "Petrol";
  String selectedcarBrand = 'Audi';
  String selectedLocation = 'Nairobi';
  List<String> locations = [
    "Nairobi",
    "Kiambu",
    "Nakuru",
    "Kakamega",
    "Bungoma",
    "Meru",
    "Kilifi",
    "Mombasa",
    "Machakos",
    "Kirinyaga",
    "Kisii",
    "Kitui",
    "Homa Bay",
    "Kajiado",
    "Uasin Gishu",
    "Narok",
    "Nyeri",
    "Migori",
    "Embu",
    "Murang'a",
    "Kericho",
    "Nandi",
    "Bomet",
    "Siaya",
    "Laikipia",
    "Kisumu",
    "Makueni",
    "Trans Nzoia",
    "Tharaka-Nithi",
    "West Pokot",
    "Marsabit",
    "Nyandarua",
    "Busia",
    "Vihiga",
    "Taita Taveta",
    "Turkana",
    "Wajir",
    "Isiolo",
    "Samburu",
    "Garissa",
    "Tana River",
    "Lamu",
    "Mandera",
    "Taita Taveta",
    "Kwale"
  ];
  List<String> fuelType = [
    "Petrol",
    "Diesel",
    "Electric",
  ];
  List<String> carBrands = [
    'Audi',
    'Bentley',
    'BMW',
    'Chevrolet',
    'Ford',
    'GMC',
    'Honda',
    'Hyundai',
    'Isuzu',
    'Jaguar',
    'Jeep',
    'Land Rover',
    'Lexus',
    'Mazda',
    'Mercedes Benz',
    'Mitsubishi',
    'Nissan',
    'Peugeot',
    'Porche',
    'Proton',
    'Renault',
    'Roll Royce',
    'Subaru',
    'Suzuki',
    'Toyota',
    'Volkswagen',
    'Volvo'
  ];

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
          title: Center(
            child: Text(
              'Sell My Car',
              style: TextStyle(
                  fontSize: screenWidth / 10, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text(
                    'Enter Car Details',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Select a car brand:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: screenWidth / 1.2,
                        height: screenHeight / 15,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
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
                        child: DropdownButtonFormField(
                          value: selectedcarBrand,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Choose a car brand',
                            hintStyle: TextStyle(fontSize: 16),
                          ),
                          items: carBrands.map((brand) {
                            return DropdownMenuItem(
                              value: brand,
                              child: Text(brand),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              selectedcarBrand = newValue!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: screenWidth / 1.2,
                    height: screenHeight / 15,
                    margin: EdgeInsets.only(bottom: screenWidth / 50),
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
                      border: Border.all(
                        color: Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Car Model',
                          hintStyle: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      controller: modelController,
                    ),
                  ),
                  Container(
                    width: screenWidth / 1.2,
                    height: screenHeight / 15,
                    margin: EdgeInsets.only(bottom: screenWidth / 50),
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
                      border: Border.all(
                        color: Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: ElevatedButton(
                      onPressed: selectImages,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white),
                      child: Text(
                        selectedImageNames.isEmpty
                            ? 'Select Images'
                            : selectedImageNames.join(', '),
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: screenWidth / 2.5,
                        height: screenHeight / 15,
                        margin: EdgeInsets.only(bottom: screenWidth / 50),
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
                          border: Border.all(
                            color: Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: TextFormField(
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Transmission Type',
                              hintStyle: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          controller: transmissioController,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        width: screenWidth / 2.5,
                        height: screenHeight / 15,
                        margin: EdgeInsets.only(bottom: screenWidth / 50),
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
                          border: Border.all(
                            color: Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: TextFormField(
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Year of Manufacture',
                              hintStyle: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            LengthLimitingTextInputFormatter(4),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          controller: yearController,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: screenWidth / 2.5,
                        height: screenHeight / 15,
                        margin: EdgeInsets.only(bottom: screenWidth / 50),
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
                          border: Border.all(
                            color: Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: DropdownButtonFormField(
                          value: selectedcarFuelType,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Choose a fuel type',
                            hintStyle: TextStyle(fontSize: 16),
                          ),
                          items: fuelType.map((brand) {
                            return DropdownMenuItem(
                              value: brand,
                              child: Text(brand),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              selectedcarFuelType = newValue!;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 20),
                      Container(
                        width: screenWidth / 2.5,
                        height: screenHeight / 15,
                        margin: EdgeInsets.only(bottom: screenWidth / 50),
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
                          border: Border.all(
                            color: Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: TextFormField(
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Mileage',
                              hintStyle: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            LengthLimitingTextInputFormatter(7),
                            FilteringTextInputFormatter.digitsOnly,
                            ThousandsFormatter(),
                          ],
                          controller: mileageController,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: screenWidth / 1.2,
                    height: screenHeight / 15,
                    margin: EdgeInsets.only(bottom: screenWidth / 50),
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
                      border: Border.all(
                        color: Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Phone Number',
                          hintStyle: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(10),
                        FilteringTextInputFormatter.digitsOnly,
                        _PhoneNumberFormatter()
                      ],
                      controller: numberController,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: screenWidth / 1.2,
                    height: screenHeight / 15,
                    margin: EdgeInsets.only(bottom: screenWidth / 50),
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
                      border: Border.all(
                        color: Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Selling Price',
                        hintStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        prefixText: 'KSH: ',
                        prefixStyle: TextStyle(
                          color: Colors.grey[700],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                        ThousandsFormatter()
                      ],
                      controller: sellingPriceController,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Select my location:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: screenWidth / 1.2,
                        height: screenHeight / 15,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
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
                        child: DropdownButtonFormField(
                          value: selectedLocation,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Choose a car brand',
                            hintStyle: TextStyle(fontSize: 16),
                          ),
                          items: locations.map((location) {
                            return DropdownMenuItem(
                              value: location,
                              child: Text(location),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              selectedLocation = newValue!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Row(
                  //   children: [
                  //     Checkbox(
                  //       value: _isChecked,
                  //       onChanged: (bool? value) {
                  //         setState(() {
                  //           _isChecked = value!;
                  //         });
                  //       },
                  //     ),
                  //     Text(
                  //       'Mark as a hot deal',
                  //       style: TextStyle(fontSize: 18,),
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      sell();
                    },
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
                    child: const Text('SELL'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<String> selectedImageNames = [];
  List<XFile> imagesList = [];

  Future<void> selectImages() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        imagesList.add(pickedFile);
        selectedImageNames.add(pickedFile.name);
      });
    }
  }

  Future<void> sell() async {
    if (modelController.text.trim().isEmpty ||
        transmissioController.text.trim().isEmpty ||
        yearController.text.trim().isEmpty ||
        mileageController.text.trim().isEmpty ||
        numberController.text.trim().isEmpty ||
        sellingPriceController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Please fill all the fields",
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          // ignore: prefer_const_constructors
          backgroundColor: Color.fromARGB(255, 219, 25, 11),
        ),
      );
      return;
    }
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      if (selectedcarBrand == "Audi") {
        Uint8List combinedBytes = Uint8List(0);
        for (XFile image in imagesList) {
          List<int> bytes = await image.readAsBytes();
          combinedBytes = Uint8List.fromList([...combinedBytes, ...bytes]);
        }
        final carRef = FirebaseFirestore.instance
            .collection('CARS')
            .doc('carsId')
            .collection('Audi')
            .doc(DateTime.now().toString());
        final carStorageRef = FirebaseStorage.instance.ref('Audi/${carRef.id}');
        final uploadTask = carStorageRef.putData(combinedBytes);
        final snapshot = await uploadTask;
        final carData = {
          "email": email,
          'brand': selectedcarBrand,
          'model': modelController.text.trim(),
          'fuelType': selectedcarFuelType,
          'phoneNumber': numberController.text.trim(),
          "mileage": mileageController.text.trim(),
          "year": yearController.text.trim(),
          "transmission": transmissioController.text.trim(),
          'location': selectedLocation,
          'price': sellingPriceController.text.trim(),
          'images': [snapshot.ref.fullPath],
          'createdAt': DateTime.now(),
        };
        await carRef.set(carData);
      } else if (selectedcarBrand == "Bentley") {
        Uint8List combinedBytes = Uint8List(0);
        for (XFile image in imagesList) {
          List<int> bytes = await image.readAsBytes();
          combinedBytes = Uint8List.fromList([...combinedBytes, ...bytes]);
        }

        final carRef = FirebaseFirestore.instance
            .collection('CARS')
            .doc('carsId')
            .collection('Bentley')
            .doc(DateTime.now().toString());
        final carStorageRef =
            FirebaseStorage.instance.ref('Bentley/${carRef.id}');
        final uploadTask = carStorageRef.putData(combinedBytes);
        final snapshot = await uploadTask;
        final carData = {
          "email": email,
          'brand': selectedcarBrand,
          'model': modelController.text.trim(),
          'fuelType': selectedcarFuelType,
          'phoneNumber': numberController.text.trim(),
          "mileage": mileageController.text.trim(),
          "year": yearController.text.trim(),
          "transmission": transmissioController.text.trim(),
          'location': selectedLocation,
          'price': sellingPriceController.text.trim(),
          'images': [snapshot.ref.fullPath],
          'createdAt': DateTime.now(),
        };
        await carRef.set(carData);
      } else if (selectedcarBrand == "BMW") {
        Uint8List combinedBytes = Uint8List(0);
        for (XFile image in imagesList) {
          List<int> bytes = await image.readAsBytes();
          combinedBytes = Uint8List.fromList([...combinedBytes, ...bytes]);
        }

        final carRef = FirebaseFirestore.instance
            .collection('CARS')
            .doc('carsId')
            .collection('BMW')
            .doc(DateTime.now().toString());
        final carStorageRef = FirebaseStorage.instance.ref('BMW/${carRef.id}');
        final uploadTask = carStorageRef.putData(combinedBytes);
        final snapshot = await uploadTask;
        final carData = {
          "email": email,
          'brand': selectedcarBrand,
          'model': modelController.text.trim(),
          'fuelType': selectedcarFuelType,
          'phoneNumber': numberController.text.trim(),
          "mileage": mileageController.text.trim(),
          "year": yearController.text.trim(),
          "transmission": transmissioController.text.trim(),
          'location': selectedLocation,
          'price': sellingPriceController.text.trim(),
          'images': [snapshot.ref.fullPath],
          'createdAt': DateTime.now(),
        };
        await carRef.set(carData);
      } else if (selectedcarBrand == "Chevrolet") {
        Uint8List combinedBytes = Uint8List(0);
        for (XFile image in imagesList) {
          List<int> bytes = await image.readAsBytes();
          combinedBytes = Uint8List.fromList([...combinedBytes, ...bytes]);
        }

        final carRef = FirebaseFirestore.instance
            .collection('CARS')
            .doc('carsId')
            .collection('Chevrolet')
            .doc(DateTime.now().toString());
        final carStorageRef =
            FirebaseStorage.instance.ref('Chevrolet/${carRef.id}');
        final uploadTask = carStorageRef.putData(combinedBytes);
        final snapshot = await uploadTask;
        final carData = {
          "email": email,
          'brand': selectedcarBrand,
          'model': modelController.text.trim(),
          'fuelType': selectedcarFuelType,
          'phoneNumber': numberController.text.trim(),
          "mileage": mileageController.text.trim(),
          "year": yearController.text.trim(),
          "transmission": transmissioController.text.trim(),
          'location': selectedLocation,
          'price': sellingPriceController.text.trim(),
          'images': [snapshot.ref.fullPath],
          'createdAt': DateTime.now(),
        };
        await carRef.set(carData);
      } else if (selectedcarBrand == "Ford") {
        Uint8List combinedBytes = Uint8List(0);
        for (XFile image in imagesList) {
          List<int> bytes = await image.readAsBytes();
          combinedBytes = Uint8List.fromList([...combinedBytes, ...bytes]);
        }

        final carRef = FirebaseFirestore.instance
            .collection('CARS')
            .doc('carsId')
            .collection('Ford')
            .doc(DateTime.now().toString());
        final carStorageRef = FirebaseStorage.instance.ref('Ford/${carRef.id}');
        final uploadTask = carStorageRef.putData(combinedBytes);
        final snapshot = await uploadTask;
        final carData = {
          "email": email,
          'brand': selectedcarBrand,
          'model': modelController.text.trim(),
          'fuelType': selectedcarFuelType,
          'phoneNumber': numberController.text.trim(),
          "mileage": mileageController.text.trim(),
          "year": yearController.text.trim(),
          "transmission": transmissioController.text.trim(),
          'location': selectedLocation,
          'price': sellingPriceController.text.trim(),
          'images': [snapshot.ref.fullPath],
          'createdAt': DateTime.now(),
        };
        await carRef.set(carData);
      } else if (selectedcarBrand == "GMC") {
        Uint8List combinedBytes = Uint8List(0);
        for (XFile image in imagesList) {
          List<int> bytes = await image.readAsBytes();
          combinedBytes = Uint8List.fromList([...combinedBytes, ...bytes]);
        }

        final carRef = FirebaseFirestore.instance
            .collection('CARS')
            .doc('carsId')
            .collection('GMC')
            .doc(DateTime.now().toString());
        final carStorageRef = FirebaseStorage.instance.ref('GMC/${carRef.id}');
        final uploadTask = carStorageRef.putData(combinedBytes);
        final snapshot = await uploadTask;
        final carData = {
          "email": email,
          'brand': selectedcarBrand,
          'model': modelController.text.trim(),
          'fuelType': selectedcarFuelType,
          'phoneNumber': numberController.text.trim(),
          "mileage": mileageController.text.trim(),
          "year": yearController.text.trim(),
          "transmission": transmissioController.text.trim(),
          'location': selectedLocation,
          'price': sellingPriceController.text.trim(),
          'images': [snapshot.ref.fullPath],
          'createdAt': DateTime.now(),
        };
        await carRef.set(carData);
      } else if (selectedcarBrand == "Honda") {
        Uint8List combinedBytes = Uint8List(0);
        for (XFile image in imagesList) {
          List<int> bytes = await image.readAsBytes();
          combinedBytes = Uint8List.fromList([...combinedBytes, ...bytes]);
        }

        final carRef = FirebaseFirestore.instance
            .collection('CARS')
            .doc('carsId')
            .collection('Honda')
            .doc(DateTime.now().toString());
        final carStorageRef =
            FirebaseStorage.instance.ref('Honda/${carRef.id}');
        final uploadTask = carStorageRef.putData(combinedBytes);
        final snapshot = await uploadTask;
        final carData = {
          "email": email,
          'brand': selectedcarBrand,
          'model': modelController.text.trim(),
          'fuelType': selectedcarFuelType,
          'phoneNumber': numberController.text.trim(),
          "mileage": mileageController.text.trim(),
          "year": yearController.text.trim(),
          "transmission": transmissioController.text.trim(),
          'location': selectedLocation,
          'price': sellingPriceController.text.trim(),
          'images': [snapshot.ref.fullPath],
          'createdAt': DateTime.now(),
        };
        await carRef.set(carData);
      } else if (selectedcarBrand == "Hyundai") {
        Uint8List combinedBytes = Uint8List(0);
        for (XFile image in imagesList) {
          List<int> bytes = await image.readAsBytes();
          combinedBytes = Uint8List.fromList([...combinedBytes, ...bytes]);
        }

        final carRef = FirebaseFirestore.instance
            .collection('CARS')
            .doc('carsId')
            .collection('Hyundai')
            .doc(DateTime.now().toString());
        final carStorageRef =
            FirebaseStorage.instance.ref('Hyundai/${carRef.id}');
        final uploadTask = carStorageRef.putData(combinedBytes);
        final snapshot = await uploadTask;
        final carData = {
          "email": email,
          'brand': selectedcarBrand,
          'model': modelController.text.trim(),
          'fuelType': selectedcarFuelType,
          'phoneNumber': numberController.text.trim(),
          "mileage": mileageController.text.trim(),
          "year": yearController.text.trim(),
          "transmission": transmissioController.text.trim(),
          'location': selectedLocation,
          'price': sellingPriceController.text.trim(),
          'images': [snapshot.ref.fullPath],
          'createdAt': DateTime.now(),
        };
        await carRef.set(carData);
      } else if (selectedcarBrand == "Isuzu") {
        Uint8List combinedBytes = Uint8List(0);
        for (XFile image in imagesList) {
          List<int> bytes = await image.readAsBytes();
          combinedBytes = Uint8List.fromList([...combinedBytes, ...bytes]);
        }

        final carRef = FirebaseFirestore.instance
            .collection('CARS')
            .doc('carsId')
            .collection('Isuzu')
            .doc(DateTime.now().toString());
        final carStorageRef =
            FirebaseStorage.instance.ref('Isuzu/${carRef.id}');
        final uploadTask = carStorageRef.putData(combinedBytes);
        final snapshot = await uploadTask;
        final carData = {
          "email": email,
          'brand': selectedcarBrand,
          'model': modelController.text.trim(),
          'fuelType': selectedcarFuelType,
          'phoneNumber': numberController.text.trim(),
          "mileage": mileageController.text.trim(),
          "year": yearController.text.trim(),
          "transmission": transmissioController.text.trim(),
          'location': selectedLocation,
          'price': sellingPriceController.text.trim(),
          'images': [snapshot.ref.fullPath],
          'createdAt': DateTime.now(),
        };
        await carRef.set(carData);
      } else if (selectedcarBrand == "Jaguar") {
        Uint8List combinedBytes = Uint8List(0);
        for (XFile image in imagesList) {
          List<int> bytes = await image.readAsBytes();
          combinedBytes = Uint8List.fromList([...combinedBytes, ...bytes]);
        }

        final carRef = FirebaseFirestore.instance
            .collection('CARS')
            .doc('carsId')
            .collection('Jaguar')
            .doc(DateTime.now().toString());
        final carStorageRef =
            FirebaseStorage.instance.ref('Jaguar/${carRef.id}');
        final uploadTask = carStorageRef.putData(combinedBytes);
        final snapshot = await uploadTask;
        final carData = {
          "email": email,
          'brand': selectedcarBrand,
          'model': modelController.text.trim(),
          'fuelType': selectedcarFuelType,
          'phoneNumber': numberController.text.trim(),
          "mileage": mileageController.text.trim(),
          "year": yearController.text.trim(),
          "transmission": transmissioController.text.trim(),
          'location': selectedLocation,
          'price': sellingPriceController.text.trim(),
          'images': [snapshot.ref.fullPath],
          'createdAt': DateTime.now(),
        };
        await carRef.set(carData);
      } else if (selectedcarBrand == "Jeep") {
        Uint8List combinedBytes = Uint8List(0);
        for (XFile image in imagesList) {
          List<int> bytes = await image.readAsBytes();
          combinedBytes = Uint8List.fromList([...combinedBytes, ...bytes]);
        }

        final carRef = FirebaseFirestore.instance
            .collection('CARS')
            .doc('carsId')
            .collection('Jeep')
            .doc(DateTime.now().toString());
        final carStorageRef = FirebaseStorage.instance.ref('Jeep/${carRef.id}');
        final uploadTask = carStorageRef.putData(combinedBytes);
        final snapshot = await uploadTask;
        final carData = {
          "email": email,
          'brand': selectedcarBrand,
          'model': modelController.text.trim(),
          'fuelType': selectedcarFuelType,
          'phoneNumber': numberController.text.trim(),
          "mileage": mileageController.text.trim(),
          "year": yearController.text.trim(),
          "transmission": transmissioController.text.trim(),
          'location': selectedLocation,
          'price': sellingPriceController.text.trim(),
          'images': [snapshot.ref.fullPath],
          'createdAt': DateTime.now(),
        };
        await carRef.set(carData);
      } else if (selectedcarBrand == "Land Rover") {
        Uint8List combinedBytes = Uint8List(0);
        for (XFile image in imagesList) {
          List<int> bytes = await image.readAsBytes();
          combinedBytes = Uint8List.fromList([...combinedBytes, ...bytes]);
        }

        final carRef = FirebaseFirestore.instance
            .collection('CARS')
            .doc('carsId')
            .collection('Land_Rover')
            .doc(DateTime.now().toString());
        final carStorageRef =
            FirebaseStorage.instance.ref('Land_Rover/${carRef.id}');
        final uploadTask = carStorageRef.putData(combinedBytes);
        final snapshot = await uploadTask;
        final carData = {
          "email": email,
          'brand': selectedcarBrand,
          'model': modelController.text.trim(),
          'fuelType': selectedcarFuelType,
          'phoneNumber': numberController.text.trim(),
          "mileage": mileageController.text.trim(),
          "year": yearController.text.trim(),
          "transmission": transmissioController.text.trim(),
          'location': selectedLocation,
          'price': sellingPriceController.text.trim(),
          'images': [snapshot.ref.fullPath],
          'createdAt': DateTime.now(),
        };
        await carRef.set(carData);
      } else if (selectedcarBrand == "Lexus") {
        Uint8List combinedBytes = Uint8List(0);
        for (XFile image in imagesList) {
          List<int> bytes = await image.readAsBytes();
          combinedBytes = Uint8List.fromList([...combinedBytes, ...bytes]);
        }

        final carRef = FirebaseFirestore.instance
            .collection('CARS')
            .doc('carsId')
            .collection('Lexus')
            .doc(DateTime.now().toString());
        final carStorageRef =
            FirebaseStorage.instance.ref('Lexus/${carRef.id}');
        final uploadTask = carStorageRef.putData(combinedBytes);
        final snapshot = await uploadTask;
        final carData = {
          "email": email,
          'brand': selectedcarBrand,
          'model': modelController.text.trim(),
          'fuelType': selectedcarFuelType,
          'phoneNumber': numberController.text.trim(),
          "mileage": mileageController.text.trim(),
          "year": yearController.text.trim(),
          "transmission": transmissioController.text.trim(),
          'location': selectedLocation,
          'price': sellingPriceController.text.trim(),
          'images': [snapshot.ref.fullPath],
          'createdAt': DateTime.now(),
        };
        await carRef.set(carData);
      } else if (selectedcarBrand == "Mazda") {
        Uint8List combinedBytes = Uint8List(0);
        for (XFile image in imagesList) {
          List<int> bytes = await image.readAsBytes();
          combinedBytes = Uint8List.fromList([...combinedBytes, ...bytes]);
        }

        final carRef = FirebaseFirestore.instance
            .collection('CARS')
            .doc('carsId')
            .collection('Mazda')
            .doc(DateTime.now().toString());
        final carStorageRef =
            FirebaseStorage.instance.ref('Mazda/${carRef.id}');
        final uploadTask = carStorageRef.putData(combinedBytes);
        final snapshot = await uploadTask;
        final carData = {
          "email": email,
          'brand': selectedcarBrand,
          'model': modelController.text.trim(),
          'fuelType': selectedcarFuelType,
          'phoneNumber': numberController.text.trim(),
          "mileage": mileageController.text.trim(),
          "year": yearController.text.trim(),
          "transmission": transmissioController.text.trim(),
          'location': selectedLocation,
          'price': sellingPriceController.text.trim(),
          'images': [snapshot.ref.fullPath],
          'createdAt': DateTime.now(),
        };
        await carRef.set(carData);
      } else if (selectedcarBrand == "Mercedes Benz") {
        Uint8List combinedBytes = Uint8List(0);
        for (XFile image in imagesList) {
          List<int> bytes = await image.readAsBytes();
          combinedBytes = Uint8List.fromList([...combinedBytes, ...bytes]);
        }

        final carRef = FirebaseFirestore.instance
            .collection('CARS')
            .doc('carsId')
            .collection('Mercedes Benz')
            .doc(DateTime.now().toString());
        final carStorageRef =
            FirebaseStorage.instance.ref('Mercedes Benz/${carRef.id}');
        final uploadTask = carStorageRef.putData(combinedBytes);
        final snapshot = await uploadTask;
        final carData = {
          "email": email,
          'brand': selectedcarBrand,
          'model': modelController.text.trim(),
          'fuelType': selectedcarFuelType,
          'phoneNumber': numberController.text.trim(),
          "mileage": mileageController.text.trim(),
          "year": yearController.text.trim(),
          "transmission": transmissioController.text.trim(),
          'location': selectedLocation,
          'price': sellingPriceController.text.trim(),
          'images': [snapshot.ref.fullPath],
          'createdAt': DateTime.now(),
        };
        await carRef.set(carData);
      } else if (selectedcarBrand == "Mitsubishi") {
        Uint8List combinedBytes = Uint8List(0);
        for (XFile image in imagesList) {
          List<int> bytes = await image.readAsBytes();
          combinedBytes = Uint8List.fromList([...combinedBytes, ...bytes]);
        }

        final carRef = FirebaseFirestore.instance
            .collection('CARS')
            .doc('carsId')
            .collection('Mitsubishi')
            .doc(DateTime.now().toString());
        final carStorageRef =
            FirebaseStorage.instance.ref('Mitsubishi/${carRef.id}');
        final uploadTask = carStorageRef.putData(combinedBytes);
        final snapshot = await uploadTask;
        final carData = {
          "email": email,
          'brand': selectedcarBrand,
          'model': modelController.text.trim(),
          'fuelType': selectedcarFuelType,
          'phoneNumber': numberController.text.trim(),
          "mileage": mileageController.text.trim(),
          "year": yearController.text.trim(),
          "transmission": transmissioController.text.trim(),
          'location': selectedLocation,
          'price': sellingPriceController.text.trim(),
          'images': [snapshot.ref.fullPath],
          'createdAt': DateTime.now(),
        };
        await carRef.set(carData);
      } else if (selectedcarBrand == "Nissan") {
        Uint8List combinedBytes = Uint8List(0);
        for (XFile image in imagesList) {
          List<int> bytes = await image.readAsBytes();
          combinedBytes = Uint8List.fromList([...combinedBytes, ...bytes]);
        }

        final carRef = FirebaseFirestore.instance
            .collection('CARS')
            .doc('carsId')
            .collection('Nissan')
            .doc(DateTime.now().toString());
        final carStorageRef =
            FirebaseStorage.instance.ref('Nissan/${carRef.id}');
        final uploadTask = carStorageRef.putData(combinedBytes);
        final snapshot = await uploadTask;
        final carData = {
          "email": email,
          'brand': selectedcarBrand,
          'model': modelController.text.trim(),
          'fuelType': selectedcarFuelType,
          'phoneNumber': numberController.text.trim(),
          "mileage": mileageController.text.trim(),
          "year": yearController.text.trim(),
          "transmission": transmissioController.text.trim(),
          'location': selectedLocation,
          'price': sellingPriceController.text.trim(),
          'images': [snapshot.ref.fullPath],
          'createdAt': DateTime.now(),
        };
        await carRef.set(carData);
      } else if (selectedcarBrand == "Peugeot") {
        Uint8List combinedBytes = Uint8List(0);
        for (XFile image in imagesList) {
          List<int> bytes = await image.readAsBytes();
          combinedBytes = Uint8List.fromList([...combinedBytes, ...bytes]);
        }

        final carRef = FirebaseFirestore.instance
            .collection('CARS')
            .doc('carsId')
            .collection('Peugeot')
            .doc(DateTime.now().toString());
        final carStorageRef =
            FirebaseStorage.instance.ref('Peugeot/${carRef.id}');
        final uploadTask = carStorageRef.putData(combinedBytes);
        final snapshot = await uploadTask;
        final carData = {
          "email": email,
          'brand': selectedcarBrand,
          'model': modelController.text.trim(),
          'fuelType': selectedcarFuelType,
          'phoneNumber': numberController.text.trim(),
          "mileage": mileageController.text.trim(),
          "year": yearController.text.trim(),
          "transmission": transmissioController.text.trim(),
          'location': selectedLocation,
          'price': sellingPriceController.text.trim(),
          'images': [snapshot.ref.fullPath],
          'createdAt': DateTime.now(),
        };
        await carRef.set(carData);
      } else if (selectedcarBrand == "Porche") {
        Uint8List combinedBytes = Uint8List(0);
        for (XFile image in imagesList) {
          List<int> bytes = await image.readAsBytes();
          combinedBytes = Uint8List.fromList([...combinedBytes, ...bytes]);
        }

        final carRef = FirebaseFirestore.instance
            .collection('CARS')
            .doc('carsId')
            .collection('Porche')
            .doc(DateTime.now().toString());
        final carStorageRef =
            FirebaseStorage.instance.ref('Porche/${carRef.id}');
        final uploadTask = carStorageRef.putData(combinedBytes);
        final snapshot = await uploadTask;
        final carData = {
          "email": email,
          'brand': selectedcarBrand,
          'model': modelController.text.trim(),
          'fuelType': selectedcarFuelType,
          'phoneNumber': numberController.text.trim(),
          "mileage": mileageController.text.trim(),
          "year": yearController.text.trim(),
          "transmission": transmissioController.text.trim(),
          'location': selectedLocation,
          'price': sellingPriceController.text.trim(),
          'images': [snapshot.ref.fullPath],
          'createdAt': DateTime.now(),
        };
        await carRef.set(carData);
      } else if (selectedcarBrand == "Proton") {
        Uint8List combinedBytes = Uint8List(0);
        for (XFile image in imagesList) {
          List<int> bytes = await image.readAsBytes();
          combinedBytes = Uint8List.fromList([...combinedBytes, ...bytes]);
        }

        final carRef = FirebaseFirestore.instance
            .collection('CARS')
            .doc('carsId')
            .collection('Proton')
            .doc(DateTime.now().toString());
        final carStorageRef =
            FirebaseStorage.instance.ref('Proton/${carRef.id}');
        final uploadTask = carStorageRef.putData(combinedBytes);
        final snapshot = await uploadTask;
        final carData = {
          "email": email,
          'brand': selectedcarBrand,
          'model': modelController.text.trim(),
          'fuelType': selectedcarFuelType,
          'phoneNumber': numberController.text.trim(),
          "mileage": mileageController.text.trim(),
          "year": yearController.text.trim(),
          "transmission": transmissioController.text.trim(),
          'location': selectedLocation,
          'price': sellingPriceController.text.trim(),
          'images': [snapshot.ref.fullPath],
          'createdAt': DateTime.now(),
        };
        await carRef.set(carData);
      } else if (selectedcarBrand == "Renault") {
        Uint8List combinedBytes = Uint8List(0);
        for (XFile image in imagesList) {
          List<int> bytes = await image.readAsBytes();
          combinedBytes = Uint8List.fromList([...combinedBytes, ...bytes]);
        }

        final carRef = FirebaseFirestore.instance
            .collection('CARS')
            .doc('carsId')
            .collection('Renault')
            .doc(DateTime.now().toString());
        final carStorageRef =
            FirebaseStorage.instance.ref('Renault/${carRef.id}');
        final uploadTask = carStorageRef.putData(combinedBytes);
        final snapshot = await uploadTask;
        final carData = {
          "email": email,
          'brand': selectedcarBrand,
          'model': modelController.text.trim(),
          'fuelType': selectedcarFuelType,
          'phoneNumber': numberController.text.trim(),
          "mileage": mileageController.text.trim(),
          "year": yearController.text.trim(),
          "transmission": transmissioController.text.trim(),
          'location': selectedLocation,
          'price': sellingPriceController.text.trim(),
          'images': [snapshot.ref.fullPath],
          'createdAt': DateTime.now(),
        };
        await carRef.set(carData);
      } else if (selectedcarBrand == "Roll Royce") {
        Uint8List combinedBytes = Uint8List(0);
        for (XFile image in imagesList) {
          List<int> bytes = await image.readAsBytes();
          combinedBytes = Uint8List.fromList([...combinedBytes, ...bytes]);
        }

        final carRef = FirebaseFirestore.instance
            .collection('CARS')
            .doc('carsId')
            .collection('Roll Royce')
            .doc(DateTime.now().toString());
        final carStorageRef =
            FirebaseStorage.instance.ref('Roll Royce/${carRef.id}');
        final uploadTask = carStorageRef.putData(combinedBytes);
        final snapshot = await uploadTask;
        final carData = {
          "email": email,
          'brand': selectedcarBrand,
          'model': modelController.text.trim(),
          'fuelType': selectedcarFuelType,
          'phoneNumber': numberController.text.trim(),
          "mileage": mileageController.text.trim(),
          "year": yearController.text.trim(),
          "transmission": transmissioController.text.trim(),
          'location': selectedLocation,
          'price': sellingPriceController.text.trim(),
          'images': [snapshot.ref.fullPath],
          'createdAt': DateTime.now(),
        };
        await carRef.set(carData);
      } else if (selectedcarBrand == "Subaru") {
        Uint8List combinedBytes = Uint8List(0);
        for (XFile image in imagesList) {
          List<int> bytes = await image.readAsBytes();
          combinedBytes = Uint8List.fromList([...combinedBytes, ...bytes]);
        }

        final carRef = FirebaseFirestore.instance
            .collection('CARS')
            .doc('carsId')
            .collection('Subaru')
            .doc(DateTime.now().toString());
        final carStorageRef =
            FirebaseStorage.instance.ref('Subaru/${carRef.id}');
        final uploadTask = carStorageRef.putData(combinedBytes);
        final snapshot = await uploadTask;
        final carData = {
          "email": email,
          'brand': selectedcarBrand,
          'model': modelController.text.trim(),
          'fuelType': selectedcarFuelType,
          'phoneNumber': numberController.text.trim(),
          "mileage": mileageController.text.trim(),
          "year": yearController.text.trim(),
          "transmission": transmissioController.text.trim(),
          'location': selectedLocation,
          'price': sellingPriceController.text.trim(),
          'images': [snapshot.ref.fullPath],
          'createdAt': DateTime.now(),
        };
        await carRef.set(carData);
      } else if (selectedcarBrand == "Suzuki") {
        Uint8List combinedBytes = Uint8List(0);
        for (XFile image in imagesList) {
          List<int> bytes = await image.readAsBytes();
          combinedBytes = Uint8List.fromList([...combinedBytes, ...bytes]);
        }

        final carRef = FirebaseFirestore.instance
            .collection('CARS')
            .doc('carsId')
            .collection('Suzuki')
            .doc(DateTime.now().toString());
        final carStorageRef =
            FirebaseStorage.instance.ref('Suzuki/${carRef.id}');
        final uploadTask = carStorageRef.putData(combinedBytes);
        final snapshot = await uploadTask;
        final carData = {
          "email": email,
          'brand': selectedcarBrand,
          'model': modelController.text.trim(),
          'fuelType': selectedcarFuelType,
          'phoneNumber': numberController.text.trim(),
          "mileage": mileageController.text.trim(),
          "year": yearController.text.trim(),
          "transmission": transmissioController.text.trim(),
          'location': selectedLocation,
          'price': sellingPriceController.text.trim(),
          'images': [snapshot.ref.fullPath],
          'createdAt': DateTime.now(),
        };
        await carRef.set(carData);
      } else if (selectedcarBrand == "Toyota") {
        Uint8List combinedBytes = Uint8List(0);
        for (XFile image in imagesList) {
          List<int> bytes = await image.readAsBytes();
          combinedBytes = Uint8List.fromList([...combinedBytes, ...bytes]);
        }

        final carRef = FirebaseFirestore.instance
            .collection('CARS')
            .doc('carsId')
            .collection('Toyota')
            .doc(DateTime.now().toString());
        final carStorageRef =
            FirebaseStorage.instance.ref('Toyota/${carRef.id}');
        final uploadTask = carStorageRef.putData(combinedBytes);
        final snapshot = await uploadTask;
        final carData = {
          "email": email,
          'brand': selectedcarBrand,
          'model': modelController.text.trim(),
          'fuelType': selectedcarFuelType,
          'phoneNumber': numberController.text.trim(),
          "mileage": mileageController.text.trim(),
          "year": yearController.text.trim(),
          "transmission": transmissioController.text.trim(),
          'location': selectedLocation,
          'price': sellingPriceController.text.trim(),
          'images': [snapshot.ref.fullPath],
          'createdAt': DateTime.now(),
        };
        await carRef.set(carData);
      } else if (selectedcarBrand == "Volkswagen") {
        Uint8List combinedBytes = Uint8List(0);
        for (XFile image in imagesList) {
          List<int> bytes = await image.readAsBytes();
          combinedBytes = Uint8List.fromList([...combinedBytes, ...bytes]);
        }

        final carRef = FirebaseFirestore.instance
            .collection('CARS')
            .doc('carsId')
            .collection('Volkswagen')
            .doc(DateTime.now().toString());
        final carStorageRef =
            FirebaseStorage.instance.ref('Volkswagen/${carRef.id}');
        final uploadTask = carStorageRef.putData(combinedBytes);
        final snapshot = await uploadTask;

        final carData = {
          "email": email,
          'brand': selectedcarBrand,
          'model': modelController.text.trim(),
          'fuelType': selectedcarFuelType,
          'phoneNumber': numberController.text.trim(),
          "mileage": mileageController.text.trim(),
          "year": yearController.text.trim(),
          "transmission": transmissioController.text.trim(),
          'location': selectedLocation,
          'price': sellingPriceController.text.trim(),
          'images': [snapshot.ref.fullPath],
          'createdAt': DateTime.now(),
        };
        await carRef.set(carData);
      } else if (selectedcarBrand == "Volvo") {
        Uint8List combinedBytes = Uint8List(0);
        for (XFile image in imagesList) {
          List<int> bytes = await image.readAsBytes();
          combinedBytes = Uint8List.fromList([...combinedBytes, ...bytes]);
        }

        final carRef = FirebaseFirestore.instance
            .collection('CARS')
            .doc('carsId')
            .collection('Volvo')
            .doc(DateTime.now().toString());
        final carStorageReference =
            FirebaseStorage.instance.ref('Volvo/${carRef.id}');
        final uploadTask = carStorageReference.putData(combinedBytes);
        final uploadTaskSnapshot = await uploadTask;

        final carData = {
          "email": email,
          'brand': selectedcarBrand,
          'model': modelController.text.trim(),
          'fuelType': selectedcarFuelType,
          'phoneNumber': numberController.text.trim(),
          "mileage": mileageController.text.trim(),
          "year": yearController.text.trim(),
          "transmission": transmissioController.text.trim(),
          'location': selectedLocation,
          'price': sellingPriceController.text.trim(),
          'images': [uploadTaskSnapshot.ref.fullPath],
          'createdAt': DateTime.now(),
        };
        await carRef.set(carData);
      }
      setState(() {
        selectedcarFuelType = "Petrol";
        selectedcarBrand = 'Audi';
        selectedLocation = 'Nairobi';
        imagesList = [];
        selectedImageNames = [];
        modelController.clear();
        transmissioController.clear();
        yearController.clear();
        mileageController.clear();
        numberController.clear();
        sellingPriceController.clear();
      });

      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Car uploaded successfully!",
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          backgroundColor: Colors.green,
        ),
      );
    } on FirebaseException catch (e) {
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
    }
  }
}

class ThousandsFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String formatted = _format(newValue.text);
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }

  String _format(String value) {
    int parsed = int.tryParse(value.replaceAll(',', '')) ?? 0;
    return NumberFormat("#,###").format(parsed);
  }
}

class _PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length > 10) {
      return TextEditingValue(
        text: newValue.text.substring(0, 10),
        selection: newValue.selection,
        composing: TextRange.empty,
      );
    } else {
      return newValue;
    }
  }
}
