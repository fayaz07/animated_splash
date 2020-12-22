import 'package:flutter/material.dart';
import 'package:animated_splash/animated_splash.dart';

Future doSomethingInBackground() async {
  debugPrint("doing bg task");
  await Future.delayed(Duration(seconds: 3));
  debugPrint("bg task done");
}

void main() {
  runApp(
    MaterialApp(
      home: MySplashScreen(),
    ),
  );
}

class MySplashScreen extends StatelessWidget {
  Widget _stillSplashExample(BuildContext context) {
    return AnimatedSplash(
      imagePath: 'assets/flutter_icon.png',
      style: AnimationStyle.Still,
      curve: Curves.linear,
      doInBackground: doSomethingInBackground(),
      onAnimationCompleted: () {
        debugPrint("animation is completed");
      },
      onReadyToGoNextScreen: () => moveToHomeScreen(context),
    );
  }

  void moveToHomeScreen(BuildContext context) {
    print("moving to home screen");
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(maintainState: false, builder: (context) => Home()));
  }

  Widget _fadeSplashExample(BuildContext context) {
    return AnimatedSplash(
      imagePath: 'assets/flutter_icon.png',
      style: AnimationStyle.FadeIn,
      curve: Curves.linear,
      doInBackground: doSomethingInBackground(),
      onAnimationCompleted: () {
        debugPrint("animation is completed");
      },

    );
  }

  Widget _circularRevealSplashExample(BuildContext context) {
    return AnimatedSplash(
      imagePath: 'assets/flutter_icon.png',
      style: AnimationStyle.FadeIn,
      curve: Curves.linear,
      backgroundColor: Colors.indigoAccent,
      doInBackground: doSomethingInBackground(),
      onAnimationCompleted: () {
        debugPrint("animation is completed");
      },
      onReadyToGoNextScreen: () => moveToHomeScreen(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _circularRevealSplashExample(context);
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset("assets/cat.jpg"),
            SizedBox(height: 8.0),
            Text(
              'Get outta here, you hoooman',
              style: TextStyle(color: Colors.black, fontSize: 20.0),
            ),
          ],
        ),
      ),
    );
  }
}
