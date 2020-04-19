import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Color/colors.dart';
import 'package:flutterapp/model/Homework.dart';

class homework_details extends StatefulWidget {
  Homework _c;
  homework_details(this._c);
  @override
  State<StatefulWidget> createState() => _stateEnterHw(_c);

}

class _stateEnterHw extends State<homework_details>{

  Homework _current;

  _stateEnterHw(this._current);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: RaisedButton(color:Colors.white, elevation:0.0, onPressed:() {Navigator.pop(context);},child:Image(image:AssetImage('assets/back.png'), height: 50,) ),
        title: Text('Homework', style: TextStyle(color:Colors_pack.color, fontWeight: FontWeight.w700, fontSize: 28),),
        elevation: 0.0,
      ),
      body: Container(
          margin: EdgeInsets.all(10),
          child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(margin:EdgeInsets.symmetric(horizontal: 10),child:Text('Submission Date', style: TextStyle(color:Colors.deepPurpleAccent, fontSize: 24, fontWeight: FontWeight.bold),),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(color: Colors.grey[400], borderRadius: BorderRadius.circular(10)),
                  margin: EdgeInsets.symmetric(horizontal:10),
                  child:Text(_current.Date.day.toString()+" "+_current.Date.month.toString()+" "+_current.Date.year.toString(), style: TextStyle(color:Colors_pack.color, fontSize: 18,),)
                )
              ],
            ),
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color:Colors_pack.color,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child:Text(_current.Title, style: TextStyle(color:Colors.white, fontWeight: FontWeight.bold, fontSize: 32),)
                    ,margin:EdgeInsets.symmetric(vertical:10),
                  ),
                  Container(
                      margin:EdgeInsets.symmetric(vertical:10),
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(_current.Author, style: TextStyle(color:Colors.white, fontSize: 22),),
                          Text(_current.Subject, style: TextStyle(color: Colors.white, fontSize: 22),),
                        ],
                      )
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Text('Solve the given problems', style: TextStyle(color:Colors_pack.color, fontSize: 32),),
            ),
            Container(
                margin: EdgeInsets.all(10),
                child:Text(_current.description, style: TextStyle(color:Colors.grey, fontSize: 24),))
            ,Container(
              margin: EdgeInsets.all(10),
              child: Text('Attached File', style: TextStyle(color:Colors.black, fontSize: 24),),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: RaisedButton(onPressed: () {},
              shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('1026.pdf'),
                    Icon(Icons.arrow_downward, color: Colors_pack.color, size: 30,)
                  ],
                ),
              ),),

            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Text('Attached Photo', style: TextStyle(color:Colors.black, fontSize: 24),),
            ),
            Expanded(child:Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color:Colors.grey[300],
                borderRadius: BorderRadius.circular(10)
              ),
              margin: EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('1026.pdf'),
                  Icon(Icons.arrow_downward, color: Colors_pack.color, size: 30,)
                ],
              ),
            ))


          ],
        )
      ),
    );
  }

}