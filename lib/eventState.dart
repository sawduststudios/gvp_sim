import 'package:gvp_sim_db/buttonData.dart';

class EventState {
  int id;
  ButtonData butt1;
  ButtonData butt2;
  ButtonData butt3;
  ButtonData butt4;
  String sentence;
  bool isFinal;

  EventState({this.sentence, this.butt1, this.butt2, this.butt3, this.butt4, this.isFinal = false, this.id});
}