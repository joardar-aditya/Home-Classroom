import 'package:flutter/material.dart';
import 'package:flutterapp/Color/colors.dart';


class appbar_sab extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return AppBar(
      leading: RaisedButton(color:Colors.white, elevation:0.0, onPressed:() {Navigator.pop(context);},child:Image(image:AssetImage('assets/back.png'), height: 50,) ),
      title: Text('Exam & Scores', style: TextStyle(color:Colors_pack.color, fontWeight: FontWeight.w700, fontSize: 28),),
      elevation: 0.0,
    );
  }

}