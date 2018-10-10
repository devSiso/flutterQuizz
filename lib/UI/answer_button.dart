import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  
    final bool _type;
    final VoidCallback _onTap;

    final _style = new TextStyle(
      color: Colors.white,
      fontSize: 40.0,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic
    );
    
    AnswerButton(this._type, this._onTap);

  @override
  Widget build(BuildContext context) {

    return new Expanded(
        child: new Material(
      //true button
      color: _type == true ? Colors.greenAccent : Colors.redAccent,
      child: new InkWell(
        onTap: () => _onTap(),
        child: new Center(
          child: new Container (
            decoration: new BoxDecoration(
              border: new Border.all(color: Colors.white, width: 3.0)
            ),
            padding: new EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 8.0),
            child: new Text(_type == true ? "True" : "False", style: _style)),
        ),
      ),
    ));
  }
}