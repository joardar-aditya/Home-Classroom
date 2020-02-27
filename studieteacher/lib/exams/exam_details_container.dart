import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studieteacher/colors/colors.dart';


class exam_details_container extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.all(10),
      child: FittedBox(fit
          : BoxFit.contain,child:RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onPressed: () {},
        color: Colors.grey[300],
        disabledColor: Colors.grey[300],
        child: Column(
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(margin: EdgeInsets.all(10),
                child:Text('Class Test 001', style: TextStyle(color: Colors.pinkAccent, fontSize: 20),)),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.pinkAccent,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Center(child: Text('1 JAN MON 2020', style: TextStyle(color:Colors.white),),),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Flexible(fit:FlexFit.loose,child:
                Container(margin: EdgeInsets.only(right:10, top:10, bottom: 10),
                    child:Text('Sujoy Dutta', textAlign:TextAlign.left,style: TextStyle(color: Colors.pinkAccent, fontSize: 18, fontWeight: FontWeight.bold),)),
                ),Flexible(fit:FlexFit.loose,child:Container(
                  child: Text('Mathematics',textAlign: TextAlign.right, style: TextStyle(color:Colors.pinkAccent, fontSize: 18,fontWeight: FontWeight.bold),),),
                )
              ],
            ),

          ],
        ),
      ),
    ));
  }
}