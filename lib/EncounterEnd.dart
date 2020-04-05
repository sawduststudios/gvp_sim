import 'package:flutter/material.dart';

class EncounterEnd extends StatelessWidget {
  EncounterEnd({Key key, this.currentEvent, this.sentence}) : super(key: key);
  final currentEvent;
  final sentence;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                currentEvent.personName,
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                ),
              ),
              Image.asset(
                currentEvent.imagePath,
                height: 300,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(width: 2.0, color: Colors.black)),
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                    "lasjhfka",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ),
              FloatingActionButton(
                child: Icon(
                    Icons.check,
                    size: 35),
                backgroundColor: Colors.blue[900],
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                onPressed: () {
                  Navigator.pushNamed(context, "/ProfilePage");
                },
              ),
            ],
          ),
        )
    );
  }
}
