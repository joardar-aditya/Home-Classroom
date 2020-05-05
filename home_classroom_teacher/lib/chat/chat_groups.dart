import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studieteacher/chat/chat_details_group.dart';

class chat_group extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _stateI();
  }

}

class _stateI extends State<chat_group> {

  List<Groups> groups = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getGroups();
  }

  void getGroups() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String icode = prefs.getString("icode");
    String tcode = prefs.getString("tcode");
    FirebaseDatabase ins = FirebaseDatabase.instance;
    ins.setPersistenceEnabled(true);
    ins.reference().child("/teacher/${tcode}_${icode}/contacts/groups").once().then((value) async {
      Map ret = value.value;
      List i = ret.values.toList();
      List<Groups> grp = [];
      for(int k=0; k<i.length; k++){
       var value = await  ins.reference().child("/Groups/${i[k].toString()}").once();
          Groups g = Groups(i[k].toString().toString(),value.value["name"].toString(),value.value["icon"].toString() );
          Map members = value.value["members_string"];
          g.AddMember(members.values.toList());
          grp.add(g);
      }
      setState(() {
        print(grp);
        groups = grp;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: groups.length,
        itemBuilder: (context, i) {
      return InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => chat_details_group(groups[i])));
      },
          child:Container(
        margin: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height:70,
              width: 70,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.pinkAccent
              ),
              child: FittedBox(
                  fit: BoxFit.cover,
                  child:Image(image: NetworkImage(groups[i].icon),)),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(groups[i].name, style: TextStyle(color: Colors.black,fontSize: 22, fontWeight: FontWeight.bold),),
              ],
            )
          ],
        ),
      ));
    });
  }

}

class Groups {
  String name;
  String icon;
  String id;
  List members = [];

  void AddMember(List s){
    members = s;
  }

  Groups(this.id,this.name, this.icon);
}