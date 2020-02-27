import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studieteacher/colors/colors.dart';


class exam_past_container extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.all(10),
      child: FittedBox(fit
          : BoxFit.contain,child:RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onPressed: () {},
        color: Colors.pinkAccent,
        disabledColor: Colors.pinkAccent,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(margin: EdgeInsets.all(10),
                child:Text('Class Test 001', style: TextStyle(color: Colors.white, fontSize: 20),)),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Center(child: Text('1 JAN MON 2020', style: TextStyle(color:Colors_pack.color),),),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(margin: EdgeInsets.all(10),
                    child:Text('Sujoy Dutta', textAlign:TextAlign.left,style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),)),
                Container(
                  child: Center(child: Text('Mathematics',textAlign: TextAlign.right, style: TextStyle(color:Colors.white, fontSize: 18,fontWeight: FontWeight.bold),),),
                )
              ],
            ),

          ],
        ),
      ),
    ));
  }
}