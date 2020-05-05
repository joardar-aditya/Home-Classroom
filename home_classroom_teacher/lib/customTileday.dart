import 'package:calendarro/calendarro.dart';
import 'package:calendarro/default_day_tile.dart';
import 'package:calendarro/default_day_tile_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:studieteacher/colors/colors.dart';

class customTileday extends DayTileBuilder {


  BoxDecoration decoration_u =BoxDecoration(
  color: Colors.grey[200],
  borderRadius: BorderRadius.circular(10)
  );

  BoxDecoration decoration_y =BoxDecoration(
      color: Colors_pack.color,
      borderRadius: BorderRadius.circular(10)
  );



  Widget build(BuildContext context, DateTime date, DateTimeCallback onTap) {

    bool isselected = Calendarro.of(context).isDateSelected(date);
    return Expanded(
      child: InkWell(
        onTap: () {
          Calendarro.of(context).setSelectedDate(date);
        },
        child:Container(
        margin: EdgeInsets.all(5),
        height:50,
        width: 50,
        child:Center(child:Text(date.day.toString(),textAlign:TextAlign.center,style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color:isselected?Colors.grey[100]:Colors.blue[900]),)),
        decoration: isselected?decoration_y : decoration_u,
        
      ),
    ));
  }
}