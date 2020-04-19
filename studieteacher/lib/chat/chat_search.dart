import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studieteacher/colors/colors.dart';
import 'package:studieteacher/title_container.dart';

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
         title: Text('New group', style: TextStyle(color:Colors_pack.color, fontWeight: FontWeight.w700, fontSize: 28),),
       ),
      body:ListView(
        children: <Widget>[
          title_container('Add a group title and icon'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              RaisedButton(
                onPressed: () {},
                shape: CircleBorder(side: BorderSide.none),
                color: Colors.grey[200],
                child: Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:Colors_pack.color,
                  ),
                  child: Icon(Icons.add, color: Colors.white, size: 30,),
                ),
              ),
              Container(
                width: 300,
                margin: EdgeInsets.all(10),
                child: TextField(decoration: InputDecoration(
                    hintStyle: TextStyle(color:Colors.pinkAccent, fontSize: 22),
                    hintText: "Add a title",
                    filled: true,
                    fillColor: Colors.grey[300],
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none)
                ),),
              ),
            ],
          ),
          Column(
          children: <Widget>[
              RaisedButton(
              onPressed: () {
                Navigator.pop(context);
              },
                color: Colors_pack.color,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Container(
                  color: Colors_pack.color,
                  padding: EdgeInsets.all(10),
                  child: Text('Done', style: TextStyle(color:Colors.grey[300],fontSize: 24, fontWeight: FontWeight.bold),),
                ),
              ),

          ],


    ) ,
          Container(
              margin: EdgeInsets.all(20),
              child:
          RichText(text: TextSpan(style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),children: [
            TextSpan(text: "0", style: TextStyle(color: Colors_pack.color)),
            TextSpan(text: " Participants", style: TextStyle(color: Colors.black))

          ])))
        ]

    ));
  }

}