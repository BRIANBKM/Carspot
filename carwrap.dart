import 'package:flutter/material.dart';

class CarWrap extends StatefulWidget {
  const CarWrap({Key? key}) : super(key: key);

  @override
  State<CarWrap> createState() => _CarWrapState();
}

class _CarWrapState extends State<CarWrap> {
  late double screenHeight = 0;
  late double screenWidth = 0;
  late Color _carColor = Colors.black;
  Color filteredColor = Colors.red;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Align(
        alignment: Alignment.topCenter,
        child: Container(
          height: screenHeight / 2,
          width: screenWidth / 1.1,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: _carColor,
            // image: const DecorationImage(
            //   image: NetworkImage(
            //       "https://images.vexels.com/media/users/3/154251/isolated/preview/fef0c563c39f2746c35604e969ffe3ef-bmw-car-front-view-silhouette-by-vexels.png"),
            //   fit: BoxFit.contain,
            // ),
          ),
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(filteredColor, BlendMode.srcIn),
            child: Image.asset(
              "assets/wrp.png",
              width: 170,
              height: 300,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _carColor = Colors.red;
          });
        },
        child: const Icon(Icons.color_lens),
      ),
    );
  }
}
