import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Color/colors.dart';
import 'package:flutterapp/Exams/exam.dart';
import 'package:flutterapp/Exams/indi_test_container.dart';
import 'package:flutterapp/Exams/upcoming_exam.dart';
import 'package:flutterapp/model/Exam_model.dart';
import 'package:provider/provider.dart';



class examOverview extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _stateExam();

}





class _stateExam extends State<examOverview> {

  var state1 = "done";
  var state2 = "done";
  var text_field_1 = Container(
    margin: EdgeInsets.all(10.0),
    child: Text(
      'Upcoming Class Tests',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
    ),
  );
  var text_field_2 = Container(
    margin: EdgeInsets.all(10.0),
    child: Text(
      'Previous Class Tests',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
    ),
  );



  var _currentMonth;
  static List<String> _months = <String>[
    "JAN",
    "FEB",
    "MAR",
    "APR",
    "MAY",
    "JUN",
    "JUL",
    "AUG",
    "SEP",
    "OCT",
    "NOV",
    "DEC"
  ];

  List<String> weeks = ["MON", "TUE", "WED", "THR", "FRI", "SAT", "SUN"];

  final _years = List<String>.generate(50, (i) => (2000 + i).toString()).toList(
      growable: false);
  var _currentYear = "2020";

  void initState(){
    // TODO: implement initState
    var current = DateTime.now();
    _currentMonth = _months.elementAt(current.month - 1);
    _currentYear = current.year.toString();
    InitLoad();
  }

  void InitLoad() async {
    exam_model model = new exam_model();
    bool value = await model.GetExams();
    bool value2 = await model.GetPrevious(_months.indexOf(_currentMonth) + 1, int.parse(_currentYear));
    setState(() {
      _loading = false;
    });

    if(!value && !value2){
      //do nothing
      setState(() {
        state1 = "not done";
        state2 = "not done";
      });
      return;
    }else if (!value){
         setState(() {
           state1 = "not done";
         });
    }else if (!value2){
      setState(() {
        state2 = "not done";
      });
    }
}




  void _changeYear(String val) {
    setState(() {
      _currentYear = val;
    });
  }

  void _changeMonth(String value) {
    setState(() {
      _currentMonth = value;
    });
  }





