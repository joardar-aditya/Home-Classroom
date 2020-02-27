import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class attendance_name_container extends StatelessWidget{

  var name;
  var index;
  var bool = false;
  attendance_name_container(this.name, this.index,this.bool );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: bool?Color(0xff257FFF):Colors.grey,
            borderRadius: BorderRadius.circular(5)
        ),padding: EdgeInsets.only(left:10, top:10, bottom: 10),
      child:Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
         Container(padding:EdgeInsets.only(right: 10),child: Text('$index.', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
         ),Image(image: AssetImage("assets/ellipse-2.png"),width: 30,height: 30),
          Container(padding:EdgeInsets.only(left:10), child:Text('$name', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
          )
        ],
      )

    );
  }


}