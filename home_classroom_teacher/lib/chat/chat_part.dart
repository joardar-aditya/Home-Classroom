import 'package:flutter/material.dart';
import 'package:studieteacher/colors/colors.dart';
import 'package:studieteacher/title_container.dart';

class chat_part extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _stateI();

}

class _stateI extends State<chat_part> {
  static List<String> _list = ["All", "Student", "Parents", "Groups"];
  var current_pressed = _list[0];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar:  AppBar(
        elevation: 0.0,
        leading: RaisedButton(color:Colors.white, elevation:0.0, onPressed:() {Navigator.pop(context);},child:Image(image:AssetImage('assets/back.png'), height: 50,) ),
        title: Text('New group', style: TextStyle(color:Colors_pack.color, fontWeight: FontWeight.w700, fontSize: 28),),
      ),
      body: ListView(
        children: <Widget>[
          title_container("Add Participants"),
          Container(
              margin: EdgeInsets.all(10),
              child:TextField(
                decoration: InputDecoration(
                    suffixIcon: InkWell(
                        onTap: () {
                        },
                        child:Container(
                          height:25,
                          width: 25,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:Colors_pack.color,
                          ),
                          child: Center(child: Icon(Icons.search, color: Colors.white,),),
                        )
                    ),
                    filled: true,
                    fillColor: Colors.grey[300],
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none)),
              )
          ),
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
        ],
      ),
    );
  }

}