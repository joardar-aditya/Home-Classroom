import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:studieteacher/Announce/announce.dart';
import 'package:studieteacher/Extras/privacy_policy.dart';
import 'package:studieteacher/Homework/homework.dart';
import 'package:studieteacher/chapters/chapters_details.dart';
import 'package:studieteacher/chat/chat_start.dart';
import 'package:studieteacher/colors/colors.dart';
import 'package:studieteacher/document/document.dart';
import 'package:studieteacher/exams/exams_start.dart';
import 'package:studieteacher/intro_button.dart';
import 'package:studieteacher/attendance.dart';
import 'package:studieteacher/main.dart';
import 'package:studieteacher/models/main_model.dart';
import 'package:studieteacher/performance/perf_start.dart';
import 'package:studieteacher/quiz/quizstart.dart';
import 'package:studieteacher/report/report_entry.dart';

import 'Extras/Help.dart';
import 'chapters/chapter_start.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;

import 'notifications/notifications.dart';


class starting extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _startingState();


}

class _startingState extends State<starting> {

  var name= "NA";
  GlobalKey<ScaffoldState> globalKey = new GlobalKey();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  void signout() async{
  SharedPreferences sharedPreference = await SharedPreferences.getInstance();
  String code = sharedPreference.getString("user");
  print(code);
  Uri uri = Uri.https("studie-server-dot-project-student-management.appspot.com", "/logout");
  var res = await http.get(uri, headers: {
  "x-access-token": code,
  "type" : "teacher"
  });
  if(res.statusCode == 200) {
  print(res.body);
  sharedPreference.setString("user", "");
  sharedPreference.setString("global_state", "not");
  sharedPreference.setString("password", "");
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyApp()));
  }else{
  print(res.statusCode);
  }}

  static Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
    }
    if(message.containsKey("notification")){
      print(message);
    }

    return Future<void>.value();

  }
  Widget _buildDialog(BuildContext context, Map<String, dynamic> item) {
    return AlertDialog(
      backgroundColor: Colors_pack.color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: Text(item["notification"]["title"], style: TextStyle(color: Colors.white),),
      actions: <Widget>[
        FlatButton(
          child: const Text('CLOSE'),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        FlatButton(
          child: const Text('SHOW'),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
      ],
    );
  }
  void _showItemDialog(Map<String, dynamic> message) {
    showDialog<bool>(
      context: context,
      builder: (_) => _buildDialog(context, message),
    ).then((bool shouldNavigate) {
      if (shouldNavigate == true) {
        _navigateToDetail();
      }
    });
  }
  void _navigateToDetail() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => notifications()));
  }

  void _AddMessage(Map<String, dynamic> message) async{
    print(message);
    final Future<Database> database = openDatabase(
      p.join(await getDatabasesPath(), 'notifications_db.db'),
      onCreate: (db, version){
        return db.execute("CREATE TABLE notifications(id INTEGER PRIMARY KEY AUTOINCREMENT, date TEXT, topic TEXT, title TEXT NOT NULL,desc TEXT)");
      },
      version: 1,
    );
    DateTime today = DateTime.now();
    final Database db = await database;
    await db.insert('notifications', {
      'date' : "${today.day.toString()} ${today.month.toString()} ${today.year.toString()}",
      "topic": message['data']['topic'].toString(),
      "desc" :message["data"]["desc"].toString(),
      "title": message['notification']['title'].toString()
    }).catchError((err) => print(err));

  }

  void _AddMessageLaunch(Map<String, dynamic> message) async{
    print(message);
    final Future<Database> database = openDatabase(
      p.join(await getDatabasesPath(), 'notifications_db.db'),
      onCreate: (db, version){
        return db.execute("CREATE TABLE notifications(id INTEGER PRIMARY KEY AUTOINCREMENT, date TEXT, topic TEXT, title TEXT NOT NULL, desc TEXT)");
      },
      version: 1,
    );
    DateTime today = DateTime.now();
    final Database db = await database;
    await db.insert('notifications', {
      'date' : "${today.day.toString()} ${today.month.toString()} ${today.year.toString()}",
      "topic": message['data']['topic'].toString(),
      "title": message['data']['title'].toString(),
      "desc" :message["data"]["desc"].toString()
    }).catchError((err) => print(err));

  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTeachers();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        _showItemDialog(message);
        _AddMessage(message);
      },
      onLaunch: (Map<String, dynamic> mess) async{
        _AddMessageLaunch(mess);
        Navigator.push(context, MaterialPageRoute(builder: (context) => notifications()));

      },
      onResume: (Map<String, dynamic> mess) async {
        print(mess);
        _AddMessageLaunch(mess);
        Navigator.push(context, MaterialPageRoute(builder: (context) => notifications()));

      },

    );

  }

  getTeachers() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String n = preferences.getString("name");
    setState(() {
      name= n;
    });
    String token = preferences.getString("user");
    String tcode = preferences.getString("tcode");
    String icode = preferences.getString("icode");
    String pass = preferences.getString("password");
    Uri uri = Uri.https("studie-server-dot-project-student-management.appspot.com","/teacher/profile/$icode", {
      "code": token,
    });

    var res = await http.get(uri, headers: {
      "x-access-token":token,
      "type":"teacher"
    });

    if(res.statusCode == 200) {
      var j = jsonDecode(res.body);
      if(j["status"]=="success"){}else{
        var uri = Uri.https("studie-server-dot-project-student-management.appspot.com","/login/");

        var response = await http.post(uri, headers: {
          "type": "teacher",
        }, body: {
          'icode': icode,
          'uname': tcode,
          'pass': pass,
        },);

        Map<String, dynamic> json = jsonDecode(response.body);
        if(json.containsKey("x-access-token")) {
          preferences.setString("user",json["x-access-token"]);
        }else{
          globalKey.currentState.showSnackBar(SnackBar(content: Text("Session Expired! Signing out..."),));
          Timer(Duration(seconds: 2), () {
            signout();
          });
        }
      }
    }else{

    }




  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
         key: globalKey,
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
           actions: <Widget>[IconButton(onPressed:(){
             Navigator.push(context, MaterialPageRoute(builder: (context) => chat_start()));
           },icon: Image(image:AssetImage('assets/Group27.png'),),),
             IconButton(onPressed: () {
               Navigator.push(context, MaterialPageRoute(builder: (context) => notifications()));
    },icon: Image(image:AssetImage('assets/Group25.png')),)],
         ),
         drawer:
           Drawer(
             child: Column(
                 mainAxisSize: MainAxisSize.max,
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children:[ListView(
                   shrinkWrap: true,
               padding: EdgeInsets.zero,
               children: <Widget>[
                 DrawerHeader(
                     child: Center(
                         child: FittedBox(
                             fit: BoxFit.contain,
                             child:Container(
                             decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(20),
                                 color: Colors_pack.color),
                             child:Column(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   Image(
                                     image: AssetImage('assets/studie.png'),
                                     width: 160.0,
                                     height: 160.0,
                                   ),
                                 ])))),

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
                 ListTile(
                   title: Text('Privacy Policy',style: TextStyle(fontWeight:FontWeight.w900,color:Colors_pack.color, fontSize: 20),),
                   onTap: () {
                     Navigator.pop(context);
                     Navigator.push(context, MaterialPageRoute(builder: (context) => privacy_policy()));

                   },
                 ),

                 Container(
                   margin: EdgeInsets.symmetric(horizontal: 20),
                   child:RaisedButton(
                       color:Colors_pack.color,
                       onPressed: (){
                           signout();

                       },
                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                   child:Row(
                     children: <Widget>[
                       Icon(Icons.arrow_back,size: 24,color: Colors.white,),
                       Text('Sign Out', style: TextStyle(color:Colors.white, fontSize: 24),),
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
                 )]),

                 Container(
                     alignment: Alignment.bottomCenter,
                     child:Image(image: AssetImage("assets/drawer.png"),)
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
                      Expanded(flex:3,child:Padding(padding:EdgeInsets.all(5),child:Align(alignment:Alignment.centerLeft,child:
                      Consumer<main_model>(builder:(context, model, child){return RichText(text: TextSpan(
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 36,
                          fontWeight: FontWeight.bold
                        ),
                        children: [TextSpan(text: name + "\n" ),
                        TextSpan(text:'Teacher', style: TextStyle(fontWeight: FontWeight.normal, fontSize:24 ))]
                      ));})))),
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
                       elevation:0.0,
                         child:
                     intro_button("assets/attendance.png", "Attendance"),
                     onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => attendance()));},
                     color: Colors.white,
                     disabledColor: Colors.white,splashColor: Colors.blue,)),
                     Flexible(child:RaisedButton(
                           child: intro_button("assets/Group10.png", "Quiz"),
                           onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) =>  quizstart()));},
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
                   elevation:0.0,
                     child:
                     intro_button("assets/homework.png", "Assignment"),
                   onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => homework()));},
                   color: Colors.white,
                   disabledColor: Colors.white,splashColor: Colors.blue,)),
                       Flexible(child:RaisedButton(
                         elevation: 0.0,
                         child:
                         intro_button("assets/performance.png", "Performance"),
                         onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => perf_start()));},
                         color: Colors.white,
                         disabledColor: Colors.white,splashColor: Colors.blue,)),
                       Flexible(child:RaisedButton(
                         elevation: 0.0,
                         child:
                         intro_button("assets/documents.png", "Documents"),
                         onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => document()));},
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
                         intro_button("assets/report.png", "Reports"),
                         onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => report_entry()));},
                         color: Colors.white,
                         disabledColor: Colors.white,splashColor: Colors.blue,)),
                       Flexible(child:RaisedButton(
                         elevation: 0.0,
                         child:
                         intro_button("assets/announce.png", "Announce"),
                         onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => announce()));},
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