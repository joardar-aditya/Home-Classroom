import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studieteacher/Homework/hw_check_detail.dart';
import 'package:studieteacher/basic/basics.dart';
import 'package:studieteacher/colors/colors.dart';

import 'container_check.dart';

class homework_details extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _detail_hw_state();


}

class _detail_hw_state extends State<homework_details>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: basics("Homework"),
    elevation: 0.0,
    ),
      body:ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            child:  Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child:Text('Submision Date', style: TextStyle(fontSize: 22),)
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(10)
                  ),
                  
                  child: Center(
                    child: Text('1 JAN MON 2020', style: TextStyle(color: Colors.blue, fontSize: 22),),
                  ),
                )
              ],
            ),
          ),
    Container(margin:EdgeInsets.all(10),child:container_check("Trigonometry", "5", "A", "Mathematics")),
          Container(margin:EdgeInsets.all(10),child:
          Text('Solve the given problems', style: TextStyle(color: Colors_pack.color, fontSize: 24),)),
          Container(margin:EdgeInsets.all(10),child:
          Text('Decuce the sums given in the attached file and complete sums from the Exercise Book', style: TextStyle(color: Colors.black, fontSize: 22),)),
          Container(margin:EdgeInsets.all(10),child:
          Text('Attached File', style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 24),)),
          Container(margin:EdgeInsets.all(10),
           child: RaisedButton(
             color: Colors_pack.color,
             onPressed: () {},
             child:Text('1026.pdf',textAlign: TextAlign.left, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
           ),
          ),
          Container(margin:EdgeInsets.all(10),
            child: Center(child:Text('Submitted by 32 students', style: TextStyle(color: Colors.pinkAccent, fontWeight: FontWeight.bold, fontSize: 24),)),
          ),
          Column(crossAxisAlignment:CrossAxisAlignment.center,children:[
            Container(
                margin: EdgeInsets.all(10),
                width: 200,
                child:RaisedButton(onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => hw_check_detail()));},
                    color: Colors.pinkAccent,
                    disabledColor: Colors.grey,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child:Padding(padding:EdgeInsets.all(10),child:Text('Check', textAlign: TextAlign.center, style: TextStyle(fontSize:22,fontWeight:FontWeight.bold, color:Colors.white
                    )))))])


        ],
      ),
    );
  }

}