import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  //HomePage({Key key}): super(key : key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              IconButton(
                icon: Icon(
                    Icons.settings
                  //color: ,
                ),
                onPressed: (){},
              )
            ],
          )
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'GVP SIMULATOR',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 36,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Image.asset(
              'images/sova.jpg',
              height: 150,
            ),
            SizedBox(
              height: 20,
            ),
            MaterialButton(
              color: Colors.grey[400],
              child: Text(
                'CONTINUE',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              onPressed: () {Navigator.pushNamed(context, '/Encounter');},
            ),
            SizedBox(
              height: 30,
            ),
            MaterialButton(
              color: Colors.grey[400],
              child: Text(
                'NEW GAME',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              onPressed: (){Navigator.pushNamed(context, '/SkillPage');},
            ),
          ],
        ),
      ),
    );
  }
}