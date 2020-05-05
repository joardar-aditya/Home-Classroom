import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/chat/chat_details.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Groups.dart';
import 'chat_details_group.dart';

class chat_group extends StatefulWidget {
  bool search_text = false;
  String text = "";
  chat_group(this.search_text, this.text);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _stateGroup(search_text, text);
  }

}

class _stateGroup extends State<chat_group> {
  List<Groups> list = [];
  final ins = FirebaseDatabase.instance;
  bool search_text = false;
  String text = "";
  _stateGroup(this.search_text, this.text);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getGroups();


  }

  void getGroups() async {
    setState(() {
      list = [];
    });
    ins.setPersistenceEnabled(true);
    final ref = ins.reference();
    print("was called");
    List<Groups> g = [];
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String teacher = preferences.getString("tcode");
    String school = preferences.getString("icode");
    ref.child('students/${teacher}_${school}/contacts/groups').once().then((element) {
      DataSnapshot snapshot = element;
      List value = element.value;
      for(int i=0; i<value.length; i++) {
        Groups groups = new Groups();
        groups.ChangeId(value[i].toString());
        ref.child('Groups/${value[i].toString()}/').once().then((element) {
          Map snap = element.value;
          List members = snap["members_string"];
          for(int j=0; j<members.length; j++) {
            groups.MembersAdd(members[j].toString());
          }
          String na = snap["name"];
          print(na);
          groups.ChangeName(na);
          String ic = snap["icon"];
          groups.AddIcon(ic);
          g.add(groups);
          setState(() {
            list = g;
          });
        }).then((result) => {
          print("completed")
        });



      }

    });

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: list.length,
       itemBuilder: (context, ind) {
         return (!search_text)?InkWell(
             onTap: ()  {
               Navigator.push(context,MaterialPageRoute(builder: (context) => chat_details_group(list[ind])));
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
                 child: (list[ind].icon == null)?null:Image(fit:BoxFit.cover,image:NetworkImage(list[ind].icon)),
               ),
               Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 mainAxisAlignment: MainAxisAlignment.center,
                 mainAxisSize: MainAxisSize.min,
                 children: <Widget>[
                   Text(list[ind].name, style: TextStyle(color: Colors.black,fontSize: 22, fontWeight: FontWeight.bold),),
                 ],
               )
             ],
           ),
         )):(list[ind].name.toLowerCase().startsWith(text.toLowerCase()))?InkWell(
             onTap: ()  {
               Navigator.push(context,MaterialPageRoute(builder: (context) => chat_details_group(list[ind])));
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
                     child: (list[ind].icon == null)?null:Image(fit:BoxFit.cover,image:NetworkImage(list[ind].icon)),
                   ),
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     mainAxisAlignment: MainAxisAlignment.center,
                     mainAxisSize: MainAxisSize.min,
                     children: <Widget>[
                       Text(list[ind].name, style: TextStyle(color: Colors.black,fontSize: 22, fontWeight: FontWeight.bold),),
                     ],
                   )
                 ],
               ),
             )):Container();
       },
    );
  }

}