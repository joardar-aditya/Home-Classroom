import 'package:flutter/material.dart';
import 'package:studieteacher/basic/basics.dart';
import 'package:studieteacher/colors/colors.dart';

class add_question extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _stateAdd_ques();



}

class _stateAdd_ques extends State<add_question> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar:AppBar(
        title: basics("Add Questions"),
        elevation: 0.0,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            child: Text('Select the time limit', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Text('00 M 00 S', style: TextStyle(color: Colors_pack.color, fontWeight: FontWeight.bold, fontSize: 27),),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Text('Select the time limit', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),),
          )
        ],
      ),
    );
  }

}