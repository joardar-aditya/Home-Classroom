import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studieteacher/chat/chat_part.dart';
import 'package:studieteacher/colors/colors.dart';
import 'package:studieteacher/title_container.dart';
import 'package:path/path.dart' as p;
class chat_search extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _stateSearch();

}

class _stateSearch extends State<chat_search> {
  String downloadUri = null;
  GlobalKey<ScaffoldState> key = new GlobalKey();
  TextEditingController editor = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: key,
       appBar: AppBar(
         elevation: 0.0,
         leading: RaisedButton(color:Colors.white, elevation:0.0, onPressed:() {Navigator.pop(context);},child:Image(image:AssetImage('assets/back.png'), height: 50,) ),
         title: Text('New group', style: TextStyle(color:Colors_pack.color, fontWeight: FontWeight.w700, fontSize: 28),),
       ),
      body:ListView(
        children: <Widget>[
          title_container('Add a group title and icon'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              RaisedButton(
                onPressed: () async{
                  File document = await  FilePicker.getFile(type: FileType.image);
                  String filename = p.basename(document.path);
                  StorageReference storageReference = FirebaseStorage(storageBucket: "gs://project-student-management-app").ref().child("/group_icons/$filename");
                  StorageUploadTask uploadTask = storageReference.putFile(document);
                  StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
                  String url = (await downloadUrl.ref.getDownloadURL());
                  if(url != null){
                    setState(() {
                      downloadUri = url;
                      key.currentState.showSnackBar(SnackBar(content: Text("Group icon updated Successfully")));
                    });


                  }
                },
                shape: CircleBorder(side: BorderSide.none),
                color: Colors.grey[200],
                child: Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:Colors_pack.color,
                  ),
                  child: Icon(Icons.add, color: Colors.white, size: 30,),
                ),
              ),
              Container(
                width: 300,
                margin: EdgeInsets.all(10),
                child: TextField(
                  controller: editor,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(color:Colors.pinkAccent, fontSize: 22),
                    hintText: "Add a title",
                    filled: true,
                    fillColor: Colors.grey[300],
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none)
                ),),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
              RaisedButton(
              onPressed: () {
                Navigator.pop(context);
              },
                color: Colors_pack.color,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Container(
                  color: Colors_pack.color,
                  padding: EdgeInsets.all(10),
                  child: Text('Done', style: TextStyle(color:Colors.grey[300],fontSize: 24, fontWeight: FontWeight.bold),),
                ),
              ),
            RaisedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => chat_part()));
              },
              color: Colors_pack.color,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Container(
                color: Colors_pack.color,
                padding: EdgeInsets.all(10),
                child: Text('Add Participants', style: TextStyle(color:Colors.grey[300],fontSize: 24, fontWeight: FontWeight.bold),),
              ),
            ),

          ],


    ) ,
          Container(
              margin: EdgeInsets.all(20),
              child:
          RichText(text: TextSpan(style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),children: [
            TextSpan(text: "0", style: TextStyle(color: Colors_pack.color)),
            TextSpan(text: " Participants", style: TextStyle(color: Colors.black))

          ])))
        ]

    ));
  }

}