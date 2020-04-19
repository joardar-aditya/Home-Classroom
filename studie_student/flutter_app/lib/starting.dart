import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Calendar/calendar/calendar.dart';
import 'package:flutterapp/Chapters/chapters_start.dart';
import 'package:flutterapp/Color/colors.dart';
import 'package:flutterapp/Diary/diary.dart';
import 'package:flutterapp/Documents/documents.dart';
import 'package:flutterapp/Exams/exam_overview.dart';
import 'package:flutterapp/Extras/Help.dart';
import 'package:flutterapp/Performance/performance.dart';
import 'package:flutterapp/Quiz/edit_quiz.dart';
import 'package:flutterapp/Quiz/quiz.dart';
import 'package:flutterapp/attendance/attendance.dart';
import 'package:flutterapp/chat/chat_start.dart';
import 'package:flutterapp/homework/homework_start.dart';
import 'package:flutterapp/intro_button.dart';
import 'package:flutterapp/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;




class starting extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _startingState();


}

class _startingState extends State<starting> {

  var name= "NA";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStudent();
  }

  getStudent() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String c_name = sharedPreferences.getString("name");
    setState(() {
      name = c_name;
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
         bottomNavigationBar: Padding(padding:EdgeInsets.all(10),child:Image.asset("assets/Group16.png", height:70,)),
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
           actions: <Widget>[IconButton(onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => chat_start()));},icon: Image(image:AssetImage('assets/Group27.png')),),
             IconButton(icon: Image(image:AssetImage('assets/Group25.png')),)],
         ),
         drawer:
           Drawer(
             child: ListView(
               padding: EdgeInsets.zero,
               children: <Widget>[
                 DrawerHeader(
                     child: Center(
                         child: Container(
                             decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(20),
                                 color: Colors_pack.color),
                             child:Column(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               Image(
                                 image: AssetImage('assets/Group8.png'),
                                 width: 160.0,
                                 height: 40.0,
                               ),
                               Image(
                                   image: AssetImage('assets/Group5.png'),
                                   width: 160.0,
                                   height: 40.0)
                             ]))),

                 decoration: BoxDecoration(color: Colors.white),
                 ),
                 ListTile(
                   title: Text('Feedback', style: TextStyle(fontWeight:FontWeight.w900,color:Colors_pack.color, fontSize: 20),),
                   onTap: () {
                     Navigator.pop(context);
                     Navigator.push(
                         context, MaterialPageRoute(builder: (context) => starting()));
                   },
                 ),
                 ListTile(
                   title: Text('Contact',style: TextStyle(fontWeight:FontWeight.w900,color:Colors_pack.color, fontSize: 20),),
                   onTap: () {
                     Navigator.pop(context);
                   },
                 ),
                 ListTile(
                   title: Text('Help',style: TextStyle(fontWeight:FontWeight.w900,color:Colors_pack.color, fontSize: 20),),
                   onTap: () {
                     Navigator.pop(context);
                     Navigator.push(context, MaterialPageRoute(builder: (context) => Help()));

                   },
                 ),

                 Container(
                   margin: EdgeInsets.symmetric(horizontal: 20),
                   child:RaisedButton(
                       color:Colors_pack.color,
                       onPressed: () async {SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    String code = sharedPreference.getString("user");
    print(code);
    Uri uri = Uri.https("studie-server-dot-project-student-management.appspot.com", "/logout");
    var res = await http.get(uri, headers: {
    "x-access-token": code,
    "type" : "student"
    });
    if(res.statusCode == 200) {
    print(res.body);
    sharedPreference.setString("user", "");
    sharedPreference.setString("global_state", "not");
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage()));
    }else{
    print(res.statusCode);
    }


    },
                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                   child:Row(
                     children: <Widget>[
                       Icon(Icons.arrow_back,size: 24,color: Colors.white,),
                       Text('Sign Out', style: TextStyle(color:Colors.white, fontSize: 24),)
                     ],

    ))
                 ),

                 Container(
                   margin: EdgeInsets.all(20),
                   child:Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: <Widget>[
                         IconButton(
                           icon: Image(image:AssetImage('assets/twitter.png')),
                         ),
                       IconButton(
                         icon: Image(image:AssetImage('assets/fb.png')),
                       ),
                       IconButton(
                         icon: Image(image:AssetImage('assets/yt.png')),
                       ),
                       IconButton(
                         icon: Image(image:AssetImage('assets/insta.png')),
                       )
                     ],
                   )
                   ,
                 ),
                 Container(
                   margin: EdgeInsets.only(top:150),
                   child:Center(
                     child: Image(image: AssetImage("assets/drawer.png"),),
                   )
                 )



               ],
             ),

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
                        TextSpan(text:'Student', style: TextStyle(fontWeight: FontWeight.normal, fontSize:24 ))]
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
                         TextSpan(text: 'Hey Student,\n'),
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
                       elevation:0.0,
                         child:
                     intro_button("assets/attendance.png", "Attendance"),
                     onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => attendance()));},
                     color: Colors.white,
                     disabledColor: Colors.white,splashColor: Colors.blue,)),
                     Flexible(child:RaisedButton(
                           child: intro_button("assets/Group10.png", "Quiz"),
                           onPressed: () {
                             Navigator.push(context, MaterialPageRoute(builder: (context) => quiz()));
                           },
                           color: Colors.white, disabledColor: Colors.white,splashColor: Colors.blue,)),
                     Flexible(child:RaisedButton(
                       elevation: 0.0,
                       child:
                       intro_button("assets/Group4.png", "Exams"),
                       onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => examOverview()));},
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
                     intro_button("assets/homework.png", "Homework"),
                   onPressed: () {
                     Navigator.push(context, MaterialPageRoute(builder: (context) => homework_start()));},
                   color: Colors.white,
                   disabledColor: Colors.white,splashColor: Colors.blue,)),
                       Flexible(child:RaisedButton(
                         elevation: 0.0,
                         child:
                         intro_button("assets/performance.png", "Performance"),
                         onPressed: () {
                           Navigator.push(context, MaterialPageRoute(builder: (context) => performance()));
                         },
                         color: Colors.white,
                         disabledColor: Colors.white,splashColor: Colors.blue,)),
                       Flexible(child:RaisedButton(
                         elevation: 0.0,
                         child:
                         intro_button("assets/Group9.png", "Calendar"),
                         onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => calendar()));},
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
                         onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => chapter_start()));},
                         color: Colors.white,
                         disabledColor: Colors.white,splashColor: Colors.blue,)),
                       Flexible(child:RaisedButton(
                         elevation: 0.0,
                         child:
                         intro_button("assets/Group1.png", "Diary"),
                         onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => diary()));},
                         color: Colors.white,
                         disabledColor: Colors.white,splashColor: Colors.blue,)),
                       Flexible(child:RaisedButton(
                         elevation: 0.0,
                         child:
                         intro_button("assets/documents.png", "Documents"),
                         onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => documents()));},
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