class Doubts {

  var name = "N/A";
  var role = "Student";
  var cl = "5";
  var sec = "b";
  var message = "N/A";
  var reply = "";
  var chapterName = "";
  var chapterId = "";
  var studentId = "";
  DateTime time;

  Doubts(this.cl,this.sec, this.name, this.time, this.message, this.chapterName, this.chapterId, this.studentId);

  void AddReply(String rep){
    reply = rep;
  }



}