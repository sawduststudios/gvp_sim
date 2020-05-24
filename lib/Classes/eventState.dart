import 'package:gvp_sim_db/Classes/buttonData.dart';

/// EventState uklada jednu fazi Encounteru, ma:
/// Svoje ID, Nadpis (PersonName), jmeno obrazku (imagePath),
/// 4 ButtonData pro 4 odpovedi hrace, text (sentence).
/// Novy EventState se z DataStorage nacita v kazdem kroku Encounteru.
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