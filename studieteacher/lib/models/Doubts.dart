class Doubts {

  var name = "N/A";
  var role = "Student";
  var cl = "5";
  var sec = "b";
  var message = "N/A";
  var reply = "";
  DateTime time;

  Doubts(this.cl,this.sec, this.name, this.time, this.message);

  void AddReply(String rep){
    reply = rep;
  }



}