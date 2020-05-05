import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studieteacher/Homework/container_check.dart';
import 'package:studieteacher/Homework/homework_details.dart';
import 'package:studieteacher/models/hw_model.dart';
import 'package:studieteacher/starting.dart';
import 'package:http/http.dart' as http;

import 'hw.dart';

class check extends StatefulWidget {

  hw_model list_of_homework ;
  check(this.list_of_homework);

  @override
  State<StatefulWidget> createState() => _checkState(list_of_homework);

}

class _checkState extends State<check> {

  final hw_model list_of_homework;
  _checkState(this.list_of_homework);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    list_of_homework.GetHomework();
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<hw_model>(builder:(context, model, child){
      return model.ListHomework.isEmpty?Container(child:Center(child:Text("If the list remain empty, please log in again or select another class"))):ListView.builder(itemCount:model.ListHomework.length,itemBuilder: (context, index) {
      return InkWell(onTap:() {Navigator.push(context, MaterialPageRoute(builder: (context)=> homework_details(model.ListHomework[index])));},child:Container(margin:EdgeInsets.all(10),child:container_check(model.ListHomework[index])));
    });});
  }

}