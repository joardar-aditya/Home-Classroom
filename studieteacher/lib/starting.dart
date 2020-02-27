import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studieteacher/Homework/homework.dart';
import 'package:studieteacher/exams/exams_start.dart';
import 'package:studieteacher/intro_button.dart';
import 'package:studieteacher/attendance.dart';


class starting extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _startingState();


}

class _startingState extends State<starting> {

  var name= "Aditya Jordan";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
         bottomNavigationBar: Image.asset("assets/Group16.png"),
         appBar: AppBar(
           elevation: 0.0,
           leading:  Builder(
             builder: (BuildContext context) {
               return IconButton(
                 icon: Image(image:AssetImage('assets/Group28.png')),
                 onPressed: () { Scaffold.of(context).openDrawer(); },
                 tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
               );
             },
           ),
           actions: <Widget>[IconButton(icon: Image(image:AssetImage('assets/Group27.png')),),
             IconButton(icon: Image(image:AssetImage('assets/Group25.png')),)],
         ),
         body:Column(
           children:<Widget>[Expanded(
             flex:3, child: Container(
                margin: EdgeInsets.all(20),
                child: Container(
                  decoration: BoxDecoration(color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Expanded(flex:1,child:Padding(padding:EdgeInsets.all(5), child: Image.asset("assets/ellipse-2.png")),),
                      Expanded(flex:3,child:Padding(padding:EdgeInsets.all(5),child:Align(alignment:Alignment.centerLeft,child:RichText(text: TextSpan(
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 36,
                          fontWeight: FontWeight.bold
                        ),
                        children: [TextSpan(text: name + "\n" ),
                        TextSpan(text:'Teacher', style: TextStyle(fontWeight: FontWeight.normal, fontSize:24 ))]
                      ))))),
                    ],
                    
                  ),
                ),

           ),
           ),
           Expanded(flex:3,child: Container(child:
             Center(
               child: RichText(
                 textAlign: TextAlign.center,
                   text: TextSpan(
                       style: TextStyle(
                           color: Colors.black,
                           fontSize: 50,
                           fontWeight: FontWeight.bold),
                       children: <TextSpan>[
                         TextSpan(text: 'Hey Teacher,\n'),
                         TextSpan(
                             text: 'What do you want to follow?', style: TextStyle(fontWeight:FontWeight.normal, fontSize: 24)),
                       ])),
             ),)),
             Expanded(flex: 6,child:Container(child:
             Row(
               mainAxisSize: MainAxisSize.min,
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               crossAxisAlignment: CrossAxisAlignment.stretch,
               children: <Widget>[
                 Expanded(child:
                 Column(
                   crossAxisAlignment: CrossAxisAlignment.center,
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   mainAxisSize: MainAxisSize.max,
                   children: <Widget>[
                     Flexible(child:RaisedButton(
                         child:
                     intro_button("assets/attendance.png", "Attendance"),
                     onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => attendance()));},
                     color: Colors.white,
                     disabledColor: Colors.white,splashColor: Colors.blue,)),
                     Flexible(child:RaisedButton(
                           child: intro_button("assets/Group10.png", "Quiz"),
                           onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => attendance()));},
                           color: Colors.white, disabledColor: Colors.white,splashColor: Colors.blue,)),
                     Flexible(child:RaisedButton(
                       elevation: 0.0,
                       child:
                       intro_button("assets/exams.png", "Exam Scores"),
                       onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => exam_start()));},
                       color: Colors.white,
                       disabledColor: Colors.white,splashColor: Colors.blue,)),
                   ])),
                 Expanded(child:
                 Column(
                     crossAxisAlignment: CrossAxisAlignment.center,
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     mainAxisSize: MainAxisSize.max,
                     children: <Widget>[
                 Flexible(child:RaisedButton(
                     child:
                     intro_button("assets/homework.png", "Homework"),
                   onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => homework()));},
                   color: Colors.white,
                   disabledColor: Colors.white,splashColor: Colors.blue,)),
                       Flexible(child:RaisedButton(
                         elevation: 0.0,
                         child:
                         intro_button("assets/performance.png", "Performance"),
                         onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => attendance()));},
                         color: Colors.white,
                         disabledColor: Colors.white,splashColor: Colors.blue,)),
                       Flexible(child:RaisedButton(
                         elevation: 0.0,
                         child:
                         intro_button("assets/documents.png", "Documents"),
                         onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => attendance()));},
                         color: Colors.white,
                         disabledColor: Colors.white,splashColor: Colors.blue,)),
                     ])),
                 Expanded(child:
                 Column(
                     crossAxisAlignment: CrossAxisAlignment.center,
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     mainAxisSize: MainAxisSize.max,
                     children: <Widget>[
                       Flexible(child:RaisedButton(
                         elevation:0.0,
                         child:
                         intro_button("assets/chapters.png", "Chapters"),
                         onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => attendance()));},
                         color: Colors.white,
                         disabledColor: Colors.white,splashColor: Colors.blue,)),
                       Flexible(child:RaisedButton(
                         elevation: 0.0,
                         child:
                         intro_button("assets/report.png", "Reports"),
                         onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => attendance()));},
                         color: Colors.white,
                         disabledColor: Colors.white,splashColor: Colors.blue,)),
                       Flexible(child:RaisedButton(
                         elevation: 0.0,
                         child:
                         intro_button("assets/announce.png", "Announce"),
                         onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => attendance()));},
                         color: Colors.white,
                         disabledColor: Colors.white,splashColor: Colors.blue,)),
                     ])),
               ],
             )))
           ],
         )
    );
  }


}