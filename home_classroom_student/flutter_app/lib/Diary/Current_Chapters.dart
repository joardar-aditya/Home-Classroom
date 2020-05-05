import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Chapters/chapters_details.dart';
import 'package:flutterapp/Color/colors.dart';
import 'package:flutterapp/model/Chapter.dart';
import 'package:flutterapp/model/main_model.dart';
import 'package:provider/provider.dart';



class Chapter_current extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          leading: RaisedButton(color:Colors.white, elevation:0.0, onPressed:() {Navigator.pop(context);},child:Image(image:AssetImage('assets/back.png'), height: 50,) ),
          title: Text('Current Chapters', style: TextStyle(color: Colors_pack.color, fontWeight: FontWeight.w700, fontSize: 28),),
        ),
        body:Consumer<main_model>(builder: (context, model, child) { return (model.currentChapters.length == 0)?Container(child: Center(child: Text("No Chapter going on currently"),),):ListView.builder(
      itemCount: model.currentChapters.length,
      itemBuilder: (context, ind) {
        return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => chapters_details(model.currentChapters[ind])));
            },
            child:Container(
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(color: Colors_pack.color, borderRadius: BorderRadius.circular(20)),
          child: Text(
            model.currentChapters[ind].Name, style: TextStyle(color: Colors.white, fontSize: 30),
          ),
        ));
      },


    );}));
  }

}