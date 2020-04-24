import 'package:flutter/material.dart';
import "package:gvp_sim_db/database/moor_database.dart";
import 'package:gvp_sim_db/buttonData.dart';
import 'package:gvp_sim_db/event.dart';
import 'package:gvp_sim_db/eventState.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class DataStorage {

  static const SKILLCOUNT = 8;
  static const EVENTCOUNT = 3;
  static const EVENTSTATECOUNT = 4;

  static List<Skill> skills = [
    Skill(
      name: "Kytara",
      currentHours: 0,
      currentLevel: 2,
      levelUp: [5,3,5,18],
      available: true,
    ),
    Skill(
      name: "Diplomacie",
      currentHours: 0,
      currentLevel: 1,
      levelUp: [1,4,5],
      available: true,
    ),
    Skill(
      name: "Balls",
      currentHours: 0,
      currentLevel: 0,
      levelUp: [2,1,6,10,14,15,20],
      available: true,
    ),
    Skill(
      name: 'Flutter',
      currentHours: 0,
      currentLevel: 3,
      levelUp: [5,8,10,15,25,80],
      available: true,
    ),
    Skill(
      name: "Fotbal",
      currentHours: 0,
      currentLevel: 3,
      levelUp: [3,5,8,10,15],
      available: true,
    ),
    Skill(
      name: "Šplhoun",
      currentHours: 0,
      currentLevel: 0,
      levelUp: [6,8,10,12,15],
      available: false,
    ),
    Skill(
      name: 'Pythágorovka',
      currentHours: 0,
      currentLevel: 0,
      levelUp: [10,15,18,20],
      available: false,
    ),
    Skill(
      name: "Parkur",
      currentHours: 0,
      currentLevel: 0,
      levelUp: [6,8,10],
      available: false,
    ),
  ];

  static  Map<String, IconData> skillIcons= {
    'Kytara' : MdiIcons.guitarAcoustic,
    'Flutter' : MdiIcons.xml,
    'Diplomacie' : MdiIcons.newspaper,
    'Balls' : MdiIcons.pokeball,
    "Šplhoun" : MdiIcons.glasses,
    "Fotbal" : MdiIcons.soccer,
    'Pythágorovka' : MdiIcons.triangleOutline,
    "Parkur" : MdiIcons.jumpRope,

  };

//todo: tvuj program dela initStateID s malym 'd'
  static List<Event> events = [

    Event(
      id: 102,
      personName: "Před školou",
      imagePath: "images/skola.jpg",
      initStateID: 10220,
    ),
    Event(
      id: 103,
      personName: "Winkler",
      imagePath: "images/winkler.jpg",
      initStateID: 10310,
    ),
    Event(
      id: 104,
      personName: "Jaroslav Mervínský",
      initStateID: 10410,
      imagePath: "images/merva.png",
    ),
  ];

  static List<EventState> eventStates = [
    EventState(
      id: 10220,
      sentence: "Stojíš před školou. Kam půjdeš?",
      butt1: ButtonData(text: "do bufetu", nextID: 10220, isFinal: true),
      butt2: ButtonData(text: "na hřiště", nextID: 10220, isFinal: true),
      butt3: ButtonData(text: "do ředitelny", nextID: 10220, isFinal: true, finalSentence: "bla"),
      butt4: ButtonData(text: "do žabky", nextID: 10220, isFinal: true),
    ),
    EventState(
      id: 10310,
      sentence: "Už chceš vyrazit, ale najednou tě zastaví Winkler.\n'Ahooj, co ty tady?', říká.",
      butt1: ButtonData(text: "mlčet", nextID: 10320),
      butt2: ButtonData(text: "utéct", nextID: 10320),
      butt3: ButtonData(text: "jdu za ředitelem", nextID: 10320),
      butt4: ButtonData(text: "uh.. Máte KUPEDAMIS", nextID: 10320, effects: {'happiness': -5, 'teacherPopularity': -5}),
    ),
    EventState(
      id: 10320,
      sentence: "Jasně že mám. A víš co v něm mám? Tvojí písemku z pythágorovky. Dostals kouli! ",
      butt1: ButtonData(text: "utéct", nextID: 10220, isFinal: true, finalSentence: "Kouli? Cože?!? Měl jsem se víc učit! Konečně dorážíš k ředitelně. Je na čase vybojovat levnější obědy!"),
      butt2: ButtonData(text: "utéct", nextID: 10220, isFinal: true, finalSentence: "Kouli? Cože?!? Měl jsem se víc učit! Konečně dorážíš k ředitelně. Je na čase vybojovat levnější obědy!"),
      butt3: ButtonData(text: "utéct", nextID: 10220, isFinal: true, finalSentence: "Kouli? Cože?!? Měl jsem se víc učit! Konečně dorážíš k ředitelně. Je na čase vybojovat levnější obědy!"),
      butt4: ButtonData(text: "utéct", nextID: 10220, isFinal: true, finalSentence: "Kouli? Cože?!? Měl jsem se víc učit! Konečně dorážíš k ředitelně. Je na čase vybojovat levnější obědy!"),
    ),
    EventState(
      id: 10410,
      sentence: "Vcházíš do ředitelny. Nemůžeš si nevšimnout pachu moci. Přeběhne ti mráz po zádech. Nejedno studium již zde bylo ukončeno.\n'Přejete si?'",
      butt1: ButtonData(text: "mluvit o počasí", nextID: 10220),
      butt2: ButtonData(text: "snižme cenu obědů", nextID: 10220, requirements: ["Diplomacie", 3]),
      butt3: ButtonData(text: "mluvit o absenci", nextID: 10420),
      butt4: ButtonData(text: "mlčet", nextID: 10220, isFinal: true),
    ),
    EventState(
      id: 10420,
      sentence: "'No.. Víte, mám teď hodně velkou absenci z-'\n'Matematiky? Tak co kdybych vás přihlásil na matematickou olympiádu a smázneme to?'",
      butt1: ButtonData(text: "matiku neumím", nextID: 10220),
      butt2: ButtonData(text: "na to kašlu", nextID: 10220, requirements: ["Balls", 8]),
      butt3: ButtonData(text: "mlčet", nextID: 10220),
      butt4: ButtonData(text: "no dobře...", nextID: 10220, unlocksSkill: "Šplhoun",effects: {'happiness': -30, 'teacherPopularity': 15}, isFinal: true, finalSentence: "Tak a je to. S porážkou odcházíš domů si opakovat pythágorovku..."),
    ),
  ];
}