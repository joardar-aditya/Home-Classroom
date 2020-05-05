import 'dart:ui';

class Groups {
  String name;
  List<String> members = [];
  String icon;
  String id;


  void ChangeId(String I){
    id = I;
  }

  void MembersAdd(String member){
    members.add(member);
  }

  void AddIcon(String i){
    icon = i;
  }

  void ChangeName(String n){
    name = n;
  }
}