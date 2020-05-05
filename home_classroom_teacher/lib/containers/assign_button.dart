import 'package:flutter/material.dart';
import 'package:studieteacher/colors/colors.dart';


class assign_button extends StatefulWidget{


  var boolean = false;
  var text ;

  assign_button(this.boolean, this.text);
  @override
  State<StatefulWidget> createState() => _stateAssignb(boolean, text);




}

class _stateAssignb extends State<assign_button> {
  var boolvalue;
  var text ;
  _stateAssignb(this.boolvalue, this.text);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Padding(padding: EdgeInsets.all(5), child: Text('$text', style: TextStyle(color: boolvalue?Colors.white:Colors.black, fontWeight: FontWeight.bold),),),
      color: boolvalue?Colors_pack.color:Colors.grey,
    );
  }

}