import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:studieteacher/main.dart';
import 'package:studieteacher/starting.dart';
import 'package:http/http.dart' as http;


class sign_in extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _sign_in_state();
}
  class _sign_in_state extends State<sign_in> {

  var initid;
  var studentid;
  var password;

  void saveinitid(value) {
    setState(() {
      initid = value;
    });

  }
  void savestudent(value) {
    setState(() {
      studentid = value;
    });

  }
  void savepass(value) {

    setState(() {
      password = value;
    });

  }

  void login() async {


    //var uri = Uri.https("project-student-management.appspot.com","/teacher/");


    /*var response = await http.post(uri, headers: {
      "type": "teacher",
    }, body: {
      'icode': initid,
      'uname': studentid,
      'pass': password,
    });
    print(initid.toString());
    print(studentid.toString());
    print(password.toString());

    Map<String, dynamic> json = jsonDecode(response.body.toString());
    if(json.containsKey("x-access-token")){*/
      Navigator.push(context,MaterialPageRoute(builder: (context) => starting()));
    /*}else{
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('User not Found!'),));
    }*/



  }
  @override
  Widget build(BuildContext context) {
  // TODO: implement build
  return Container(decoration:BoxDecoration(
  borderRadius: BorderRadius.circular(20.0),
  color: Colors.grey[200],
  ),margin: EdgeInsets.all(10.0),
  child: Stack(alignment:Alignment.bottomCenter,children: <Widget>[
  Padding(padding: EdgeInsets.all(10.0),child:
  Column(
  crossAxisAlignment: CrossAxisAlignment.stretch,
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: <Widget>[
  Expanded(
  flex: 2,
  child:Container(margin: EdgeInsets.all(5),child:TextFormField(
  keyboardType: TextInputType.text,
  onChanged: (value) {saveinitid(value);},
  decoration: new InputDecoration(
  labelText: "Enter Institution Code",
  focusColor: Colors.white,
  labelStyle: TextStyle(color: Colors.grey[500],fontWeight: FontWeight.w500,),
  filled: true,
  fillColor: Colors.white,
  border: new OutlineInputBorder(
  borderSide: BorderSide(color: Colors.grey),
  borderRadius: new BorderRadius.circular(25.0),
  ),
  )),) ),
  Expanded(
  flex: 2,
  child:Container(margin: EdgeInsets.all(5),child:TextFormField(
  keyboardType: TextInputType.text,
  onChanged: (value) {savestudent(value);},
  decoration: new InputDecoration(
  labelText: "Enter Student Code",
  labelStyle: TextStyle(color: Colors.grey[500],fontWeight: FontWeight.w500,),
  fillColor: Colors.white,
  focusColor: Colors.blue,
  filled: true,
  border: new OutlineInputBorder(
  borderSide: BorderSide(color: Colors.grey),
  borderRadius: new BorderRadius.circular(25.0),
  ),
  )),) ),
  Expanded(
  flex: 2,
  child:Container(margin: EdgeInsets.all(5),child:TextFormField(
  keyboardType: TextInputType.text,
  onChanged: (value) {savepass(value);},
  decoration: new InputDecoration(
  labelText: "Enter Password",
  labelStyle: TextStyle(color: Colors.grey[500],fontWeight: FontWeight.w500,),
  fillColor: Colors.white,
  focusColor: Colors.blue,
  filled: true,
  border: new OutlineInputBorder(
  borderSide: BorderSide(color: Colors.grey),
  borderRadius: new BorderRadius.circular(25.0),
  ),
  )),) ),
  Expanded(flex:1,child: Container(margin:EdgeInsets.only(
  top:2.0,
  left:40.0,
  right: 40.0),width: 200.0,height: 20.0,child:ButtonTheme(minWidth:200.0, height:20.0,child:RaisedButton(elevation:1.0,hoverElevation:1.5,shape:RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(20.0),
  ),onPressed: () {
    if(initid == null && studentid == null && password == null){
          Scaffold.of(context).showSnackBar(SnackBar(content: Text('Please enter all the details')));
    }else if(initid == "" && studentid == "" && password == ""){
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Please enter all the details')));
    }
    else{
  login();}
  //Navigator.push(context, MaterialPageRoute(builder: (context) => starting()));
  }, child: Text('SIGN IN', style: TextStyle(fontSize: 20.0, color: Colors.white,),),disabledColor: Colors.blue,),)
  )


  )],
  ),),
  ],overflow: Overflow.visible,));
  }
  }
