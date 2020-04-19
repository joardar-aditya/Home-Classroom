import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studieteacher/basic/basics.dart';
import 'package:studieteacher/colors/colors.dart';
import 'package:studieteacher/models/doc_model.dart';
import 'package:http/http.dart' as http;

class document extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _stateDocu();


}

class _stateDocu extends State<document> {

  final List<String> _classes = List<String>.generate(12, (index) => (index + 1).toString()).toList();
  final List<String> _sections = ["A", "B", "C", "D", "E", "F", "ALL"];
  static String _currentClass = "5";
  static String _section = "A";
  var loading = false;

  final globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _classes.add("ALL");
    doc_model().setClass(_currentClass);
    doc_model().setSec(_section);
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
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key:globalKey,
      appBar:  AppBar(
        elevation: 0.0,
        leading: RaisedButton(color:Colors.white, elevation:0.0, onPressed:() {Navigator.pop(context);},child:Image(image:AssetImage('assets/back.png'), height: 50,) ),
        title: Text('Add a Document', style: TextStyle(color:Colors_pack.color, fontWeight: FontWeight.w700, fontSize: 28),),
      ),
      body:ListView(
        children: <Widget>[
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
                            child:Center(child:  Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children:[ Text(item, style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20, color: Colors.white),),
                        Container(margin:EdgeInsets.all(10),height:15,width: 15,decoration: BoxDecoration(color:Colors.blue[200], shape: BoxShape.circle),)]),
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
                            child:Center(child:  Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children:[ Text(item, style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20, color: Colors.white),),
                                  Container(margin:EdgeInsets.all(10),height:15,width: 15,decoration: BoxDecoration(color:Colors.blue[200], shape: BoxShape.circle),)]),
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
            margin: EdgeInsets.all(20),
            child:Text('Add a Document', style: TextStyle(color:Colors.black, fontSize: 24, fontWeight: FontWeight.bold),)
          ),
          Container(
            margin: EdgeInsets.all(20),
            child:Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Flexible(
                  flex:4, fit: FlexFit.loose,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    child:Consumer<doc_model>(builder:
                    (context, model, child) {
                      return TextField(
                      onChanged: (value) {model.add_desc(value);},
                      decoration: InputDecoration(
                        hintStyle: TextStyle(color:Colors.pinkAccent, fontSize: 16),
                        hintText: "Write a Description",
                        filled: true,
                        fillColor: Colors.grey[300],
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none)
                    ),);},
                    )),
                ),
                Flexible(
                    fit: FlexFit.loose,
                    child:InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Consumer<doc_model>(builder:
                                    (context, model, child){
                                  return Container(
                                        child:
                                    Dialog(
                                        backgroundColor: Colors_pack.color,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20.0),
                                            side: BorderSide.none),
                                        child: Container(child:Stack(
                                          overflow: Overflow.visible,
                                          children: <Widget>[
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                Flexible(
                                                    flex:5,
                                                    child: Container(
                                                      height: 70,
                                                      width:130,
                                                      child: RaisedButton(
                                                        elevation: 0.0,
                                                        child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children:[
                                                              Image(image: AssetImage("assets/upload3.png"),height: 50,width: 50,),
                                                              Text(
                                                                'Document',
                                                                style: TextStyle(
                                                                    color: Colors.white),
                                                              )]),
                                                        onPressed: () async {
                                                          File document = await FilePicker.getFile();
                                                          print(document.toString());
                                                          model.change_file(document);
                                                          SnackBar snackbar = SnackBar(content: Text("File Uploaded"),);
                                                          globalKey.currentState.showSnackBar(snackbar);
                                                          },
                                                        disabledColor:
                                                        Colors_pack.color,
                                                        color: Colors_pack.color,
                                                      ),)),
                                                Flexible(
                                                    child:Container(
                                                      height:100,
                                                      child:Container(),
                                                    )
                                                ),
                                                Flexible(
                                                    flex:5,
                                                    child: Container(
                                                      height: 70,
                                                      width:130,
                                                      child: RaisedButton(
                                                        elevation: 0.0,
                                                        child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children:[
                                                              Image(image: AssetImage("assets/upload2.png"),height: 50,width: 50,),
                                                              Text(
                                                                'Camera',
                                                                style: TextStyle(
                                                                    color: Colors.white),
                                                              )]),
                                                        onPressed: () async {File document = await FilePicker.getFile(type: FileType.image);
                                                        model.change_file(document);
                                                        globalKey.currentState.showSnackBar(new SnackBar(content:Text("File taken " + document.path)));},
                                                        disabledColor:
                                                        Colors_pack.color,
                                                        color: Colors_pack.color,
                                                      ),)),
                                                Flexible(
                                                    child:Container(
                                                      height:100,
                                                      child:Container(),
                                                    )
                                                ),
                                                Flexible(
                                                    flex:5,
                                                    child: Container(
                                                      height: 70,
                                                      width:100,
                                                      child: RaisedButton(
                                                        elevation: 0.0,
                                                        child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children:[
                                                              Image(image: AssetImage("assets/camera_upload.png"),height: 50,width: 50,),
                                                              Text(
                                                                'Upload',
                                                                style: TextStyle(
                                                                    color: Colors.white),
                                                              )]),
                                                        onPressed: () async { File document = await FilePicker.getFile(type: FileType.video);
                                                        model.change_file(document);
                                                        globalKey.currentState.showSnackBar(new SnackBar(content:Text("File taken " + document.path)));},
                                                        disabledColor:
                                                        Colors_pack.color,
                                                        color: Colors_pack.color,
                                                      ),)),

                                              ],
                                            ),
                                            Positioned(
                                                left: 0.0,
                                                bottom: -50.0,
                                                child: RaisedButton(
                                                    shape: CircleBorder(
                                                        side: BorderSide.none),
                                                    disabledColor: Colors_pack.color,
                                                    color: Colors_pack.color,
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: Icon(
                                                      Icons.close,
                                                      color: Colors.white,
                                                    )))
                                          ],
                                        ),
                                        )));});
                              });
                        },
                        child:Container(
                      alignment: Alignment.centerRight,
                      height:50,
                      width: 50,
                      decoration: BoxDecoration(shape: BoxShape.circle, color:Colors_pack.color),
                      child: Center(child:Icon(Icons.add, size: 40, color: Colors.white,)),
                    ))
                )

              ],
            ),
          ),
          Container(
              margin: EdgeInsets.all(20),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.start,

                children: <Widget>[
                  SizedBox(
                    child:Consumer<doc_model>(builder:
                  (context, model, child) {
    return RaisedButton(
    onPressed: () {
    uploadDocument(model.get_file(), model.get_desc(),_currentClass, _section);
    },
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    disabledColor: Colors_pack.color,
    color: Colors_pack.color,
    padding: EdgeInsets.all(10),
    child: Text('Publish', style: TextStyle(color:Colors.white, fontWeight: FontWeight.bold, fontSize: 24),),
          );}),
    width: 120,
    height: 50,
    )
          ],
          )
          ),
          loading?Container(
            margin: EdgeInsets.all(40),
            child: Center(child:CircularProgressIndicator(strokeWidth: 10,)),
          ):Container()

          ],
          ));
          }
    void  uploadDocument(File filename, desc, classes, sec) async {
        Uri uri = Uri.https("studie-server-dot-project-student-management.appspot.com", "/teacher/docs/a101/$classes/$sec/" );
        print(uri.toString());
        setState(() {
          loading = true;
        });
        var request = await http.MultipartRequest('POST', uri);
        print(filename.path);
        var file = await http.MultipartFile.fromPath('doc', filename.path, contentType:MediaType("image", "jpeg"));
        request.files.add(file);
        print(file.contentType.toString());
        SharedPreferences preferences = await SharedPreferences.getInstance();
        String code = preferences.getString("user");
        String tcode = preferences.getString("tcode");
        print(code);
        request.headers["x-access-token"] = code;
        request.headers["type"] = "teacher";
        request.fields["description"] = desc;
        request.fields["tcode"] = tcode;
        var res = await request.send();
        var data = await res.stream.bytesToString();
        var js = json.decode(data);
          if(res.statusCode==200){
            if(js["status"]=="success"){
              globalKey.currentState.showSnackBar(SnackBar(content: Text('Document Uploaded Successfully'),));
              setState(() {
                loading=false;
              });
            }else{
              globalKey.currentState.showSnackBar(SnackBar(content: Text("Sorry, The Document couldn't be sent, check the format again"),));
              setState(() {
                loading=false;
              });
            }

          }else {
            globalKey.currentState.showSnackBar(SnackBar(content: Text('Problem in Internet Connection'),));
            setState(() {
              loading=false;
            });
          }


    }


  }

