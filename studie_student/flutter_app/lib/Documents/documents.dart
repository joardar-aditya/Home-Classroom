import 'package:flutter/material.dart';
import 'package:flutterapp/Color/colors.dart';
import 'package:flutterapp/models/Announce.dart';
import 'package:flutterapp/models/docu_model.dart';
import 'package:provider/provider.dart';

class documents extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _stateDocu();

}

class _stateDocu extends State<documents>{

  bool _assign = true;


  void changeState(value) {
    setState(() {
      _assign = value;
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: RaisedButton(color:Colors.white, elevation:0.0, onPressed:() {Navigator.pop(context);},child:Image(image:AssetImage('assets/back.png'), height: 50,) ),
        title: Text('Documents', style: TextStyle(color:Colors_pack.color, fontWeight: FontWeight.w700, fontSize: 28),),
      ),
      body: ChangeNotifierProvider(
    create: (context) => docu_model(),
    child:ListView(
        children: <Widget>[
          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(margin:EdgeInsets.all(10), child:RaisedButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    color:_assign?Colors_pack.color:Colors.grey,onPressed:() { changeState(true);},child:
                Padding(padding: EdgeInsets.all(10), child: Text('Class', style: TextStyle(color:_assign?Colors.white:Colors.black, fontWeight: FontWeight.bold, fontSize: 30)))),
                ),Container(margin:EdgeInsets.all(10),child:RaisedButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    color:!_assign?Colors_pack.color:Colors.grey,onPressed:() {changeState(false);},child:
                Padding(padding: EdgeInsets.all(10), child: Text('School', style: TextStyle(color: !_assign?Colors.white:Colors.black, fontWeight: FontWeight.bold, fontSize: 30),)))
                )],
            ),
         Consumer<docu_model>(builder:(context, model, child) {
           List<Announce> c = model.genAnnouncements;
           return ListView.builder(shrinkWrap:true, physics: NeverScrollableScrollPhysics(), itemCount:model.AnnounceSize ,itemBuilder: (context, ind) {
           return Column(
               mainAxisAlignment: MainAxisAlignment.start,
               crossAxisAlignment: CrossAxisAlignment.start,
               children:[
             Container(
               margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
               child: Text(c[ind].date.toString(), style: TextStyle(color:Colors.deepPurpleAccent, fontSize: 20),),
             ),
             Container(
               margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
               child: Text(c[ind].title, style: TextStyle(color:Colors.black, fontSize: 22, fontWeight: FontWeight.bold),),
             ),
             Container(
               padding: EdgeInsets.all(10),
               decoration: BoxDecoration(
                   color:Colors.grey[300],
                   borderRadius: BorderRadius.circular(10)
               ),
               margin: EdgeInsets.all(10),
               child: Row(
                 crossAxisAlignment: CrossAxisAlignment.center,
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: <Widget>[
                   Text(c[ind].filepath, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                   Icon(Icons.arrow_downward, color: Colors_pack.color, size: 30,)
                 ],
               ),
             ),]);
         });})





        ],

      ),
    ));
  }

}