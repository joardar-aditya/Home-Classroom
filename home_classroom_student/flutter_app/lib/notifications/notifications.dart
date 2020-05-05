import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Color/colors.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'Notifs.dart';



class notifications extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _stateNotifications();
  }

}

class _stateNotifications extends State<notifications> {

  List<Notifs> notifications = [];

  @override
  void initState() {
    // TODO: implement initState
    GetNotifications();
  }

  void GetNotifications() async {
    final Future<Database> database = openDatabase(
      p.join(await getDatabasesPath(), 'notifications_db.db'),
    );
    
    final Database db  = await database;
    final List<Map<String, dynamic>> maps = await db.query('notifications');

    setState(() {
      notifications = List.generate(maps.length, (index) {
        return Notifs(
          maps[index]['date'],
          maps[index]["topic"],
          maps[index]["title"],
          maps[index]['desc']
        );
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
        title: Text('Notifications', style: TextStyle(color: Colors_pack.color, fontWeight: FontWeight.w700, fontSize: 28),),
      ),
      body: ListView(children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            ListView.builder(
              shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: notifications.length,
                itemBuilder:(context, ind) {
              return Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        notifications[ind].topic,
                        style: TextStyle(color: Colors_pack.color, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        notifications[ind].date,
                        style: TextStyle(color: Colors_pack.color, fontSize: 18, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    child: Text(
                      notifications[ind].title, style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    
                  ),
                Container(
                  margin: EdgeInsets.all(5),
                  child: Text(
                    notifications[ind].desc, style: TextStyle(color: Colors.black, fontSize: 18),
                  )),
              ],
                ),
              );
            }),
            Container(
                margin: EdgeInsets.all(20),
                child:RaisedButton(
              color: Colors_pack.color,
              onPressed: () {
                showDialog(context: context,
                child: AlertDialog(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  backgroundColor: Colors_pack.color,
                  content: Text("Are you show to clear all Notifications?", style: TextStyle(color: Colors.white),),
                  actions: <Widget>[
                    FlatButton(
                      child: const Text('NO'),
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                    ),
                    FlatButton(
                      child: const Text('YES'),
                      onPressed: () async{
                        Navigator.pop(context, true);
                        final Future<Database> database = openDatabase(
                            p.join(await getDatabasesPath(), 'notifications_db.db'),
                        );

                        final Database db  = await database;
                        db.execute("delete from "+ "notifications");
                        setState(() {
                          notifications = [];
                        });

                      },
                    ),
                  ],



                ));
              },
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Text("Clear", style: TextStyle(color: Colors.white, fontSize: 20),),
            ))
          ],
        )
      ],),
    );
  }

}