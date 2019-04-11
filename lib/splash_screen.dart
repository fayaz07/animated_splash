library splash_screen;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

Widget _home;
Function _duringSplash;
String _imagePath;
int _duration;

class SplashScreen extends StatefulWidget {
  SplashScreen({@required String imagePath,@required Widget home,@required Function duringSplash,@required int duration}) {
    _home = home;
    _duration = duration;
    _duringSplash = duringSplash;
    _imagePath = imagePath;
  }

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    if (_duration < 1500) _duration = 3000;
    _animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    _animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.easeInCirc));
    _animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.reset();
  }

  @override
  Widget build(BuildContext context) {
    _duringSplash();
    Future.delayed(Duration(milliseconds: _duration)).then((value) {
      Navigator.of(context).pushReplacement(
          CupertinoPageRoute(builder: (BuildContext context) => _home));
    });
    return Scaffold(
        backgroundColor: Colors.white,
        body: FadeTransition(
            opacity: _animation,
            child: Center(
                child:
                SizedBox(height: 250.0, child: Image.asset(_imagePath)))));
  }
}

