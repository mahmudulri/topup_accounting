import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenWidth,
      width: screenWidth - 80,
      child: Column(children: [
        
      ],
    ),
    );
  }
}
