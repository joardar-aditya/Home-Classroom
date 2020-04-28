import 'package:flutter/material.dart';
import 'package:flutterapp/Chapters/container_chapters.dart';
import 'package:flutterapp/Color/colors.dart';
import 'package:flutterapp/model/Chapter.dart';
import 'package:flutterapp/model/Chapter_model.dart';
import 'package:flutterapp/model/Doubts.dart';
import 'package:flutterapp/model/doubts_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class chapters_details extends StatefulWidget {
  Chapter _c;
  chapters_details(this._c);
  @override
  State<StatefulWidget> createState() => _stateDetails(_c);


}

class _stateDetails extends State<chapters_details> {
  Chapter _c;
  _stateDetails(this._c);

  GlobalKey<ScaffoldState> globalKey = new GlobalKey();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: globalKey,
        appBar:  AppBar(
          elevation: 0.0,
          leading: RaisedButton(color:Colors.white, elevation:0.0, onPressed:() {Navigator.pop(context);},child:Image(image:AssetImage('assets/back.png'), height: 50,) ),
          title: Text('Chapter Details', style: TextStyle(color:Colors_pack.color, fontWeight: FontWeight.w700, fontSize: 28),),
        ),
      body: Consumer<doubts_model>(builder: (context, model,child) {
        return ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(color:Colors_pack.color,
            borderRadius: BorderRadius.circular(10),
            ),
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Text(_c.Name, style: TextStyle(color:Colors.white, fontSize: 24,fontWeight: FontWeight.bold ),),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(child:Text('Class 1 Sec a', style: TextStyle(color:Colors.grey[400], fontSize: 20, fontWeight: FontWeight.bold),),
                      ),Align(alignment: Alignment.centerRight,child: Text(_c.subject,style: TextStyle(color:Colors.grey[400], fontSize: 20, fontWeight: FontWeight.bold), ),)

                    ],
                  ),
                )
              ],
            )
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: Text('Ask a Question', style: TextStyle(color: Colors.black, fontSize: 26, fontWeight: FontWeight.bold),),
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
                      onChanged: (v) {
                        model.ChangeQuestion(v);
                        model.CurrentChapter(_c);
                      },
                      decoration: InputDecoration(
                        hintStyle: TextStyle(color:Colors.pinkAccent, fontSize: 16),
                        hintText: "Add a Question",
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
                                                        onPressed: () {

                                                        },
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
                        onTap: () {
                               model.NewDoubt(model.Current_Question, model.GetFile);
                        },
                        child:InkWell(
                            onTap: () {
                              AddDoubts(model);
                            },
                            child:Container(
                      alignment: Alignment.centerRight,
                      height:50,
                      width: 50,
                      decoration: BoxDecoration(shape: BoxShape.circle, color:Colors_pack.color),
                      child: Center(child:Icon(Icons.arrow_forward_ios, size: 40, color: Colors.white,)),
                    )))
                )

              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: Text('Doubts', style: TextStyle(color: Colors_pack.color, fontSize: 30, fontWeight: FontWeight.bold),),
          ),
          (_c.doubts.isEmpty)?Container(margin:EdgeInsets.symmetric(vertical:150),child: Center(child: Text("No Doubts are available for now!"),),):
          ListView.builder(itemCount:_c.doubts.length,shrinkWrap: true, physics:NeverScrollableScrollPhysics(),itemBuilder: (context, ind) {
            return container_chapters(_c.doubts[ind]);
          ;})
        ],
      );})
    );
  }

  void AddDoubts(doubts_model model) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String code = sharedPreferences.getString("user");
    print(code);
    String teacher = sharedPreferences.getString("tcode");
    String school = sharedPreferences.getString("icode");
    String name = sharedPreferences.getString("name");
    String cl = sharedPreferences.getString("class");
    String se = sharedPreferences.getString("section");
    Uri uri = Uri.https("studie-server-dot-project-student-management.appspot.com", "student/chapters/doubts/$school/$cl/$se",);
    var res = await http.post(uri, body: {
      "id":_c.Id,
      "chapterName":_c.Name,
      "doubtText":model.Current_Question,
      "scode":teacher,
      "sname":name

    }, headers: {
      "x-access-token":code,
      "type":"student"
    });

    if(res.statusCode == 200){
      globalKey.currentState.showSnackBar(SnackBar(content: Text(res.body),));
      model.AddDoubt(Doubts(null,"Aditya", "1", "a",DateTime.now(), "student"));
    }


  }
}