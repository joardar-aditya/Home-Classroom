
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studieteacher/colors/colors.dart';

class container_check extends StatelessWidget {
  var name;
  var classes;
  var section;
  var subject;

  container_check(this.name, this.classes, this.section, this.subject);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors_pack.color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
            Container(
              margin: EdgeInsets.all(20),
              child: Text('$name',textAlign: TextAlign.left, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),),
            ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  margin:EdgeInsets.only(left: 5),
                  child: Text('Class', textAlign: TextAlign.left,style: TextStyle(color: Colors.grey[300], fontWeight: FontWeight.bold, fontSize: 20),),
                ),
                Container(
                  child: Text('$classes', textAlign: TextAlign.left,style: TextStyle(color: Colors.grey[100], fontWeight: FontWeight.bold, fontSize: 20),),
                ),
                Container(
                  margin:EdgeInsets.only(left: 5),
                  child: Text('Sec', textAlign: TextAlign.left,style: TextStyle(color: Colors.grey[300], fontWeight: FontWeight.bold, fontSize: 20),),
                ),
                Container(
                  child: Text('$section', textAlign: TextAlign.left,style: TextStyle(color: Colors.grey[100], fontWeight: FontWeight.bold, fontSize: 20),),
                ),
                Container(
                  margin:EdgeInsets.symmetric(horizontal: 5),
                  child: Text('$subject', textAlign: TextAlign.right,style: TextStyle(color: Colors.grey[300], fontWeight: FontWeight.bold, fontSize: 20),),
                )
              ],
            ),
          )
        ],
      ),


    );
  }


}

