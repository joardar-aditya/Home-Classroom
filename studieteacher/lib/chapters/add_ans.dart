import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studieteacher/basic/basics.dart';
import 'package:studieteacher/chapters/container_chapters.dart';
import 'package:studieteacher/colors/colors.dart';
import 'package:studieteacher/models/Doubts.dart';
import 'package:http/http.dart' as http;


class add_ans extends StatefulWidget {
  Doubts c;
  add_ans(this.c);
  @override
  State<StatefulWidget> createState() => _stateAdd(c);



}

class _stateAdd extends State<add_ans> {
  Doubts c;
  _stateAdd(this.c);
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: RaisedButton(color:Colors.white, elevation:0.0, onPressed:() {Navigator.pop(context);},child:Image(image:AssetImage('assets/back.png'), height: 50,) ),
        title: Text('Add Answer', style: TextStyle(color:Colors_pack.color, fontWeight: FontWeight.w700, fontSize: 28),),
      ),
      body: ListView(
        children:[
        Container(
          margin: EdgeInsets.all(10),
          child: container_chapters(c),
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
                    child:TextField(
                      controller: controller,
                      decoration: InputDecoration(
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
                    child:InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Container(

                                    child:Dialog(
                                        backgroundColor: Colors_pack.color,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20.0),
                                            side: BorderSide.none),
                                        child: Container(child:Stack(
                                          overflow: Overflow.visible,
                                          children: <Widget>[
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                Flexible(
                                                    flex:5,
                                                    child: Container(
                                                      height: 70,
                                                      width:130,
                                                      child: RaisedButton(
                                                        elevation: 0.0,
                                                        child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children:[
                                                              Image(image: AssetImage("assets/upload3.png"),height: 50,width: 50,),
                                                              Text(
                                                                'Document',
                                                                style: TextStyle(
                                                                    color: Colors.white),
                                                              )]),
                                                        onPressed: () {},
                                                        disabledColor:
                                                        Colors_pack.color,
                                                        color: Colors_pack.color,
                                                      ),)),
                                                Flexible(
                                                    child:Container(
                                                      height:100,
                                                      child:Container(),
                                                    )
                                                ),
                                                Flexible(
                                                    flex:5,
                                                    child: Container(
                                                      height: 70,
                                                      width:130,
                                                      child: RaisedButton(
                                                        elevation: 0.0,
                                                        child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children:[
                                                              Image(image: AssetImage("assets/upload2.png"),height: 50,width: 50,),
                                                              Text(
                                                                'Camera',
                                                                style: TextStyle(
                                                                    color: Colors.white),
                                                              )]),
                                                        onPressed: () {},
                                                        disabledColor:
                                                        Colors_pack.color,
                                                        color: Colors_pack.color,
                                                      ),)),
                                                Flexible(
                                                    child:Container(
                                                      height:100,
                                                      child:Container(),
                                                    )
                                                ),
                                                Flexible(
                                                    flex:5,
                                                    child: Container(
                                                      height: 70,
                                                      width:100,
                                                      child: RaisedButton(
                                                        elevation: 0.0,
                                                        child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children:[
                                                              Image(image: AssetImage("assets/camera_upload.png"),height: 50,width: 50,),
                                                              Text(
                                                                'Upload',
                                                                style: TextStyle(
                                                                    color: Colors.white),
                                                              )]),
                                                        onPressed: () {},
                                                        disabledColor:
                                                        Colors_pack.color,
                                                        color: Colors_pack.color,
                                                      ),)),

                                              ],
                                            ),
                                            Positioned(
                                                left: 0.0,
                                                bottom: -50.0,
                                                child: RaisedButton(
                                                    shape: CircleBorder(
                                                        side: BorderSide.none),
                                                    disabledColor: Colors_pack.color,
                                                    color: Colors_pack.color,
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: Icon(
                                                      Icons.close,
                                                      color: Colors.white,
                                                    )))
                                          ],
                                        ),
                                        )));
                              });
                        },
                        child:Container(
                      alignment: Alignment.centerRight,
                      height:50,
                      width: 50,
                      decoration: BoxDecoration(shape: BoxShape.circle, color:Colors_pack.color),
                      child: Center(child:Icon(Icons.add, size: 40, color: Colors.white,)),
                    ))
                ),
                Flexible(
                    fit: FlexFit.loose,
                    child:InkWell(
                        onTap: () async{
                          SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                          String code = sharedPreferences.getString("user");
                          print(code);
                          String teacher = sharedPreferences.getString("tcode");
                          String school = sharedPreferences.getString("icode");
                          String name = sharedPreferences.getString("name");
                          String cl = c.cl;
                          String se = c.sec;
                          Uri uri = Uri.https("studie-server-dot-project-student-management.appspot.com","/teacher/chapters/doubts/resolve/$school/$cl/$se" );
                          var res = await http.post(uri, headers: {
                            "x-access-token": code,
                            "type": "teacher"
                          }, body: {
                            "id":c.chapterId,
                             "chapterName":c.chapterName,
                            "answer": controller.text,
                            "tname":"Sanket Sarkar",
                            "tcode": teacher,
                            "scode": c.studentId,
                            "asked": DateTime.now().millisecondsSinceEpoch.toString(),
                          });

                          print(c.chapterId);
                          print(controller.text);

                          print(res.body);
                        },

                        child:Container(
                      alignment: Alignment.centerRight,
                      height:50,
                      width: 50,
                      decoration: BoxDecoration(shape: BoxShape.circle, color:Colors_pack.color),
                      child: Center(child:Icon(Icons.arrow_forward_ios, size: 40, color: Colors.white,)),
                    ))
                )

              ],
            ),
          ),

       ]
    ));
  }


}