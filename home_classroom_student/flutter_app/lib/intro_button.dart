import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Color/colors.dart';


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
          children: <Widget>[
            Flexible(flex:4,fit:FlexFit.loose,child:
            Container(
              padding: EdgeInsets.all(4),
              margin: EdgeInsets.only(bottom: 8),
              child:Center(
                  child:Image(image: AssetImage(asset),)),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
              color: Colors_pack.color),
            )),
             Flexible(flex:1,fit:FlexFit.loose,child:FittedBox(fit: BoxFit.contain,child:Container(child:
             Center(
                child: Text(name,maxLines:1,style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: Colors.black),),
             )))),

          ],

    );
  }



}