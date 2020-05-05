import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studieteacher/chat/chat_part.dart';
import 'package:studieteacher/colors/colors.dart';
import 'package:studieteacher/models/chat_model.dart';
import 'package:studieteacher/title_container.dart';
import 'package:path/path.dart' as p;

import 'Senders.dart';
class chat_search extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _stateSearch();

}

class _stateSearch extends State<chat_search> {
  String downloadUri = null;
  List<Senders> code_list = [];
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
              onPressed: () async{
                SharedPreferences prefs = await SharedPreferences.getInstance();
                String icode = prefs.getString("icode");
                String tcode = prefs.getString("tcode");
                FirebaseDatabase ins = FirebaseDatabase.instance;
                ins.setPersistenceEnabled(true);
                final ref = ins.reference();
                DatabaseReference ref_n = ref.child("/Groups/").push();
                ref.child("/teacher/${tcode}_${icode}/contacts/groups").push().set(ref_n.key);

                ref_n.set({
                  "icon":downloadUri.toString(),
                  "name":editor.text.toString(),
                });
                for(int j=0; j<code_list.length; j++) {
                  ref_n.child("/members/").push().set(code_list[j].code);
                  ref_n.child("/members_string/").push().set(code_list[j].Name);
                  if(code_list[j].Role == "students"){
                    ref.child("/students/${code_list[j].code}_${icode}/contacts/groups").push().set(ref_n.key);
                  }else{
                    ref.child("/parents/${code_list[j].code}_${icode}/contacts/groups").push().set(ref_n.key);
                  }

                }},
                color: Colors_pack.color,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Container(
                  color: Colors_pack.color,
                  padding: EdgeInsets.all(10),
                  child: Text('Done', style: TextStyle(color:Colors.grey[300],fontSize: 24, fontWeight: FontWeight.bold),),
                ),
              ),
            RaisedButton(
              onPressed: () async {
                showDialog(
                    context: context, child: Dialog(
                  backgroundColor: Colors.grey[300],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  child: Consumer<chat_model>(builder: (context, model, child) { return Container(
                    child: ListView.builder(
                        itemCount: model.students.length,
                        itemBuilder: (context, i) {
                      return InkWell(
                          onTap: () {
                            if(code_list.contains(model.students[i])){
                              setState(() {
                                 code_list.remove(model.students[i]);
                              });
                              model.RemoveParticipants(model.students[i]);
                            }else{
                              setState(() {
                                code_list.add(model.students[i]);
                              });
                              model.AddParticipant(model.students[i]);
                            }
                          },

                          child:Container(
                            margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(color:(model.participants.contains(model.students[i]))?Colors.pinkAccent:Colors_pack.color, borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(model.students[i].Name, style: TextStyle(color:Colors.white, fontSize: 18),),
                              Text(model.students[i].Role, style: TextStyle(color:Colors.white, fontSize: 14),)
                            ],
                        ),
                      ));
                    })
                  );}),
                ));
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
            TextSpan(text: code_list.length.toString(), style: TextStyle(color: Colors_pack.color)),
            TextSpan(text: " Participants", style: TextStyle(color: Colors.black))

          ]))),
          Container(
            margin: EdgeInsets.all(10),
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: code_list.length,itemBuilder: (context, i) {
              return Container(
                margin: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height:70,
                      width: 70,
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.pinkAccent
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(code_list[i].Name, style: TextStyle(color: Colors.black,fontSize: 22, fontWeight: FontWeight.bold),),
                        (code_list[i].Role == "parents")?Text("Parent"):Text("Class " + code_list[i].Class + " Sec " + code_list[i].section, style:TextStyle(color:Colors.black, fontSize: 18))
                      ],
                    )
                  ],
                ),
              );
            }, ),
          )
        ]

    ));
  }

}