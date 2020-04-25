import 'package:flutter/material.dart';

class GameOverPage extends StatelessWidget {
  GameOverPage({Key key, this.reason}):super(key:key);

  final String reason;

  String chooseMessage({String reason}) {
    switch(reason) {
      //todo: Více zpráv pro každý case. Bude se z nich vybírat náhodně.
      case('sleep'):
        return "Byl jsi tak unavený, že tě nevzbudilo ani rachtání kánoe sklouzávající do řeky "
            "ani šplouchání vln okolo. Když jsi se ráno vzbudil, byl jsi už v Rumusku. "
            "S trochou štěstí tě místní kmen přijme za svého a nechá pást ovce.";
//        return "Potom, co si se už týden pořádně nevyspal, jsi zkolaboval u automatu ve třetím patře. "
//            "Spadl jsi na něj, až se na tebe vysypaly horalky. "
//            "Projevila se tvá skrytá alergie na buráky a ani "
//            "resuscitace od školníka tě před jejich stopami v sušenkách nezachránila.";
      case('money'):
        return"Nemáš už ani floka. Natož na příspěvek na puštíka. "
            "Oficiálně jsou příspěvky dobrovolné, ale oba moc dobře víme, "
            "že na GVP už nemůžeš zůstat.";
      case('happiness'):
        return"Už jsi nesnesl všechen ten stres. "
            "Naštěstí ti ten divnej předmaturant střelil ta koňská sedativa. "
            "Proč na tebe všichni tolik zírají?!? "
            "Tolik očí, tolik očí...";
      case('peer'):
        return"Stal ses obětí brutální šikany ve školní knihovně. Nikdo ve třídě tě nemá rád!";
      case('parent'):
        return"\"Tak to byla poslední kapka. Zkus si žít na ulici ty grázle!\"\n- tvoje máma";
      case('teacher'):
        return"Že jsi byl na zeměpisné olympiádě? To mě nezajímá. Nechám tě rupnout!";
      default:
        return"Neznamý důvod";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(
                  Icons.settings
              ),
              onPressed: () {Navigator.pushNamed(context, '/SettingsPage');},
            )]
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 15,),
            Text("GAME OVER!",
            style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: 50),),
            SizedBox(height: 10,),
            Expanded(child: Image.asset('images/poseroutka.png')),
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(width: 2.0, color: Theme.of(context).primaryColor)),
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    chooseMessage(reason: reason),
                    style: Theme.of(context).textTheme.body1,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            SizedBox(height: 15,),
            RaisedButton(
              color: Theme.of(context).primaryColor,
              child: Text('SAKRA!!!', style: TextStyle(fontSize: 50, color: Colors.white),),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(height: 25),
          ]
        ),
      ),
    );
  }
}
