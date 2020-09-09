import 'package:flutter/material.dart';

class AnimationH {
  static Widget createUpBoxLogo(BuildContext context, sizeAnimation) {
    return Container(
      width: 550.0,
      height: 300.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Theme.of(context).accentColor,
              Theme.of(context).primaryColor,
              Theme.of(context).accentColor
            ],
            stops: [
              0.3,
              1,
              0.5
            ],
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(200.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.8),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: sizeAnimation,
              height: sizeAnimation,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Image.asset("assets/data/image/icon_white.png"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "HandDoc",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 17.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}
