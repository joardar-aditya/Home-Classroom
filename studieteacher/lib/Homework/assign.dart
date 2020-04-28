import 'dart:convert';
import 'dart:io';

import 'package:calendarro/date_utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studieteacher/Homework/homework.dart';
import 'package:studieteacher/Homework/hw.dart';
import 'package:studieteacher/colors/colors.dart';
import 'package:calendarro/calendarro.dart';
import 'package:studieteacher/models/hw_model.dart';
import 'package:http/http.dart' as http;
import 'package:studieteacher/models/main_model.dart';

class assign extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _assignState();
}

class _assignState extends State<assign> {
  static SharedPreferences prefs;
  static var date = new DateTime.now();

  final List<String> _classes =
      List<String>.generate(11, (index) => (index + 1).toString()).toList();
  final List<String> _period =
      List<String>.generate(7, (index) => (index + 1).toString()).toList();
  final List<String> _sections = ["A", "B", "C", "D", "E", "F"];
  static String _currentClass = "5";
  static String _currentperiod = "1";
  static String _section = "A";
  final List<String> _subjects = <String>[
    "Mathematics",
    "Physics",
    "Chemistry",
    "Biology"
  ];
  final List<String> _teachers = <String>["Trigonometry", "Calculus"];
  static String _currentteacher = "Trigonometry";
  static String _currentSubject = "Mathematics";
  static String _submitMonth;

  static String _submityear;

  static String _submitday;

  static List<String> day_list;

  final List<String> _months = [
    "JAN",
    "FEB",
    "MAR",
    "APR",
    "MAY",
    "JUN",
    "JUL",
    "AUG",
    "SEP",
    "OCT",
    "NOV",
    "DEC"
  ];
  final List<String> _year =
      List<String>.generate(50, (i) => (2000 + i).toString())
          .toList(growable: false);

