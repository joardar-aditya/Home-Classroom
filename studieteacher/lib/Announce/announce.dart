import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studieteacher/basic/basics.dart';
import 'package:studieteacher/colors/colors.dart';

class announce extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _stateAbbu();


}

class _stateAbbu extends State<announce> {

  final List<String> _classes = List<String>.generate(12, (index) => (index + 1).toString()).toList();
  final List<String> _sections = ["A", "B", "C", "D", "E", "F", "ALL"];
  static String _currentClass = "5";
  static String _section = "A";

  @override
  void initState() {
    super.initState();
    _classes.add("ALL");
  }

  void _changeSections(String v){
    setState(() {
      _section = v;
    });
  }

  void _changeClass(String valu) async{
    setState(() {
      _currentClass = valu;
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: basics("Announce"),
        elevation: 0.0,
      ),
      body: ListView(
        children: <Widget>[
          Container(
              margin: EdgeInsets.all(10),
              child:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,

                children: <Widget>[
                  FittedBox(fit:BoxFit.contain,child:Padding(padding:EdgeInsets.all(10),child:
                  Text("Class", style: TextStyle(color:Colors.black, fontWeight: FontWeight.bold, fontSize: 24),))),

                  FittedBox(fit:BoxFit.contain,child:Padding(padding: EdgeInsets.symmetric(horizontal: 5),child:
                  DropdownButton<String>(
                    value: _currentClass,
                    onChanged: (String string) => _changeClass(string),
                    underline: Container(),
                    iconSize: 0,
                    selectedItemBuilder: (BuildContext context) {
                      return _classes.map<Widget>((String item) {
                        return Container(
                            width: 80,
                            decoration: BoxDecoration(
                                color: Color(0xff261FFF),
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child:Center(child: Text(item, style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20, color: Colors.white),),
                            ));
                      }).toList();
                    },
                    items: _classes.map((String item) {
                      return DropdownMenuItem<String>(
                        child: Text('$item'),
                        value: item,
                      );
                    }).toList(),
                  ),)) ,
                  FittedBox(fit: BoxFit.contain,
                      child:
                      Padding(padding:EdgeInsets.all(10),child:
                      Text("Sec", style: TextStyle(color:Colors.black, fontWeight: FontWeight.bold, fontSize: 24),))),
                  FittedBox(fit:BoxFit.contain,child:
                  Padding(padding: EdgeInsets.symmetric(horizontal: 5),child:
                  DropdownButton<String>(
                    value: _section,
                    onChanged: (String string) => _changeSections(string),
                    underline: Container(),
                    iconSize: 0,
                    selectedItemBuilder: (BuildContext context) {
                      return _sections.map<Widget>((String item) {
                        return Container(
                            width: 80,
                            decoration: BoxDecoration(
                                color: Color(0xff261FFF),
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child:Center(child: Text(item.toString(), style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20, color: Colors.white),),
                            ));
                      }).toList();
                    },
                    items: _sections.map((String item) {
                      return DropdownMenuItem<String>(
                        child: Text('$item'),
                        value: item,
                      );
                    }).toList(),
                  ),) ),


                ],
              )),
          //TODO:Adjust alignment
          Container(
              margin: EdgeInsets.all(20),
              child:Text('Write the announcment', style: TextStyle(color:Colors.black, fontSize: 24, fontWeight: FontWeight.bold),)
          ),
          Container(
            margin: EdgeInsets.all(20),
            child:Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Flexible(
                  flex:4, fit: FlexFit.loose,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    child:TextField(decoration: InputDecoration(
                        hintStyle: TextStyle(color:Colors.pinkAccent, fontSize: 16),
                        hintText: "Write a Description",
                        filled: true,
                        fillColor: Colors.grey[300],
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none)
                    ),),
                  ),
                ),
                //TODO: Inkwell to be added with popup
                Flexible(
                    fit: FlexFit.loose,
                    child:Container(
                      alignment: Alignment.centerRight,
                      height:50,
                      width: 50,
                      decoration: BoxDecoration(shape: BoxShape.circle, color:Colors_pack.color),
                      child: Center(child:Icon(Icons.add, size: 40, color: Colors.white,)),
                    )
                )

              ],
            ),
          ),
          Container(
              margin: EdgeInsets.all(20),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.start,

                children: <Widget>[
                  SizedBox(
                    child:RaisedButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      disabledColor: Colors_pack.color,
                      padding: EdgeInsets.all(10),
                      child: Text('Announce', style: TextStyle(color:Colors.white, fontWeight: FontWeight.bold, fontSize: 24),),
                    ),
                    width: 130,
                    height: 50,
                  )
                ],
              )
          )

        ],
      ),
    );
  }

}