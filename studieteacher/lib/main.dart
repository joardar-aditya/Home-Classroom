import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studieteacher/ForgetPassword.dart';
import 'package:studieteacher/colors/colors.dart';
import 'package:studieteacher/models/Quiz_model.dart';
import 'package:studieteacher/models/announce_model.dart';
import 'package:studieteacher/models/chat_model.dart';
import 'package:studieteacher/models/current_q.dart';
import 'package:studieteacher/models/doc_model.dart';
import 'package:studieteacher/models/exam_add_model.dart';
import 'package:studieteacher/models/exam_details_model.dart';
import 'package:studieteacher/models/hw_model.dart';
import 'package:studieteacher/models/hw_submit_model.dart';
import 'package:studieteacher/models/main_model.dart';
import 'package:studieteacher/models/performance_model.dart';
import 'package:studieteacher/models/reports.dart';
import 'package:studieteacher/sign_in.dart';
import 'package:studieteacher/splash_screen.dart';
import 'package:studieteacher/starting.dart';

import 'models/absent_students.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


    return MultiProvider(
       providers: [
         ChangeNotifierProvider(create: (context) => doc_model() ,),
         ChangeNotifierProvider(create: (context) => exam_add_model(),),
         ChangeNotifierProvider(create: (context) => hw_model()),
         ChangeNotifierProvider(create: (context) => announce_model()),
         ChangeNotifierProvider(create: (context) => absent_s_model(),),
         ChangeNotifierProvider(create: (context) => Quiz_model(),),
         ChangeNotifierProvider(create: (context) => current_q_model(),),
         ChangeNotifierProvider(create: (context)=> exam_details_model(),),
         ChangeNotifierProvider(create: (context)=> hw_submit(),),
         ChangeNotifierProvider(create: (context)=> performance_model(),),
         ChangeNotifierProvider(create: (context)=> reports(),),
         ChangeNotifierProvider(create: (context)=> main_model(),),
         ChangeNotifierProvider(create: (context) => chat_model(),)


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


  var logged_in = "waiting";

  @override
  void initState() {
    super.initState();
    _getStatecurrent();

  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    ScreenUtil.init(context, width: 1080, height: 2280, allowFontScaling: true);
    switch(logged_in) {
      case "waiting":
        return splash_screen();
        break;
      case "not":
       return Scaffold(
         body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: 20.0),
              decoration: BoxDecoration(color: Colors_pack.color),
              child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage('assets/studie.png'),
                          width: 200.0,
                          height: 200.0,
                        ),
                      ])),
            ),
            flex: 7,
          ),
          Expanded(
            child: Image(
              image: AssetImage('assets/family.png'),
              width: 60.0,
            ),
            flex: 3,
          ),
          Expanded(
            child: ListView(children: [sign_in(), FlatButton(
              onPressed: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context) => ForgetPassword()));
              },
              child: Text('Forgot Sign In Details?'),
            ),
            ]),
            flex: 7,
          )
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
