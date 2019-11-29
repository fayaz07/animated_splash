import 'package:flutter/material.dart';
import 'package:animated_splash/animated_splash.dart';

void main() {
  Future<Widget> customFunction() {
    print('Something background process');
    int a = 123 + 23;
    print(a);

    if (a > 100)
      return Future.value(Home());
    else
      return Future.value(HomeSt());
  }

  runApp(MaterialApp(
    home: AnimatedSplash.styled(
      customFunction: customFunction(),
      imagePath: 'assets/flutter_icon.png',
      style: AnimationStyle.CircularReveal,
      curve: Curves.linear,
    ),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<Widget> _backgroundProcess;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: Center(
            child: Text('My Cool App',
                style: TextStyle(color: Colors.black, fontSize: 20.0))));
  }
}

class HomeSt extends StatefulWidget {
  @override
  _HomeStState createState() => _HomeStState();
}

class _HomeStState extends State<HomeSt> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: Center(
            child: Text('My Cool App home page 2',
                style: TextStyle(color: Colors.black, fontSize: 20.0))));
  }
}
