import 'package:flutter/material.dart';
import 'package:studieteacher/colors/colors.dart';

import 'Chapter.dart';
import 'chapters_details.dart';



class chapter_start_con extends StatefulWidget {

  Chapter current;
  chapter_start_con(this.current);
  @override
  State<StatefulWidget> createState() => _stateChapter(current);


}

class _stateChapter extends State<chapter_start_con> {

  var pressed = false;
  Chapter current;

  _stateChapter(this.current);

  @override
  Widget build(BuildContext context) {


    return InkWell(
        onDoubleTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => chapters_details(current)));
        },
        onTap:() {setState(() {
      if(pressed){
        pressed = false;
      }else{
        pressed = true;
      }
    });},child:Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(

            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color:pressed?Colors.pinkAccent:Colors_pack.color,

            ),
            margin: EdgeInsets.all(10),
            child:Text(current.Name, style: TextStyle(color:Colors.white, fontWeight: FontWeight.bold, fontSize: 28),),
          ),
          pressed?Container(
            margin:EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(color:Colors.grey[400], fontSize: 20, fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(text:'Started on '),
                        TextSpan(text:current.started, style: TextStyle(color:Colors_pack.color))
                      ]
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: RichText(
                    text: TextSpan(
                        style: TextStyle(color:Colors.grey[400], fontSize: 20, fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(text:'Ended on '),
                          TextSpan(text:current.Ended, style: TextStyle(color:Colors_pack.color))
                        ]
                    ),
                  ),
                )
              ],
            ),
          ):Container(),

        ],
      ),
    ));
  }

}