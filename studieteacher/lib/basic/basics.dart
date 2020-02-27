import 'package:flutter/material.dart';
import 'package:studieteacher/colors/colors.dart';

class basics extends StatelessWidget{


  var title ;

  basics(this.title);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text('$title', style: TextStyle(color: Colors_pack.color, fontWeight: FontWeight.bold, fontSize: 24 ));
  }
}