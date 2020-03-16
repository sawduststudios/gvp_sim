import 'package:flutter/material.dart';
import 'package:gvp_sim_db/database/moor_database.dart';
import 'package:gvp_sim_db/buttonData.dart';

class Encounter extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Encounter> {
  Event _currentEvent = Event(
    //Event({this.personName, this.imagePath, this.initStateID, this.allStates})
      personName: 'Batman',
      imagePath: 'images/batman.png',
      initStateId: 0,
  );
  Map<int, EventState> _allEventStates = {
    0: EventState(
      sentence: "NA NA NA NA NA NA NA NA BATMAAAAAAN",
      butt1: ButtonData(text: 'Jedna', nextID: 1),
      butt2: ButtonData(text: 'Dva', nextID: 1),
      butt3: ButtonData(text: 'Tri', nextID: 1),
      butt4: ButtonData(text: 'Ctyri', nextID: 1),
    ),
    1: EventState(
      sentence: "OMAE WA MO - SHINDEIRU! NANI?!?!?",
      butt1: ButtonData(text: 'die', nextID: 0),
      butt2: ButtonData(text: 'hard', nextID: 0),
      butt3: ButtonData(text: 'harder', nextID: 0),
      butt4: ButtonData(text: 'daddy', nextID: 0),
    )
  };
  EventState _currentState;

  @override
  Widget build(BuildContext context) {

    void _advance(ButtonData data) {
      setState(() {
        _currentState = _allEventStates[data.nextID];
        print(data.text);//tady se muze delat cokoli s informacema od ButtonData
      });
    }

    return SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                _currentEvent.personName,
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                ),
              ),
              Image.asset(
                '${_currentEvent.imagePath}',
                height: 300,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(width: 2.0, color: Colors.black)
                ),
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