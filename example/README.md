import 'package:flutter/material.dart';
import 'test.dart';

void main() {
  Function duringSplash = () {
    print('Something background process');
    int a = 123 + 23;
    print(a);
  };

  runApp(MaterialApp(
    home: SplashScreen(
        imagePath: 'assets/flutter_icon.png',
        home: Home(),
        duringSplash: duringSplash,
        duration: 2500),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
