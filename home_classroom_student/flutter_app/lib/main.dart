import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp/Color/colors.dart';
import 'package:flutterapp/ForgetPassword.dart';
import 'package:flutterapp/Performance/performance.dart';
import 'package:flutterapp/model/Attendance.dart';
import 'package:flutterapp/model/Chapter_model.dart';
import 'package:flutterapp/model/Exam_model.dart';
import 'package:flutterapp/model/Performance_model.dart';
import 'package:flutterapp/model/Quiz_model.dart';
import 'package:flutterapp/model/current_q.dart';
import 'package:flutterapp/model/dairy_model.dart';
import 'package:flutterapp/model/doubts_model.dart';
import 'package:flutterapp/model/homework_model.dart';
import 'package:flutterapp/model/main_model.dart';
import 'package:flutterapp/models/announce_model.dart';
import 'package:flutterapp/notifications/notifications.dart';
import 'package:flutterapp/sign_in.dart';
import 'package:flutterapp/starting.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'model/calendar_model.dart';
import 'models/docu_model.dart';
import 'package:path/path.dart' as p;


void main() => runApp(MyApp());



class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => current_q() ,),
          ChangeNotifierProvider(create: (context) => Quiz_Model(),),
          ChangeNotifierProvider(create: (context)=>Chapter_model(),),
          ChangeNotifierProvider(create: (context)=>attendance_model(),),
          ChangeNotifierProvider(create: (context)=>performance_model(),),
          ChangeNotifierProvider(create: (context)=>exam_model(),),
          ChangeNotifierProvider(create: (context) => doubts_model(),),
          ChangeNotifierProvider(create:(context) => Homework_model(),),
          ChangeNotifierProvider(create:(context) => Homework_model(),),
          ChangeNotifierProvider(create:(context) => dairy_model(),),
          ChangeNotifierProvider(create:(context) => main_model(),),
          ChangeNotifierProvider(create:(context) => calendar_model(),),
          ChangeNotifierProvider(create: (context)=>docu_model(),),
          ChangeNotifierProvider(create: (context)=>announce_model(),),



        ],
        child:MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primaryColor: Colors.white,
          ),
          home: MyHomePage(),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  var logged_in = "waiting";
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
    super.initState();

    _getStatecurrent();
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



  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.


    ScreenUtil.init(context, height:2280 , width:1080);
    switch(logged_in) {
      case "waiting":
        return Container();
        break;
      case "not":
        return Scaffold(
          body: ListView(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(bottom: 20.0),
                  decoration: BoxDecoration(color: Colors_pack.color),
                  child: Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage('assets/studie.png'),
                              width: 250.0,
                              height: 250.0,
                            ),
                          ])),
                ),
              Image(
                  image: AssetImage('assets/family.png'),
                  width: 60.0,
                ),
              ListView(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  children: [sign_in(), FlatButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ForgetPassword()));
                  },
                  child: Text('Forgot Sign In Details?', style: TextStyle(color:Colors_pack.color, fontSize: 18, decoration: TextDecoration.underline),),
                ),
                Container(
                  margin: EdgeInsets.all(30),
                  child: Image(
                    image: AssetImage('assets/Group96.png'),
                    width: 60.0,
                  ),
                ),
                Column(children:[Container(
                  margin: EdgeInsets.all(10),
                  child: Image(image: AssetImage("assets/drawer.png"),
                  width: 150,
                    height: 150,
                  ),
                ) ])
                ]),
            ],
          ),
        );
        break;
      case "yes":
        return starting();
        break;
    }
  }

  Future<bool> _getStatecurrent() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    //Global State for the user state
    bool value = sharedPreferences.containsKey("global_state");
    String string = "waiting";
    if(value){
      string = sharedPreferences.getString("global_state");
    }else{
      string = "not";
    }
    setState(() {
      logged_in = string;
    });
  }
}
