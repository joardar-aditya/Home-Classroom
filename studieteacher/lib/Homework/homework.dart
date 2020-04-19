import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studieteacher/Homework/assign.dart';
import 'package:studieteacher/Homework/check.dart';
import 'package:studieteacher/basic/basics.dart';
import 'package:studieteacher/colors/colors.dart';
import 'package:studieteacher/containers/assign_button.dart';
import 'package:studieteacher/models/hw_model.dart';
import 'package:http/http.dart' as http;

import 'hw.dart';



class homework extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _stateHomework();

}

class _stateHomework extends State<homework> {

   bool _assign = true;

   @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }


  void changeState(value) {
    setState(() {
      _assign = value;
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar:  AppBar(
        elevation: 0.0,
        leading: RaisedButton(color:Colors.white, elevation:0.0, onPressed:() {Navigator.pop(context);},child:Image(image:AssetImage('assets/back.png'), height: 50,) ),
        title: Text('Homework', style: TextStyle(color:Colors_pack.color, fontWeight: FontWeight.w700, fontSize: 28),),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FittedBox(
                  fit: BoxFit.contain,
                  child:RaisedButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      color:_assign?Colors_pack.color:Colors.grey,onPressed:() { changeState(true);},child:
                  Padding(padding: EdgeInsets.all(5), child: Text('Assign', style: TextStyle(color:_assign?Colors.white:Colors.black, fontWeight: FontWeight.bold),)))),
                FittedBox(
                    fit: BoxFit.contain,
                    child:RaisedButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        color:!_assign?Colors_pack.color:Colors.grey,onPressed:() {changeState(false);},child:
                    Padding(padding: EdgeInsets.all(5), child: Text('Check', style: TextStyle(color: !_assign?Colors.white:Colors.black, fontWeight: FontWeight.bold),)))
                )],
            ),


          ),
          Expanded(
            flex:12,
            child: _assign?assign():Consumer<hw_model>(builder:(context,model,child){
              return check(model);}),
            ),

        ],
      ),
    );
  }



}