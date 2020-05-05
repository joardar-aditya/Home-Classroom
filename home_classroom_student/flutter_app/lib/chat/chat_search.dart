import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Color/colors.dart';

import '../title_container.dart';

class chat_search extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _stateSearch();

}

class _stateSearch extends State<chat_search> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
       appBar: AppBar(
         elevation: 0.0,
         leading: RaisedButton(color:Colors.white, elevation:0.0, onPressed:() {Navigator.pop(context);},child:Image(image:AssetImage('assets/back.png'), height: 50,) ),
         title: Text('Search', style: TextStyle(color:Colors_pack.color, fontWeight: FontWeight.w700, fontSize: 28),),
       ),
      body:ListView.builder(
        itemBuilder: (context, ind) {
          return Container(

          );
        },

    ));
  }

}