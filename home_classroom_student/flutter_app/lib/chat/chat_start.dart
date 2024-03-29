import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Color/colors.dart';
import 'package:flutterapp/chat/chat_Group.dart';
import 'package:flutterapp/model/main_model.dart';
import 'package:provider/provider.dart';
import 'Senders.dart';
import 'chat_details.dart';
import 'chat_part.dart';
import 'chat_search.dart';
import 'package:flutterapp/starting.dart';

class chat_start extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _stateChat();

}

class _stateChat extends State<chat_start> {
  static List<String> _list = ["Teachers", "Groups"];
  var current_pressed = _list[0];
  List<Senders> contacts_students = [];
  bool search = false;

  final ins = FirebaseDatabase.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero,() {showDialog(context: context, builder: (context) {
      return new SimpleDialog(backgroundColor:Colors_pack.color,children: <Widget>[new Center(child: new Container(padding:EdgeInsets.all(20),child: new Text("We care for your privacy:\n"
          "The chat feature is available only for faster doubt solving and communication with students and teachers.\n"
          "The messages may not be end to end encrypted, Therefore donot share any personal info like id numbers/ account details/ password during "
          "the chat", style: TextStyle(color: Colors.white, fontSize: 18),)))]);
    });});


  }
  TextEditingController controller = TextEditingController();
  bool groups = false;
  bool search_text = false;
  String text = "";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar:  AppBar(
        elevation: 0.0,
        leading: RaisedButton(color:Colors.white, elevation:0.0, onPressed:() {Navigator.pop(context);},child:Image(image:AssetImage('assets/back.png'), height: 50,) ),
        title: Text('New Chat', style: TextStyle(color:Colors_pack.color, fontWeight: FontWeight.w700, fontSize: 28),),
        actions: <Widget>[
          Container(margin:EdgeInsets.all(5),child:
          RaisedButton(shape:CircleBorder(side: BorderSide.none),color:Colors_pack.color, elevation:0.0,
              onPressed:() {
            setState(() {
              search = !search;
              controller.clear();
              search_text = false;
            });
              },
              child:Icon(Icons.search,size: 30,color: Colors.white,)))],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          (search)?Container(
            padding: EdgeInsets.all(20),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                filled: true,
                suffixIcon: Container(
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors_pack.color,
                    ),
                    child:IconButton(
                  color: Colors_pack.color,
                  icon: Icon(Icons.arrow_forward, color: Colors.white,),
                  iconSize: 18,
                  onPressed: () {
                    setState(() {
                      search_text = true;
                      text = controller.text;
                      groups = false;
                      current_pressed = _list[0];

                    });
                  },
                )),
                fillColor: Colors.grey[300],
              ),
            ),
          ):Container(),
          Container(
              height: 50,
              child:ListView.builder(
                shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 2,
            itemBuilder: (context, ind) {

              return InkWell(
                  onTap: () {
                    setState(() {
                      current_pressed = _list[ind];
                      if(ind == 0){
                        groups = false;
                      }else{
                        groups = true;
                      }
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
          )), Consumer<main_model>(builder:(context, model, child) { return Container(
            margin: EdgeInsets.only(top:20),
            child: (groups)?chat_group(search_text,text):ListView.builder(shrinkWrap:true, physics:NeverScrollableScrollPhysics(),itemCount:model.Teachers_list.length,itemBuilder: (context, ind) {
              return (!search_text)?InkWell(
                  onTap: () {
                   Navigator.push(context, MaterialPageRoute(builder: (context) => chat_details(model.Teachers_list[ind])));
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
                        Text(model.Teachers_list[ind].name, style: TextStyle(color: Colors.black,fontSize: 22, fontWeight: FontWeight.bold),),
                        Text("Teacher", style:TextStyle(color:Colors.black, fontSize: 18))
                      ],
                    )
                  ],
                ),
              )):(model.Teachers_list[ind].name.toLowerCase().startsWith(controller.text.toLowerCase()))?InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => chat_details(model.Teachers_list[ind])));
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
                            Text(model.Teachers_list[ind].name, style: TextStyle(color: Colors.black,fontSize: 22, fontWeight: FontWeight.bold),),
                            Text("Teacher", style:TextStyle(color:Colors.black, fontSize: 18))
                          ],
                        )
                      ],
                    ),
                  )):Container();
            }),
          );})
        ],
      ),
    );
  }

}