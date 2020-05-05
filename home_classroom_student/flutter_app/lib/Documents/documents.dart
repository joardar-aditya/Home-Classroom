import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutterapp/Color/colors.dart';
import 'package:flutterapp/models/Announce.dart';
import 'package:flutterapp/models/announce_model.dart';
import 'package:flutterapp/models/docu_model.dart';
import 'package:flutterapp/models/document.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class documents extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _stateDocu();

}

class _stateDocu extends State<documents>{

  bool _assign = true;


  void changeState(value) {
    setState(() {
      _assign = value;
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: RaisedButton(color:Colors.white, elevation:0.0, onPressed:() {Navigator.pop(context);},child:Image(image:AssetImage('assets/back.png'), height: 50,) ),
        title: Text('Documents', style: TextStyle(color:Colors_pack.color, fontWeight: FontWeight.w700, fontSize: 28),),
      ),
      body: ChangeNotifierProvider(
    create: (context) => docu_model(),
    child:ListView(
        children: <Widget>[
          /*Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(margin:EdgeInsets.all(10), child:RaisedButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    color:_assign?Colors_pack.color:Colors.grey,onPressed:() { changeState(true);},child:
                Padding(padding: EdgeInsets.all(10), child: Text('Class', style: TextStyle(color:_assign?Colors.white:Colors.black, fontWeight: FontWeight.bold, fontSize: 30)))),
                ),Container(margin:EdgeInsets.all(10),child:RaisedButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    color:!_assign?Colors_pack.color:Colors.grey,onPressed:() {changeState(false);},child:
                Padding(padding: EdgeInsets.all(10), child: Text('School', style: TextStyle(color: !_assign?Colors.white:Colors.black, fontWeight: FontWeight.bold, fontSize: 30),)))
                )],
            ),*/
         Consumer<announce_model>(builder:(context, model, child) {
           List<Document> c = model.docs;
           return ListView.builder(shrinkWrap:true, physics: NeverScrollableScrollPhysics(), itemCount:model.AnnounceSize ,itemBuilder: (context, ind) {
           return Column(
               mainAxisAlignment: MainAxisAlignment.start,
               crossAxisAlignment: CrossAxisAlignment.start,
               children:[
             Container(
               margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
               child: Text("Documents", style: TextStyle(color:Colors.deepPurpleAccent, fontSize: 20),),
             ),
             Container(
               margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
               child: Text(c[ind].title, style: TextStyle(color:Colors.black, fontSize: 22, fontWeight: FontWeight.bold),),
             ),
             InkWell(
                 child:Container(
               padding: EdgeInsets.all(10),
               decoration: BoxDecoration(
                   color:Colors.grey[300],
                   borderRadius: BorderRadius.circular(10)
               ),
               margin: EdgeInsets.all(10),
               child: Row(
                 crossAxisAlignment: CrossAxisAlignment.center,
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: <Widget>[
                   Text((c[ind].filepath == null)?"No File Available": c[ind].filepath.split("-")[c[ind].filepath.split("-").length-1].toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                   Icon(Icons.arrow_downward, color: Colors_pack.color, size: 30,)
                 ],
               ),
             ), onTap: () async{
               SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
               String icode = sharedPreferences.getString("icode");
               String code = sharedPreferences.getString("user");
               String school = sharedPreferences.getString("icode");
               String classe = sharedPreferences.getString("class");
               String sec = sharedPreferences.getString("sec");
               String Id = c[ind].Id;
               Uri uri =Uri.https("studie-server-dot-project-student-management.appspot.com", "/student/docs/download/$school", {
                 "id": Id,
               });
               var res = await http.get(uri, headers: {
                 "x-access-token": code,
                 "type": "student"
               });
               if(res.statusCode == 200) {
                 var j = jsonDecode(res.body);
                 if(j["status"] == "success"){
                   final directory = await getExternalStorageDirectories();
                   String path = directory[0].path;
                   print(path);
                   await launch(j["download_link"].toString());
                   print("DONE");

                 }
               }

             },),]);
         });})





        ],

      ),
    ));
  }

}