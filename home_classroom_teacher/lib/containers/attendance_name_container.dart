import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studieteacher/colors/colors.dart';
import 'package:studieteacher/models/absent_students.dart';

class attendance_name_container extends StatefulWidget {

  var _name;
  var _index;
  var _id;
  attendance_name_container(this._name, this._index, this._id);
  @override
  State<StatefulWidget> createState() => _attendanceS(_name, _index, _id);

}



class _attendanceS extends State<attendance_name_container>{

  var name;
  var index;
  var id;
  _attendanceS(this.name,this.index, this.id);
  var bool = false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<absent_s_model>(builder:(context, model, child){return InkWell(
        onTap: () {
          setState(() {
            bool = !bool;
          });

          model.AddAbsentee(id);
    },
        child:Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: bool?Colors.pinkAccent:Colors_pack.color,
            borderRadius: BorderRadius.circular(5)
        ),padding: EdgeInsets.only(left:10, top:10, bottom: 10),
      child:Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
         Container(padding:EdgeInsets.only(right: 10),child: Text('$index.', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
         ),Container(decoration: BoxDecoration(color:Colors.blue, shape: BoxShape.circle),height: 50, width: 50,),
          Container(padding:EdgeInsets.only(left:10), child:Text('$name', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
          )
        ],
      )

    ));});
  }


}