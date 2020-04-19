import 'package:flutter/material.dart';
import 'package:studieteacher/colors/colors.dart';

class splash_screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:Container(
        color: Colors_pack.color,
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('assets/Group8.png'),
                  width: 160.0,
                  height: 40.0,
                ),
                Image(
                    image: AssetImage('assets/Group5.png'),
                    width: 160.0,
                    height: 40.0)
              ]),
        ),
      )
    );
  }

}