import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class intro_button extends StatelessWidget {
   var asset;
   var name;
  intro_button(this.asset, this.name);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(flex:4,fit:FlexFit.loose,child:
            Container(
              margin: EdgeInsets.only(bottom: 8),
              child:Center(
                  child:Image(image: AssetImage(asset),)),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
              color: Colors.blue[900]),
            )),
             Flexible(flex:1,fit:FlexFit.loose,child:Container(child:
             Center(
                child: Text(name,maxLines:1,style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: Colors.black),),
              ))),

          ],

    );
  }



}