  void _changeSections(String v) {
    setState(() {
      _section = v;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _submitMonth = _months[DateTime.now().month - 1];
    _submityear = DateTime.now().year.toString();
    _submitday = DateTime.now().day.toString();
    if (["JAN", "MAR", "MAY", "JUL", "AUG", "OCT", "DEC"]
        .contains(_submitMonth)) {
      day_list = List<String>.generate(31, (i) => (1 + i).toString())
          .toList(growable: false);
    } else if (["APR", "JUN", "SEP", "NOV"].contains(_submitMonth)) {
      day_list = List<String>.generate(30, (i) => (1 + i).toString())
          .toList(growable: false);
    } else {
      if (int.parse(_submityear) % 4 == 0) {
        day_list = List<String>.generate(29, (i) => (1 + i).toString())
            .toList(growable: false);
      } else {
        day_list = List<String>.generate(28, (i) => (1 + i).toString())
            .toList(growable: false);
      }
    }
  }

  void _changeDate(String value) {
    setState(() {
      _submitday = value;
    });
  }
  
  var done = false;

  void _changeMonth(String value) {
    setState(() {
      _submitMonth = value;
      _submitday = "1";
      if (["JAN", "MAR", "MAY", "JUL", "AUG", "OCT", "DEC"]
          .contains(_submitMonth)) {
        day_list = List<String>.generate(31, (i) => (1 + i).toString())
            .toList(growable: false);
      } else if (["APR", "JUN", "SEP", "NOV"].contains(_submitMonth)) {
        day_list = List<String>.generate(30, (i) => (1 + i).toString())
            .toList(growable: false);
      } else {
        if (int.parse(_submityear) % 4 == 0) {
          day_list = List<String>.generate(29, (i) => (1 + i).toString())
              .toList(growable: false);
        } else {
          day_list = List<String>.generate(28, (i) => (1 + i).toString())
              .toList(growable: false);
        }
      }
    });
  }

  void _changeYear(String value) {
    setState(() {
      _submitday = "1";
      _submityear = value;
    });
  }

  void _changePeriod(String value) {
    setState(() {
      _currentperiod = value;
    });
  }

  void _changeTeacher(String value) {
    setState(() {
      _currentteacher = value;
    });
  }

  void _changeSubject(String value) {
    setState(() {
      _currentSubject = value;
    });
  }

  void _changeClass(String valu) async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _currentClass = valu;
      prefs.setString("c_class", valu);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      Container(
        margin: EdgeInsets.all(10),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: <
            Widget>[
          Column(
            children: [
              Container(
                child: Text(
                  'Class',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ),
              Consumer2<hw_model, main_model>(builder:(context, model, model2, child){return Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: DropdownButton<String>(
                  value: model2.Classes,
                  onChanged: (String string) {_changeClass(string);
                  model.changeClass(string);
                  model2.ChangeClasses(string);
                  model2.getDetails();
                  model2.getChapters();},
                  underline: Container(),
                  iconSize: 0,
                  selectedItemBuilder: (BuildContext context) {
                    return model2.Class_list.map<Widget>((String item) {
                      return Container(
                          width: 80,
                          decoration: BoxDecoration(
                              color: Color(0xff261FFF),
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children:[ Text(item, style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20, color: Colors.white),),
                                  Container(margin:EdgeInsets.all(10),height:15,width: 15,decoration: BoxDecoration(color:Colors.blue[200], shape: BoxShape.circle),)])
                          ));
                    }).toList();
                  },
                  items: model2.Class_list.map((String item) {
                    return DropdownMenuItem<String>(
                      child: Text('$item'),
                      value: item,
                    );
                  }).toList(),
                )
              );}),
            ],
          ),
          Column(
            children: [
              Container(
                child: Text(
                  'Section',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ),
              Consumer2<hw_model, main_model>(builder:(context, model,model2, child){ return Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: DropdownButton<String>(
                  value: model2.section,
                  onChanged: (String string) { _changeSections(string);
                  model.ChangeSection(string);},
                  underline: Container(),
                  iconSize: 0,
                  selectedItemBuilder: (BuildContext context) {
                    return model2.Section_list.map<Widget>((String item) {
                      return Container(
                          width: 80,
                          decoration: BoxDecoration(
                              color: Color(0xff261FFF),
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                            child:  Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children:[ Text(item, style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20, color: Colors.white),),
                                  Container(margin:EdgeInsets.all(10),height:15,width: 15,decoration: BoxDecoration(color:Colors.blue[200], shape: BoxShape.circle),)]),
                          ));
                    }).toList();
                  },
                  items: model2.Section_list.map((String item) {
                    return DropdownMenuItem<String>(
                      child: Text('$item'),
                      value: item,
                    );
                  }).toList(),
                ),
              );})
            ],
          ),
          Column(
            children: [
              Container(
                child: Text(
                  'Period',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: DropdownButton<String>(
                  value: _currentperiod,
                  onChanged: (String string) => _changePeriod(string),
                  underline: Container(),
                  iconSize: 0,
                  selectedItemBuilder: (BuildContext context) {
                    return _period.map<Widget>((String item) {
                      return Container(
                          width: 80,
                          decoration: BoxDecoration(
                              color: Color(0xff261FFF),
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                            child:  Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children:[ Text(item, style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20, color: Colors.white),),
                                  Container(margin:EdgeInsets.all(10),height:15,width: 15,decoration: BoxDecoration(color:Colors.blue[200], shape: BoxShape.circle),)]),
                          ));
                    }).toList();
                  },
                  items: _period.map((String item) {
                    return DropdownMenuItem<String>(
                      child: Text('$item'),
                      value: item,
                    );
                  }).toList(),
                ),
              ),
            ],
          )
        ]),
      ),
      Container(
          margin: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: EdgeInsets.all(10),
                child: Text(
                  'Choose a Subject',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ),
              Consumer<main_model>(builder:(context, model, child){ return Container(
                decoration: BoxDecoration(
                    color: Color(0xff261FFF),
                    borderRadius: BorderRadius.circular(5)),
                padding: EdgeInsets.only(left: 10),
                child:Row(children:[Expanded(flex:4,child: DropdownButton<String>(
                  value: model.Current_Subject,
                  onChanged: (String string) {_changeSubject(string);
                  model.ChangeSubject(string);
                  model.getChapters();},
                  underline: Container(),
                  iconSize: 0,
                  selectedItemBuilder: (BuildContext context) {
                    return model.subjects.map<Widget>((String item) {
                      return Container(
                          child: Center(
                        child: Text(
                          item.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                      ));
                    }).toList();
                  },
                  items: model.subjects.map((String item) {
                    return DropdownMenuItem<String>(
                      child: Text('$item'),
                      value: item,
                    );
                  }).toList(),
                )),Expanded(child:Container(margin:EdgeInsets.all(10),height:15,width: 15,decoration: BoxDecoration(color:Colors.blue[200], shape: BoxShape.circle),))])
              );}),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: Text(
                            'Choose a Chapter',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22),
                          ),
                        ),
                        Consumer<main_model>(builder:(context, model, child){ return Container(
                          decoration: BoxDecoration(
                              color: Color(0xff261FFF),
                              borderRadius: BorderRadius.circular(5)),
                          padding: EdgeInsets.only(left: 10),
                          child:Row(children: [Expanded(flex:4,child:DropdownButton<String>(
                            value: model.current_chapter,
                            onChanged: (String string){
                                _changeTeacher(string);
                                model.ChangeChapter(string);
                                },
                            underline: Container(),
                            iconSize: 0,
                            selectedItemBuilder: (BuildContext context) {
                              return model.chapters.map<Widget>((String item) {
                                return Container(
                                    child: Center(
                                  child: Text(
                                    item.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.white),
                                  ),
                                ));
                              }).toList();
                            },
                            items: model.chapters.map((String item) {
                              return DropdownMenuItem<String>(
                                child: Text('$item'),
                                value: item,
                              );
                            }).toList(),
                          )),Expanded(child:Container(margin:EdgeInsets.all(10),height:15,width: 15,decoration: BoxDecoration(color:Colors.blue[200], shape: BoxShape.circle),))])
                        );}),
                      ]))
            ],
          )),
      Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Text(
          'Assign a homework',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
      ),
      Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Consumer<hw_model>(builder: (context, model, child) {
                return TextFormField(
                  onChanged: (value) {model.ChangeTitle(value);},
                decoration: InputDecoration(
                    border: InputBorder.none,
                    focusColor: Colors.grey,
                    fillColor: Colors.grey,
                    hintText: 'Add a title',
                    hintStyle: TextStyle(color: Colors.pinkAccent)),
                autocorrect: true,
                maxLines: 1,
              );}))),
      Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: FittedBox(
              fit: BoxFit.contain,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Flexible(
                      flex: 3,
                      fit: FlexFit.loose,
                      child: Container(
                          width: 300,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.all(8),
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Consumer<hw_model>(builder: (context, model, child) {
                                return TextFormField(
                                  onChanged: (value) {model.ChangeDesc(value);},
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    focusColor: Colors.grey,
                                    fillColor: Colors.grey,
                                    hintText: 'Add description',
                                    hintStyle:
                                        TextStyle(color: Colors.pinkAccent)),
                                autocorrect: true,
                                maxLines: 3,
                              );})))),
                  Flexible(
                      flex: 1,
                      fit: FlexFit.loose,
                      child: Container(
                          child: RaisedButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Container(

                                    child:Consumer<hw_model>(builder: (context, model, child){
                                      return Dialog(
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
                                                         File document = await  FilePicker.getFile();
                                                         print(document.path);
                                                         model.ChangeFile(document);
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
                                                  onPressed: () async{
                                                    File document = await  ImagePicker.pickImage(source:ImageSource.camera);
                                                    print(document.path);
                                                    model.ChangeFile(document);
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
                                                  onPressed: () async{
                                                    File document = await  FilePicker.getFile(type: FileType.image);
                                                    print(document.path);
                                                    model.ChangeFile(document);
                                                  },
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
                                ));}));
                              });
                        },
                        disabledColor: Colors_pack.color,
                        color: Colors_pack.color,
                        child: Container(
                          child: Center(
                              child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 50,
                          )),
                        ),
                        shape: CircleBorder(side: BorderSide.none),
                      )))
                ],
              ))),
      Container(
        margin: EdgeInsets.all(10),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: <
            Widget>[
          Column(
            children: [
              Container(
                child: Text(
                  'Day',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: DropdownButton<String>(
                  value: _submitday,
                  onChanged: (String string) => _changeDate(string),
                  underline: Container(),
                  iconSize: 0,
                  selectedItemBuilder: (BuildContext context) {
                    return day_list.map<Widget>((String item) {
                      return Container(
                          width: 80,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                            child:  Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children:[ Text(item, style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20, color: Colors.black),),
                                  Container(margin:EdgeInsets.all(10),height:15,width: 15,decoration: BoxDecoration(color:Colors.black, shape: BoxShape.circle),)])
                          ));
                    }).toList();
                  },
                  items: day_list.map((String item) {
                    return DropdownMenuItem<String>(
                      child: Text('$item'),
                      value: item,
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                child: Text(
                  'Month',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: DropdownButton<String>(
                  value: _submitMonth,
                  onChanged: (String string) => _changeMonth(string),
                  underline: Container(),
                  iconSize: 0,
                  selectedItemBuilder: (BuildContext context) {
                    return _months.map<Widget>((String item) {
                      return Container(
                          width: 100,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                            child:  Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children:[ Text(item, style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20, color: Colors.black),),
                                  Container(margin:EdgeInsets.all(10),height:15,width: 15,decoration: BoxDecoration(color:Colors.black, shape: BoxShape.circle),)])
                          ));
                    }).toList();
                  },
                  items: _months.map((String item) {
                    return DropdownMenuItem<String>(
                      child: Text('$item'),
                      value: item,
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                child: Text(
                  'Year',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: DropdownButton<String>(
                  value: _submityear,
                  onChanged: (String string) => _changeYear(string),
                  underline: Container(),
                  iconSize: 0,
                  selectedItemBuilder: (BuildContext context) {
                    return _year.map<Widget>((String item) {
                      return Container(
                          width: 100,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                            child:  Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children:[ Text(item, style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20, color: Colors.black),),
                                  Container(margin:EdgeInsets.all(10),height:15,width: 15,decoration: BoxDecoration(color:Colors.black, shape: BoxShape.circle),)])
                          ));
                    }).toList();
                  },
                  items: _year.map((String item) {
                    return DropdownMenuItem<String>(
                      child: Text('$item'),
                      value: item,
                    );
                  }).toList(),
                ),
              ),
            ],
          )
        ]),
      ),
      done?Container(margin:EdgeInsets.all(20),child:Center(child:Text("Homework uploaded successfully"))):Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Container(
            margin: EdgeInsets.all(10),
            width: 200,
            child: Consumer2<hw_model, main_model>(builder: (context, model,model2, child){
              return RaisedButton(
                onPressed: () {
                  int year = int.parse(_submityear);
                  int month = _months.indexOf(_submitMonth) + 1;
                  int day = int.parse(_submitday);
                  model.ChangeDate(DateTime(year, month, day));
                  uploadDocument(model2,model.hwSub, model.hwFile, model.hwTitle, model.hwDesc, model2.Classes, model2.section, model2.Current_Subject, model2.current_chapter);
                },
                color: Color(0xff261FFF),
                disabledColor: Colors.grey,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text('Done',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white))));})
        )])
    ]);
  }
  void uploadDocument(main_model model,DateTime submission, File filename, String title, String description, String classe, String sec, String subject, String chapter) async {
    List<String> _months = [
      "JAN",
      "FEB",
      "MAR",
      "APR",
      "MAY",
      "JUN",
      "JUL",
      "AUG",
      "SEP",
      "OCT",
      "NOV",
      "DEC"
    ];

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String code = sharedPreferences.getString("user");
    String school = sharedPreferences.getString("icode");
    String tcode = sharedPreferences.getString("tcode");
    if(filename == null){
       Uri uri = Uri.https("studie-server-dot-project-student-management.appspot.com", "/teacher/homework");
       var res = await http.post(uri, body: {
       "tcode" : tcode,
       "icode" : school,
       "class" : model.Classes,
       "sec" : model.section.toLowerCase(),
       "subject" : model.Current_Subject,
       "chapter" : model.current_chapter,
       },
       headers: {
         "x-access-token": code,
         "type": "teacher"
       });
       print(res.body);
       if(res.statusCode == 200) {
         if(jsonDecode(res.body)["status"] == "success"){
           Scaffold.of(context).showSnackBar(SnackBar(content: Text("Homework Uploded Successfully"),));
           setState(() {
             done = true;
           });
           return;
         }
       }

    }
    Uri uri = Uri.https("studie-server-dot-project-student-management.appspot.com", "/teacher/homework" );
    var request = await http.MultipartRequest('POST', uri);
    print(filename.path);
    var file = await http.MultipartFile.fromPath('assignment', filename.path, contentType:MediaType.parse("image/png"));
    request.files.add(file);
    print(file.toString());
    request.headers["x-access-token"] = code;
    request.headers["type"] = "teacher";
    request.fields["tcode"] = tcode;
    request.fields["icode"] = school;
    request.fields["class"] = model.Classes;
    request.fields["sec"] = model.section.toLowerCase();
    request.fields["subject"] = model.Current_Subject;
    request.fields["chapter"] = model.current_chapter;
    String month = submission.month.toString();
    String day = submission.day.toString();
    if(submission.month<10){
      month = "0" + submission.month.toString();
    }
    if(submission.day<10){
      day = "0" + submission.day.toString();
    }
    request.fields["sub_date"] = submission.year.toString() + month  + day;
    request.fields["homework"] = "{\"title\":\"$title\", \"desc\":\"$description\"}";
    request.fields["period"] = _currentperiod;


    print(submission.year.toString()  + month + day);
    print("{\"title\":\"$title\", \"desc\":\"$description\"}");
    print(chapter);
    print(sec);
    print(classe);
    print(code);
    print(submission.day.toString() + _months[submission.month-1]  + submission.year.toString());
    print("I was called");
    var res = await request.send();
    var res_total  = await res.stream.bytesToString();
    print(res_total);
    print(res.statusCode);
    if(res.statusCode==200) {
      var j = jsonDecode(res_total);
      if(j["status"]=="success"){
           setState(() {
             done=true;
           });
        
      }else{
      }
    }else{
      Scaffold.of(context).showSnackBar(SnackBar(content: Text("not done"),));
    }
  }

}
