import 'package:flutter/material.dart';

import './quizz_page.dart';

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
        onTap: () => Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new QuizzPage())),
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
