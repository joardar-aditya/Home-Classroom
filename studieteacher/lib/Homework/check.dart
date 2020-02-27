import 'package:flutter/material.dart';
import 'package:studieteacher/Homework/container_check.dart';
import 'package:studieteacher/Homework/homework_details.dart';
import 'package:studieteacher/starting.dart';

class check extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _checkState();

}

class _checkState extends State<check> {

  static var list_of_homework = [{"name": "Trigonometry","class": "5","section":"A", "subject":"Mathematics"},{"name": "Trigonometry","class": "5","section":"A", "subject":"Mathematics"}];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(itemCount:list_of_homework.length,itemBuilder: (context, index) {
      return InkWell(onTap:() {Navigator.push(context, MaterialPageRoute(builder: (context)=> homework_details()));},child:Container(margin:EdgeInsets.all(10),child:container_check(list_of_homework[index]["name"],list_of_homework[index]["class"],list_of_homework[index]["section"],list_of_homework[index]["subject"] )));
    });
  }

}