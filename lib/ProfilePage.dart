import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Odpoledne'),
        centerTitle: true,
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add_circle_outline,
          size: 35,
        ),
        backgroundColor: Colors.blue[900],
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      body: Container(
        padding: EdgeInsets.all(5.0),
        child: Text('HAHA'),

      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        shape: CircularNotchedRectangle(),
        notchMargin: 4.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.white,
                size: 30,
              ),
              onPressed: (){},
            ),
            IconButton(
              icon: Icon(
                Icons.remove,
                color: Colors.white,
                size: 30,
              ),
              onPressed: (){},
            ),
          ],
        ),

      ),
    );
  }
}