class Announce {
   var section;
   var date;
   String title;
   var filepath = "index.txt";

   Announce(this.section, this.date, this.title);

   String get Date {
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(date.toString()));
      String min = "${DateTime.now().difference(dateTime).inMinutes} minutes ago";
      if(DateTime.now().difference(dateTime).inMinutes>60){
         min = "${DateTime.now().difference(dateTime).inHours} Hours ago";
         if(DateTime.now().difference(dateTime).inHours>24){
            min = "${DateTime.now().difference(dateTime).inDays} days ago";
         }

         }
      return " ${dateTime.day} ${dateTime.month} ${dateTime.year} ($min)";
   }
}