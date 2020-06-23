
class Routine {
  String title;
  String days;
  String times;
  List<Details> details;

  Routine({this.title, this.days, this.times, this.details});
}

class Details {
  String name;
  int time;
  bool checked;

  Details({this.name, this.time, this.checked});
}