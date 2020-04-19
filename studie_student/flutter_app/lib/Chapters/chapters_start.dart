import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Chapters/chapter_start_con.dart';
import 'package:flutterapp/Color/colors.dart';
import 'package:flutterapp/model/Chapter_model.dart';
import 'package:flutterapp/model/main_model.dart';
import 'package:provider/provider.dart';


class chapter_start extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _stateDetails();


}


class _stateDetails extends State<chapter_start> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }




  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar:  AppBar(
          elevation: 0.0,
          leading: RaisedButton(color:Colors.white, elevation:0.0, onPressed:() {Navigator.pop(context);},child:Image(image:AssetImage('assets/back.png'), height: 50,) ),
          title: Text('Chapters', style: TextStyle(color:Colors_pack.color, fontWeight: FontWeight.w700, fontSize: 28),),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10),
              child: Text('Choose a Subject', style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),),
            ),
            Consumer<main_model>(builder:(context, model, child) { return Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Color(0xff261FFF),
                    borderRadius: BorderRadius.circular(5)),
                padding: EdgeInsets.only(left: 10),
                child:Row(children:[Expanded(flex:4,child:DropdownButton<String>(
                  value: model.Current_Subject,
                  onChanged: (String string) {
                    model.ChangeSubject(string);
                  },
                  underline: Container(),
                  iconSize: 0,
                  selectedItemBuilder: (BuildContext context) {
                    return model.subjects_list.map<Widget>((String item) {
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
                  items: model.subjects_list.map((String item) {
                    return DropdownMenuItem<String>(
                      child: Text('$item'),
                      value: item,
                    );
                  }).toList(),
                )),Expanded(child:Container(margin:EdgeInsets.all(10),height:15,width: 15,decoration: BoxDecoration(color:Colors.blue[200], shape: BoxShape.circle),))])
            );}),
            Container(
              margin: EdgeInsets.all(10),
              child: Text('Choose a Chapter', style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),),
            ),
           Consumer<main_model>(builder:(context, model, child){return  (model.list_of_chapters.isNotEmpty)?ListView.builder(shrinkWrap:true, physics:NeverScrollableScrollPhysics(),itemCount:model.list_of_chapters.length,itemBuilder: (context, ind) {
              return chapter_start_con(model.list_of_chapters[ind]);
            }):Container(child: Center(child: Text("No Chapters Available"),));})




          ],
        ));
  }


}