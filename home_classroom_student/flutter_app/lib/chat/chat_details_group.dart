import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Color/colors.dart';
import 'package:flutterapp/chat/Groups.dart';
import 'package:flutterapp/chat/Messages_groups.dart';
import 'package:flutterapp/model/Teachers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Messages.dart';

import 'Senders.dart';


class chat_details_group extends StatefulWidget {

  Groups c;
  chat_details_group(this.c);
  @override
  State<StatefulWidget> createState() => _stateI(c);

}

class _stateI extends State<chat_details_group> {

  List<Messages_groups> list_messages = [];
  Groups current ;
  String Student = "";

  _stateI(this.current);
  final ins = FirebaseDatabase.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMessages();
    getStudent();
  }

  void getStudent() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      Student = preferences.getString("tcode");
    });
}
  StreamSubscription <Event> updates;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    updates.cancel();
  }
  var controller = TextEditingController();
  void getMessages() async{
    ins.setPersistenceEnabled(true);
    final ref = ins.reference();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String teacher = preferences.getString("tcode");
    String school = preferences.getString("icode");
    updates = await ref.child("/Groups/"+current.id+"/messages/").orderByChild("sent_date").onValue.listen((event) {
      Map mes = event.snapshot.value;
      List<Messages_groups> curren = [];
      for(int i=0; i<mes.keys.toList().length;i++){
        Map c = mes[mes.keys.toList()[i]];
        print(c.toString());
        curren.add(Messages_groups(c["text"].toString(),c["journ"].toString(),c["name"].toString(), c["sent_date"]));
      }
      setState(() {
        curren.sort((a,b) => a.sent_date.compareTo(b.sent_date));
        list_messages = curren.reversed.toList();
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          leading: RaisedButton(color:Colors.white, elevation:0.0, onPressed:() {Navigator.pop(context);},child:Image(image:AssetImage('assets/back.png'), height: 50,) ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(current.name, maxLines: 1, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
              Text(current.members.join(", "), maxLines: 1, style: TextStyle(fontSize: 16),)

            ],
          ),
          actions: <Widget>[Container(margin:EdgeInsets.all(5),child:RaisedButton(color:Colors.white, elevation:0.0, onPressed:() {

          },child:Text('...', style: TextStyle(fontSize:36,fontWeight: FontWeight.w900, color: Colors_pack.color),)))],
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:[Expanded(
                child:ListView.builder(
                    reverse: true,
                    shrinkWrap: true,
                    itemCount:list_messages.length,itemBuilder: (context, ind) {
                  if(list_messages[ind].journ!=Student){
                    return Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children:[Container(
                            width:200,
                            padding:EdgeInsets.all(10),margin:EdgeInsets.all(10),alignment: Alignment.topLeft,decoration: BoxDecoration(color:Colors.grey[200], borderRadius:
                        BorderRadius.circular(20)),child:Column( crossAxisAlignment:CrossAxisAlignment.start,children:[Text(list_messages[ind].name, style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold, color: Colors.white ),),Text(list_messages[ind].text, style: TextStyle(fontSize: 16, color:Colors.white),)]))]);
                  }else if(list_messages[ind].journ==Student){
                    return Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children:[Container(
                            width:200,
                            padding:EdgeInsets.all(10),margin:EdgeInsets.all(10),alignment: Alignment.topRight,decoration: BoxDecoration(color:Colors.pinkAccent, borderRadius:
                        BorderRadius.circular(20)),child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children:[Text(list_messages[ind].name, style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold, color: Colors.white ),),Text(list_messages[ind].text, style: TextStyle(fontSize: 16, color: Colors.white),)]))]);
                  }
                  else{
                    return null;
                  }
                })),
              Container(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.all(10),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                            width: 400,
                            child:TextField(
                              controller: controller,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  hintText: "Enter your text"
                              ),
                            )),
                        InkWell(
                            onTap: () async{
                              ins.setPersistenceEnabled(true);
                              final ref = ins.reference();
                              SharedPreferences preferences = await SharedPreferences.getInstance();
                              String teacher = preferences.getString("tcode");
                              String school = preferences.getString("icode");
                              String name = preferences.getString("name");
                              DatabaseReference dat = await ref.child("/Groups/"+current.id+"/messages/");
                              String id = dat.push().key;
                              Messages m = new Messages(controller.text, "rec", 0, DateTime.now().millisecondsSinceEpoch);
                              dat.child(id).set({
                                "journ":teacher,
                                "sent_date":m.sent_date,
                                "text":m.text,
                                "name": name +" (Student)"

                              });

                              controller.clear();
                            },
                            child:Container(
                              decoration: BoxDecoration(
                                color: Colors_pack.color,
                                shape: BoxShape.circle,
                              ),
                              margin: EdgeInsets.all(10),
                              padding: EdgeInsets.all(20),
                              child: Icon(Icons.send, size: 30,color: Colors.white,),
                            ))
                      ],
                    ),
                  ))

            ])
    );
  }

}