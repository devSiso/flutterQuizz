import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  final _title = new TextStyle(
      color: Colors.white, fontSize: 50.0, fontWeight: FontWeight.bold);

  final _subTitle = new TextStyle(
      color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.greenAccent,
      child: new InkWell(
        onTap: () => print("We tapped the page, you pepe."),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text("Lets Quizzz", style: _title),
            new Text("Tap to start",
                style: _subTitle)
          ],
        ),
      ),
    );
  }
}
