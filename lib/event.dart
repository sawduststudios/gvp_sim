import 'package:gvp_sim_db/eventState.dart';

class Event {
  String personName;
  String imagePath;
  int initStateID;
  EventState currentState;
  Map<int, EventState> allStates;

  Event({this.personName, this.imagePath, this.initStateID, this.allStates}) {
    this.currentState = this.allStates[initStateID];
  }
}