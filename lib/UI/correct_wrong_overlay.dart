import 'dart:math';
import 'package:flutter/material.dart';

class CorrectWrongOverlay extends StatefulWidget {
  final bool _isCorrect;

  CorrectWrongOverlay(this._isCorrect);

  @override
  State createState() => CorrectWrongOverlayState();
}

class CorrectWrongOverlayState extends State<CorrectWrongOverlay>
    with SingleTickerProviderStateMixin {
  final _textStyle = new TextStyle(fontSize: 30.0, color: Colors.white);

  Animation<double> _iconAnimation;
  AnimationController _iconAnimationController;

  @override
  void initState() {
    super.initState();
    _iconAnimationController = new AnimationController(
        duration: new Duration(seconds: 2), vsync: this);
    _iconAnimation = new CurvedAnimation(
        parent: _iconAnimationController, curve: Curves.elasticOut);
    _iconAnimation.addListener(() => this.setState(() {}));
    _iconAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.black54,
      child: new InkWell(
        onTap: () => print("You was tapped the overlay"),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(
              decoration:
                  BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              child: new Transform.rotate(
                  angle: _iconAnimation.value * 2 * pi,
                  child: new Icon(
                      widget._isCorrect == true ? Icons.done : Icons.clear,
                      size: _iconAnimation.value * 80.0)),
            ),
            new Padding(padding: EdgeInsets.only(bottom: 20.0)),
            new Text(widget._isCorrect == true ? "Correct!" : "Wrong!",
                style: _textStyle)
          ],
        ),
      ),
    );
  }
}
