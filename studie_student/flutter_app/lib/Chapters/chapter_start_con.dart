import 'package:flutter/material.dart';
import 'package:flutterapp/Chapters/chapters_details.dart';
import 'package:flutterapp/Color/colors.dart';
import 'package:flutterapp/model/Chapter.dart';




class chapter_start_con extends StatefulWidget {
  Chapter _c;
  chapter_start_con(this._c);
  @override
  State<StatefulWidget> createState() => _stateChapter(_c);


}

class _stateChapter extends State<chapter_start_con> {

  var pressed = false;
  Chapter _c;
  _stateChapter(this._c);

  @override
  Widget build(BuildContext context) {


    return InkWell(
        onDoubleTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => chapters_details(_c)));
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
            child:Text(_c.Name, style: TextStyle(color:Colors.white, fontWeight: FontWeight.bold, fontSize: 28),),
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
                        TextSpan(text:_c.Started, style: TextStyle(color:Colors_pack.color))
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
                          TextSpan(text:_c.Ended, style: TextStyle(color:Colors_pack.color))
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