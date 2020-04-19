import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Color/colors.dart';
import 'package:flutterapp/basics/appbar_sab.dart';
import 'package:flutterapp/homework/homework_details.dart';
import 'package:flutterapp/model/homework_model.dart';
import 'package:provider/provider.dart';

class homework_start extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _stateHstart();


}

class _stateHstart extends State<homework_start>{


  var status = "loading";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkStatus();
  }

  void checkStatus() async{
    Homework_model model1 = new Homework_model();
    bool c = await model1.GetHomework();
    if(c){
      setState(() {
        status = "done";
      });
    }else{
      setState(() {
        status = "not done";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: RaisedButton(color:Colors.white, elevation:0.0, onPressed:() {Navigator.pop(context);},child:Image(image:AssetImage('assets/back.png'), height: 50,) ),
        title: Text('Homework', style: TextStyle(color:Colors_pack.color, fontWeight: FontWeight.w700, fontSize: 28),),
        elevation: 0.0,
      ),
      body:Container(
          child:
              (status == "loading")?Container(child: Center(child: CircularProgressIndicator(),),):(status=="done")?Consumer<Homework_model>(builder:(context, model, index){ return Container(child:ListView.builder(
                  itemCount: model.homeworks.length,
                  itemBuilder: (context, ind){
                  return InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => homework_details(model.homeworks[ind])));
                      },
                      child:Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color:Colors_pack.color,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child:Text(model.homeworks[ind].Title, style: TextStyle(color:Colors.white, fontWeight: FontWeight.bold, fontSize: 32),)
                          ,margin:EdgeInsets.symmetric(vertical:10),
                        ),
                        Container(
                        margin:EdgeInsets.symmetric(vertical:10),
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(model.homeworks[ind].Author, style: TextStyle(color:Colors.white, fontSize: 22),),
                              Text(model.homeworks[ind].Subject, style: TextStyle(color: Colors.white, fontSize: 22),),
                            ],
                          )
                        )
                      ],
                    ),
                  ));
              })
              );}):Container(margin: EdgeInsets.symmetric(vertical: 50),child: Text("Homework Not Available"),),

        ));
  }

}