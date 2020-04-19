import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studieteacher/colors/colors.dart';
import 'package:studieteacher/models/performance_model.dart';
import 'package:studieteacher/models/reports.dart';
import 'package:studieteacher/report/report_search.dart';
import 'package:http/http.dart' as http;

class report_entry extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _stateReport();


}



class _stateReport extends State<report_entry> {
  final List<String> _classes = List<String>.generate(12, (index) => (index + 1).toString()).toList();
  final List<String> _sections = ["A", "B", "C", "D", "E", "F", "ALL"];
  static String _currentClass = "5";
  static String _section = "A";


  void reportGiveMerit(reports model) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String code = sharedPreferences.getString("user");
    String teacher = sharedPreferences.getString("tcode");
    String school = sharedPreferences.getString("icode");
    Uri uri = Uri.https("studie-server-dot-project-student-management.appspot.com", "/teacher/merits/class/$school/$_currentClass/$_section".toLowerCase());
    print(uri.toString());
    var res = await http.post(uri, body: {
           "reason": model.Reason,
           "merit": "true",
           "tcode": teacher

    }, headers: {
      "x-access-token":code,
      "type": "teacher",
    });

    print(res.body);
    if(res.statusCode==200){
      var j = jsonDecode(res.body);
      if(j["status"]=="success"){
        globalKey.currentState.showSnackBar(SnackBar(content: Text(j["message"]),));
      }
    }
  }

  var search_s = "";

  void reportGiveDeMerit(reports model) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String code = sharedPreferences.getString("user");
    String teacher = sharedPreferences.getString("tcode");
    String school = sharedPreferences.getString("icode");
    Uri uri = Uri.https("studie-server-dot-project-student-management.appspot.com", "/teacher/merits/class/$school/$_currentClass/$_section".toLowerCase());
    var res = await http.post(uri, body: {
      "reason": model.Reason,
      "merit": "false",
      "tcode": teacher

    }, headers: {
      "x-access-token":code,
      "type": "teacher",
    });

    print(res.body);
    if(res.statusCode==200){
      var j = jsonDecode(res.body);
      if(j["status"]=="success"){
        globalKey.currentState.showSnackBar(SnackBar(content: Text(j["message"]),));
      }
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _classes.add("ALL");
  }

  void _changeSections(String v){
    setState(() {
      _section = v;
    });
  }

  void _changeClass(String valu) async{
    setState(() {
      _currentClass = valu;
    });
  }

  GlobalKey<ScaffoldState> globalKey = new GlobalKey();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        elevation: 0.0,
        leading: RaisedButton(color:Colors.white, elevation:0.0, onPressed:() {Navigator.pop(context);},child:Image(image:AssetImage('assets/back.png'), height: 50,) ),
        title: Text('Report', style: TextStyle(color:Colors_pack.color, fontWeight: FontWeight.w700, fontSize: 28),),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            child: Text('Add Merit/Demerit to a student', style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),),
          ),
         Container(
              margin: EdgeInsets.all(10),
              child:Consumer<performance_model>(builder:(context, model, child){return TextField(
                onChanged: (s) {

                  setState(() {
                    search_s = s;
                  });
                },
                decoration: InputDecoration(
                    suffixIcon: InkWell(
                      onTap: () {
                        model.getStudents(search_s);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => reportSearch()));
                      },
                        child:Container(
                          height:25,
                          width: 25,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:Colors_pack.color,
                          ),
                          child: Center(child: Icon(Icons.search, color: Colors.white,),),
                        )
                    ),
                    hintStyle: TextStyle(color:Colors.pinkAccent, fontSize: 16),
                    hintText: "Enter the name of the student",
                    filled: true,
                    fillColor: Colors.grey[300],
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none)),
              );})
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Text('Add Merit/Demerit to a class', style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),),
          ),
          Container(
              margin: EdgeInsets.all(10),
              child:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,

                children: <Widget>[
                  FittedBox(fit:BoxFit.contain,child:Padding(padding:EdgeInsets.all(10),child:
                  Text("Class", style: TextStyle(color:Colors.black, fontWeight: FontWeight.bold, fontSize: 24),))),

                  FittedBox(fit:BoxFit.contain,child:Padding(padding: EdgeInsets.symmetric(horizontal: 5),child:
                  DropdownButton<String>(
                    value: _currentClass,
                    onChanged: (String string) => _changeClass(string),
                    underline: Container(),
                    iconSize: 0,
                    selectedItemBuilder: (BuildContext context) {
                      return _classes.map<Widget>((String item) {
                        return Container(
                            width: 80,
                            decoration: BoxDecoration(
                                color: Color(0xff261FFF),
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child:Center(child: Text(item, style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20, color: Colors.white),),
                            ));
                      }).toList();
                    },
                    items: _classes.map((String item) {
                      return DropdownMenuItem<String>(
                        child: Text('$item'),
                        value: item,
                      );
                    }).toList(),
                  ),)) ,
                  FittedBox(fit: BoxFit.contain,
                      child:
                      Padding(padding:EdgeInsets.all(10),child:
                      Text("Sec", style: TextStyle(color:Colors.black, fontWeight: FontWeight.bold, fontSize: 24),))),
                  FittedBox(fit:BoxFit.contain,child:
                  Padding(padding: EdgeInsets.symmetric(horizontal: 5),child:
                  DropdownButton<String>(
                    value: _section,
                    onChanged: (String string) => _changeSections(string),
                    underline: Container(),
                    iconSize: 0,
                    selectedItemBuilder: (BuildContext context) {
                      return _sections.map<Widget>((String item) {
                        return Container(
                            width: 80,
                            decoration: BoxDecoration(
                                color: Color(0xff261FFF),
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child:Center(child: Text(item.toString(), style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20, color: Colors.white),),
                            ));
                      }).toList();
                    },
                    items: _sections.map((String item) {
                      return DropdownMenuItem<String>(
                        child: Text('$item'),
                        value: item,
                      );
                    }).toList(),
                  ),) ),


                ],
              )),
          Container(
            margin: EdgeInsets.all(10),
            child:Consumer<reports>(builder:(context, model, child){return TextField(
              maxLines: 5,
              onChanged: (s) {model.AddReason(s);},
              decoration: InputDecoration(
    hintStyle: TextStyle(fontSize: 16),
    hintText: "Write a reason",
    filled: true,
    fillColor: Colors.grey[300],
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
              ),
            );})
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Center(
                  child:
                    Consumer<reports>(builder:(context, model, child){return RaisedButton(
                      padding: EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      color: Colors_pack.color,
                      onPressed: () {
                        reportGiveMerit(model);
                      },
                      child:Center(child:Text('Give Merit',style: TextStyle(color:Colors.white, fontSize: 28),))
                    );})
                ),
                Center(
                    child:
                    Consumer<reports>(builder:(context, model, child){return RaisedButton(
                        padding: EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        color: Colors_pack.color,
                        onPressed: () {reportGiveDeMerit(model);},
                        child:Center(child:Text('Give Demerit',style: TextStyle(color:Colors.white, fontSize: 28),))
                    );})
                )

              ],
            ),
          )

        ],
      ),
    );
  }



}