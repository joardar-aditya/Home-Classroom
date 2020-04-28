class Notes {
  DateTime dateTime;
  String name;
  List<String> months = ["", "JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC" ];
  List<String> weekDays = ["", "MON", "TUE", "WED", "THR", "FRI", "SAT", "SUN"];
  String get Date {
    if(dateTime == null){
      return "No Date Found";
    }
    return "${dateTime.day.toString()} ${months[dateTime.month]} ${weekDays[dateTime.weekday]} ${dateTime.year.toString()}";

  }


  Notes(this.dateTime, this.name);
}