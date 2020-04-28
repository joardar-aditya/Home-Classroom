import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studieteacher/chapters/container_chapters.dart';
import 'package:studieteacher/colors/colors.dart';
import 'package:http/http.dart' as http;
import 'Chapter.dart';

class chapters_details extends StatefulWidget {
  Chapter _chapter;
  @override
  State<StatefulWidget> createState() => _stateDetails(_chapter);
  chapters_details(this._chapter);


}

class _stateDetails extends State<chapters_details> {
  Chapter _chapter;

  _stateDetails(this._chapter);

  void getDoubts() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String code = sharedPreferences.getString("user");
    String teacher = sharedPreferences.getString("tcode");
    String school = sharedPreferences.getString("icode");
    String cl = _chapter.classe;
    String sec = _chapter.section;
    Uri uri = Uri.https("studie-server-dot-project-student-management.appspot.com", "/teacher/chapters/doubts/$school/$cl/$sec".toLowerCase(), {
      "id": _chapter.Id,
      "chapterName":_chapter.Name,
    } );
  }
  GlobalKey<ScaffoldState> globalKey = new GlobalKey();
  @override
  Widget build(BuildContext context) {

    String subject = _chapter.Subject;
    String cl = _chapter.classe;
    String sec = _chapter.section;
    return Scaffold(
      key: globalKey,
        appBar:  AppBar(
          elevation: 0.0,
          leading: RaisedButton(color:Colors.white, elevation:0.0, onPressed:() {Navigator.pop(context);},child:Image(image:AssetImage('assets/back.png'), height: 50,) ),
          title: Text('Chapter Details', style: TextStyle(color:Colors_pack.color, fontWeight: FontWeight.w700, fontSize: 28),),
        ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(color:Colors_pack.color,
            borderRadius: BorderRadius.circular(10),
            ),
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Text(_chapter.Name, style: TextStyle(color:Colors.white, fontSize: 24,fontWeight: FontWeight.bold ),),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(child:Text('Class $cl Sec $sec', style: TextStyle(color:Colors.grey[400], fontSize: 20, fontWeight: FontWeight.bold),),
                      ),Align(alignment: Alignment.centerRight,child: Text('$subject',style: TextStyle(color:Colors.grey[400], fontSize: 20, fontWeight: FontWeight.bold), ),)

                    ],
                  ),
                )
              ],
            )
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.all(20),
                  child:
              SizedBox(
                height: 40,
                width: 100,
                child: RaisedButton(shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    onPressed: () async{
                      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                      String code = sharedPreferences.getString("user");
                      print(code);
                      String teacher = sharedPreferences.getString("tcode");
                      String school = sharedPreferences.getString("icode");
                      Uri uri = Uri.https("studie-server-dot-project-student-management.appspot.com", "/teacher/chapters/");
                      var res= await http.post(uri, body: {
                        "icode":school,
                        "class": cl,
                        "sec": sec,
                        "subject": subject,
                        "chapter": _chapter.Name,
                        "tcode":teacher,
                        "date": DateTime.now().toIso8601String(),
                      }, headers: {
                        "x-access-token": code,
                        "type":"teacher"
                      });
                     print(res.body);
                     var j = jsonDecode(res.body);
                     if(res.statusCode == 200) {
                        if(j["status"]=="success"){
                          globalKey.currentState.showSnackBar(SnackBar(content: Text("Chapter Ended!"),));
                        }else{
                          globalKey.currentState.showSnackBar(SnackBar(content: Text("Oops, the chapter could't be ended!"),));
                        }
                     }


                    }, color:Colors_pack.color,
                child:Center(child: Text('Start', style: TextStyle(color:Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),)),
              )),
              Container(
                  margin: EdgeInsets.all(20),
                  child:
                  SizedBox(
                    height: 40,
                    width: 100,
                    child: RaisedButton(shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        onPressed: () async{
                          SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                          String code = sharedPreferences.getString("user");
                          print(code);
                          String teacher = sharedPreferences.getString("tcode");
                          String school = sharedPreferences.getString("icode");
                          Uri uri = Uri.https("studie-server-dot-project-student-management.appspot.com", "/teacher/chapters/$school/$cl/$sec");
                          var res= await http.patch(uri, body: {
                            "id": _chapter.Id,
                            "chapterName": _chapter.Name,
                            "ongoing": "false"
                          }, headers: {
                            "x-access-token": code,
                            "type":"teacher"
                          });
                          print(res.body);


                        }, color:Colors_pack.color,
                        child:Center(child: Text('End', style: TextStyle(color:Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),)),
                  )),
            ],
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: Text('Doubts', style: TextStyle(color: Colors_pack.color, fontSize: 30, fontWeight: FontWeight.bold),),
          ),
          (_chapter.doubts_Ch.isEmpty)?Container(child:Center(child:Text("Woohoo! No doubts!"))):ListView.builder(itemCount:_chapter.doubts_Ch.length,shrinkWrap: true, physics:NeverScrollableScrollPhysics(),
              itemBuilder: (context, ind) {
            return container_chapters(_chapter.doubts_Ch[ind]);
          ;})
        ],
      ),
    );
  }
}