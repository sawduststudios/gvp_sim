import 'package:flutter/material.dart';
import 'package:gvp_sim_db/database/moor_database.dart';
import 'package:gvp_sim_db/buttonData.dart';
import 'package:provider/provider.dart';
import 'dart:math';

class Encounter extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Encounter> {

  Event _currentEvent;
  Future<EventState> _currentState;

  @override
  void initState() {
    super.initState();
    AppDatabase db = Provider.of<AppDatabase>(context, listen: false);
     db.getAllEvents().then( (data) {
        _currentEvent = data[new Random().nextInt(data.length)];
        print(_currentEvent.personName);
        return _currentEvent;
        }).then( (newEvent) {
          print("then");
          _currentState = db.eventStateById(newEvent.initStateId);
        });
  }

  @override
  Widget build(BuildContext context) {

    final db = Provider.of<AppDatabase>(context);

    return FutureBuilder(
      future: _currentState,
      builder: (context, snapshot) {
        switch(snapshot.data) {

        };
      },
    );
  }
}

class Dialog extends StatefulWidget {
  @override
  _DialogState createState() => _DialogState();
}

class _DialogState extends State<Dialog> {


  @override
  Widget build(BuildContext context) {
    Event _currentEvent = new Event();

    EventState _currentState = new EventState();

    void _advance(ButtonData data) {
      /*setState(() {
        db.eventStateById(data.nextID).then((newState) {_currentState = newState;});
        print(data.text);//tady se muze delat cokoli s informacema od ButtonData
      });*/
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
                _currentEvent.imagePath,
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
        )
    );
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