import 'package:flutter/material.dart';
import 'package:gvp_sim_db/database/moor_database.dart';
import 'package:gvp_sim_db/buttonData.dart';
import 'database/dataStorage.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import 'event.dart';
import 'eventState.dart';

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
    void _helpfunction(ButtonData data) {
      print("currentstateid: ${_currentState.id}");
    }


    void _advance(ButtonData data) {
      print('printing details...');
      print("current state id: ${_currentState.id}");
      print("next id: ${data.nextID}");

      final _newState = (DataStorage.eventStates.singleWhere((f) => f.id == data.nextID));
      print("new state id: ${_newState.id}");
      setState(() {
        _currentState = _newState;
        print("current state id: ${_currentState.id}");
      });
      //tady se muze delat cokoli s informacema od ButtonData
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
                  ReactionButton4(
                    source: _currentState.butt4,
                    helpfunction: _helpfunction,
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      child: FlatButton(
        padding: EdgeInsets.all(5.0),
        color: Colors.blue,
        child: Text(
          source.text,
        ),
        onPressed: () {
          advance(source);
        },
      ),
    );
  }
}

class ReactionButton4 extends StatelessWidget {
  ReactionButton4({Key key, this.source, this.helpfunction}) : super(key: key);
  final Function helpfunction;
  final ButtonData source;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      child: FlatButton(
        padding: EdgeInsets.all(5.0),
        color: Colors.blue,
        child: Text(
          source.text,
        ),
        onPressed: () {
          helpfunction(source);
        },
      ),
    );
  }
}