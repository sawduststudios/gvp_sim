import 'package:gvp_sim_db/buttonData.dart';

class EventState {
  int id;
  String personName;
  String imagePath;
  ButtonData butt1;
  ButtonData butt2;
  ButtonData butt3;
  ButtonData butt4;
  String sentence;


  EventState({this.sentence, this.butt1, this.butt2, this.butt3, this.butt4, this.id, this.personName, this.imagePath});
}