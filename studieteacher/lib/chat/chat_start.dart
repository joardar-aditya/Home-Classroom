import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studieteacher/chat/Senders.dart';
import 'package:studieteacher/chat/chat_details.dart';
import 'package:studieteacher/chat/chat_part.dart';
import 'package:studieteacher/chat/chat_search.dart';
import 'package:studieteacher/colors/colors.dart';
import 'package:studieteacher/models/chat_model.dart';
import 'package:studieteacher/starting.dart';

class chat_start extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _stateChat();

}

class _stateChat extends State<chat_start> {
  static List<String> _list = ["All", "Student", "Parents", "Groups"];
  var current_pressed = _list[0];
  List<Senders> contacts_students = [];

  final ins = FirebaseDatabase.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDatabase();

  }

  void getDatabase() async{
    final ref = ins.reference();
    var data = await ref.child("/teacher/a101001_a101/contacts/students/").once();
    Map data_m = data.value;
    List<Senders> current = [];
    for(int i=0; i<data_m.keys.toList().length; i++){
      current.add(Senders(data_m.keys.toList()[i],data_m[data_m.keys.toList()[i]]["name"],data_m[data_m.keys.toList()[i]]["class"].toString() , data_m[data_m.keys.toList()[i]]["section"]));
    }
    setState(() {
      contacts_students = current;
    });

    print(contacts_students);

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar:  AppBar(
        elevation: 0.0,
        leading: RaisedButton(color:Colors.white, elevation:0.0, onPressed:() {Navigator.pop(context);},child:Image(image:AssetImage('assets/back.png'), height: 50,) ),
        title: Text('New Chat', style: TextStyle(color:Colors_pack.color, fontWeight: FontWeight.w700, fontSize: 28),),
        actions: <Widget>[Container(margin:EdgeInsets.all(5),child:RaisedButton(shape:CircleBorder(side: BorderSide.none),color:Colors_pack.color, elevation:0.0, onPressed:() {Navigator.push(context, MaterialPageRoute(builder: (context) => chat_search()));},child:Icon(Icons.search,size: 30,color: Colors.white,)))],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              child:RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder:(context) => chat_search() ));
            },
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color:Colors_pack.color,
            disabledColor: Colors_pack.color,
            child: Row(
               mainAxisSize: MainAxisSize.min,
              children: <Widget>[Icon(Icons.add, color: Colors.white,size: 20,),
                InkWell(onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => chat_part()));},child:Container(margin: EdgeInsets.symmetric(horizontal:5),child:
                Text('Start New Group', style: TextStyle(color: Colors.white, fontSize: 20),),))],
            ),
          )),
          Container(
              height: 50,
              child:ListView.builder(
                shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            itemBuilder: (context, ind) {

              return InkWell(
                  onTap: () {
                    setState(() {
                      current_pressed = _list[ind];
                    });
                  },
                  child:Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: (current_pressed == _list[ind])?Colors_pack.color:Colors.grey,
                ),
                child:Center(child: Text(_list[ind], style: TextStyle(fontSize:24,
                    color:(current_pressed == _list[ind])?Colors.white:Colors.black,fontWeight: FontWeight.bold),)),
              ));
            },
          )),
    InkWell(
    onTap: () {
    Navigator.push(context, MaterialPageRoute(builder: (context) => chat_details(null)));
    },
    child:Container(
    margin: EdgeInsets.all(10),
    child: Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
    Container(
    height:70,
    width: 70,
    margin: EdgeInsets.all(10),
    decoration: BoxDecoration(
    shape: BoxShape.circle,
    color: Colors.pinkAccent
    ),
    ),
    Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
    Text("Anonymous", style: TextStyle(color: Colors.black,fontSize: 22, fontWeight: FontWeight.bold),),
    Text("students", style:TextStyle(color:Colors.black, fontSize: 18))
    ],
    )
    ],
    ),
    )),
          Consumer<chat_model>(builder:(context, model, child){ return Container(
            margin: EdgeInsets.only(top:20),
            child: (model.students.isEmpty)?Container(child: Container(child: CircularProgressIndicator(),),):ListView.builder(shrinkWrap:true, physics:NeverScrollableScrollPhysics(),itemCount:contacts_students.length,itemBuilder: (context, ind) {
              return InkWell(
                  onTap: () {
                   Navigator.push(context, MaterialPageRoute(builder: (context) => chat_details(model.students[ind])));
              },
                  child:Container(
                margin: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height:70,
                      width: 70,
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.pinkAccent
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(model.students[ind].Name, style: TextStyle(color: Colors.black,fontSize: 22, fontWeight: FontWeight.bold),),
                        Text("Class " + model.students[ind].Class + " Sec " + model.students[ind].section, style:TextStyle(color:Colors.black, fontSize: 18))
                      ],
                    )
                  ],
                ),
              ));
            }),
          );})
        ],
      ),
    );
  }

}