  var test_details = Container(
    height: 160.0,
    margin: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0), color: Colors_pack.color),
    child: Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Flexible(
              flex: 2,
              fit: FlexFit.loose,
              child: Container(
                height: 24.0,
                  margin: EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Center(
                    child: Padding(padding:EdgeInsets.all(3.0),child:Text(
                      '1 JAN MON 2020',
                      style: TextStyle(color: Colors_pack.color, fontSize: 18.0),
                    ),
                  )))),
          Flexible(
              flex: 3,
              child: Container(
                  child: Center(
                    child: Text(
                      'Class Test 001',
                      style: TextStyle(
                        fontSize: 24.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,),
                    ),
                  ))),
          Flexible(
              flex: 1,
              child: Container(
                  child: Center(
                    child: Text(
                      'Mathematics',
                      style: TextStyle(
                        color: Colors.grey[200],
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,),
                    ),
                  ))),
        ],
      ),
    ),
  );

  List<String> _testTypes = ["Class Test", "MidTerm Test", "Final Test"];
  var _loading =true;

  @override
  Widget build(BuildContext context) {


    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          leading: RaisedButton(color:Colors.white, elevation:0.0, onPressed:() {Navigator.pop(context);},child:Image(image:AssetImage('assets/back.png'), height: 50,) ),
          title: Text('Exam', style: TextStyle(color: Colors_pack.color, fontWeight: FontWeight.w700, fontSize: 28),),
        ),
        body: Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Flexible(
            flex: 1,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder:(context, ind) {
                return Consumer<exam_model>(builder:(context, model, child){return Container(
                    margin: EdgeInsets.all(10.0),
                    child: RaisedButton(
                      onPressed: () async{
                        setState(() {
                          _loading = true;
                        });
                        model.ChangeCat(ind+1);
                        bool value = await model.GetExams();
                        print(value);
                        setState(() {
                           if(value){
                             _loading =false;
                           }
                        });
                      },
                      shape:
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                      color: (model.Current==(ind+1))?Colors_pack.color:Colors.white,
                      child: Text(_testTypes[ind],
                          style: TextStyle(
                              color: (model.Current==(ind+1))?Colors.white:Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold)),
                    ));});;

  }
            ),
          ),
          Flexible(
            flex: 1,
            child: text_field_1,
          ),
          _loading?Container(
              width: 200,
              child:Center(child:CircularProgressIndicator())):Flexible(flex:3,
              child: (state1=="not done")?Container(
                child:Center(
                  child: Text("Upcomimg tests Not Available"),
                )
              ):Consumer<exam_model>(builder:(context, model, child){
                return
                (model.UpcomingExams.isEmpty)?Container(child: Center(child: Text("No Upcoming Tests Available"),),):ListView.builder(
                    itemCount:_loading?4:model.UpcomingExams.length,
                    scrollDirection: Axis.horizontal,
          itemBuilder: (context, ind) {
                      DateTime current = model.UpcomingExams[ind].Date;
                return InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => upcoming_exam(model.UpcomingExams[ind])));
                    },
                    child:FittedBox(fit:BoxFit.contain,child:Container(
                  height: 160.0,
                  margin: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0), color: Colors_pack.color),
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Flexible(
                            flex: 2,
                            fit: FlexFit.loose,
                            child: Container(
                                height: 24.0,
                                margin: EdgeInsets.all(4.0),
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Center(
                                    child: Padding(padding:EdgeInsets.all(3.0),child:Text(
                                      current.day.toString() +" "+ weeks[current.weekday -1] +" "+ _months[current.month-1]+" "+ current.year.toString(),
                                      style: TextStyle(color: Colors_pack.color, fontSize: 18.0),
                                    ),
                                    )))),
                        Flexible(
                            flex: 3,
                            child: Container(
                                child: Center(
                                  child: Text(
                                    model.UpcomingExams[ind].Title,
                                    style: TextStyle(
                                      fontSize: 24.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,),
                                  ),
                                ))),
                        Flexible(
                            flex: 1,
                            child: Container(
                                child: Center(
                                  child: Text(
                                    model.UpcomingExams[ind].subject,
                                    style: TextStyle(
                                      color: Colors.grey[200],
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,),
                                  ),
                                ))),
                      ],
                    ),
                  ),
                )));
          },);})),
          Flexible(
              fit: FlexFit.loose,
              flex: 2,
              child: Container(
                  height: 60.0,
                  child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child:Row(

                        children: <Widget>[
                          Padding(padding: EdgeInsets.all(10), child:
                          FittedBox(
                              fit: BoxFit.contain,
                              child:Text("Month", style: TextStyle(color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24),))),

                          Consumer<exam_model>(builder: (context, model, child) { return Padding(padding: EdgeInsets.symmetric(horizontal: 5), child:
                          DropdownButton<String>(
                            value: _currentMonth,
                            onChanged: (String string) { _changeMonth(string);
                               model.ChangeMonth(_months.indexOf(string) + 1);
                            },
                            underline: Container(),
                            iconSize: 0,
                            selectedItemBuilder: (BuildContext context) {
                              return _months.map<Widget>((String item) {
                                return FittedBox(
                                    fit: BoxFit.contain,
                                    child:Container(
                                        width: 100,
                                        decoration: BoxDecoration(
                                            color: Color(0xff261FFF),
                                            borderRadius: BorderRadius.circular(5)
                                        ),
                                        child: Center(child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(item, style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  color: Colors.white),),
                                              Container(margin: EdgeInsets.all(10),
                                                height: 15,
                                                width: 15,
                                                decoration: BoxDecoration(
                                                    color: Colors.blue[200],
                                                    shape: BoxShape.circle),)
                                            ]))));
                              }).toList();
                            },
                            items: _months.map((String item) {
                              return DropdownMenuItem<String>(
                                child: Text('$item'),
                                value: item,
                              );
                            }).toList(),
                          ),);}),
                          Padding(padding: EdgeInsets.all(10), child:
                          FittedBox(
                              fit: BoxFit.contain,
                              child:Text("Year", style: TextStyle(color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24),))),

                          Consumer<exam_model>(builder:(context, model, child) { return Padding(padding: EdgeInsets.symmetric(horizontal: 5), child:
                          DropdownButton<String>(
                            value: _currentYear,
                            onChanged: (String string){ _changeYear(string);
                               model.ChangeYear(int.parse(string));
                            },
                            underline: Container(),
                            iconSize: 0,
                            selectedItemBuilder: (BuildContext context) {
                              return _years.map<Widget>((String item) {
                                return FittedBox(
                                    fit: BoxFit.contain,
                                    child:Container(
                                        width: 100,
                                        decoration: BoxDecoration(
                                            color: Color(0xff261FFF),
                                            borderRadius: BorderRadius.circular(5)
                                        ),
                                        child: Center(child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(item, style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  color: Colors.white),),
                                              Container(margin: EdgeInsets.all(10),
                                                height: 15,
                                                width: 15,
                                                decoration: BoxDecoration(
                                                    color: Colors.blue[200],
                                                    shape: BoxShape.circle),)
                                            ]),
                                        )));
                              }).toList();
                            },
                            items: _years.map((String item) {
                              return DropdownMenuItem<String>(
                                child: Text('$item'),
                                value: item,
                              );
                            }).toList(),
                          ),);}),


                        ],
                      )),)),
          Flexible(flex: 1, child: text_field_2),
          (_loading)?Container(child:Center(child:CircularProgressIndicator())):(state2=="not done")?Container(margin:EdgeInsets.symmetric(vertical: 50), child: Center(child: Text("Previous Tests Not Found"),),):Consumer<exam_model>(builder: (context, model, child) { return Flexible(
            flex: 5,
            child: (model.PreviousExams.isEmpty)?Container(margin:EdgeInsets.symmetric(vertical: 50), child: Center(child: Text("No Previous Tests for you"),),)
            :ListView.builder(
              itemCount: model.PreviousExams.length,
              itemBuilder: (context, item) {
                return indieTest(model.PreviousExams[item]);
              },
            ),
          );})
        ],
      ),
    ));
  }
}
