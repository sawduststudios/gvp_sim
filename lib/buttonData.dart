class ButtonData{
  String text;
  int nextID;
  bool isFinal;
  Map effects;
  String finalSentence;
  String unlocksSkill;
  List requirements;

  ButtonData({this.requirements, this.unlocksSkill = "none", this.text, this.nextID, this.isFinal = false, this.effects = const {'sleep': 0, 'money': 0, 'happiness': 0, 'peerPopularity': 0, 'parentPopularity': 0, 'teacherPopularity': 0}, this.finalSentence});

}