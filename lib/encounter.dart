import 'package:flutter/material.dart';
import 'package:gvp_sim_db/EncounterEnd.dart';
import 'package:gvp_sim_db/buttonData.dart';
import 'package:gvp_sim_db/gameData.dart';
import 'database/dataStorage.dart';
import 'dart:math';
import 'event.dart';
import 'eventState.dart';
import 'package:provider/provider.dart';

class Encounter extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Encounter> {
  Event _currentEvent;

  @override
  Widget build(BuildContext context) {
    _currentEvent =
        DataStorage.events[new Random().nextInt(DataStorage.EVENTCOUNT)];

    return Dialogue(firstEvent: _currentEvent);
  }
}

class Dialogue extends StatefulWidget {
  Dialogue({Key key, this.firstEvent}) : super(key: key);
  Event firstEvent;
  @override
  _DialogueState createState() => _DialogueState();
}

class _DialogueState extends State<Dialogue> {
  EventState _currentState;

  @override
  void initState() {
    super.initState();
    _currentState = (DataStorage.eventStates
        .singleWhere((f) => f.id == widget.firstEvent.initStateID));
  }

  @override
  Widget build(BuildContext context) {
    void _advance(ButtonData data) {
      if (data.isFinal) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EncounterEnd(
                      currentEvent: widget.firstEvent,
                      sentence: data.finalSentence,
                    )
            ));
      } else {
        final _newState =
            (DataStorage.eventStates.singleWhere((f) => f.id == data.nextID));
        setState(() {
          _currentState = _newState;
        });
      }
    }

    return SafeArea(
        child: Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            widget.firstEvent.personName,
            style: TextStyle(
              fontSize: 26,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none,
            ),
          ),
          Image.asset(
            widget.firstEvent.imagePath,
            height: 300,
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                border: Border.all(width: 2.0, color: Colors.black)),
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child: Text(
                _currentState.sentence,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ),
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              TableRow(
                children: [
                  ReactionButton(
                    source: _currentState.butt1,
                    advance: _advance,
                  ),
                  ReactionButton(
                    source: _currentState.butt2,
                    advance: _advance,
                  ),
                ],
              ),
              TableRow(
                children: [
                  ReactionButton(
                    source: _currentState.butt3,
                    advance: _advance,
                  ),
                  ReactionButton(
                    source: _currentState.butt4,
                    advance: _advance,
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    ));
  }
}

class ReactionButton extends StatelessWidget {
  ReactionButton({Key key, this.source, this.advance}) : super(key: key);
  final Function advance;
  final ButtonData source;

  @override
  Widget build(BuildContext context) {
    void updateStats(Map changeList) {
      GameData gameData = Provider.of<GameData>(context, listen: false);
      changeList.keys.forEach((key) {
        switch (key) {
          case 'sleep':
            gameData.sleep += changeList[key];
            gameData.currentChanges['sleep'] += changeList[key];
            break;
          case 'money':
            gameData.money += changeList[key];
            gameData.currentChanges['money'] += changeList[key];
            break;
          case 'happiness':
            gameData.happiness += changeList[key];
            gameData.currentChanges['happiness'] += changeList[key];
            break;
          case 'peerPopulariy':
            gameData.peerPopularity += changeList[key];
            gameData.currentChanges['peerPopularity'] += changeList[key];
            break;
          case 'parentPopularity':
            gameData.parentPopularity += changeList[key];
            gameData.currentChanges['parentPopularity'] += changeList[key];
            break;
          case 'teacherPopularity':
            gameData.teacherPopularity += changeList[key];
            gameData.currentChanges['teacherPopularity'] += changeList[key];
            break;
        }
      });
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      child: FlatButton(
        padding: EdgeInsets.all(5.0),
        color: Colors.blue,
        child: Text(
          source.text,
        ),
        onPressed: () {
          updateStats(source.effects);
          advance(source);
        },
      ),
    );
  }
}
