import 'package:flutter/material.dart';

class GameOverPage extends StatelessWidget {
  GameOverPage({Key key, this.reason}):super(key:key);

  final String reason;

  String chooseMessage({String reason}) {
    return reason;
    switch(reason) {
      case('sleep'):
        return "";
      case('money'):
        return"";
      case('happiness'):
        return"";
      case('money'):
        return"";
      default:
        return"Neznamy duvod";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("GAME OVER"),
            Image.asset('sad_student.jpg'),
            Text(chooseMessage(reason: reason)),
            RaisedButton(
              child: Text('SAKRA!!!'),
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/HomePage'));
              },
            ),
          ]
        ),
      ),
    );
  }
}
