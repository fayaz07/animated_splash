import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircularRevealSplashScreen extends StatefulWidget {
  final VoidCallback onAnimationCompleted;
  final Widget child;
  final Duration duration;
  final Curve animCurve;
  final Color backgroundColor;

  const CircularRevealSplashScreen(
      {Key? key,
      required this.onAnimationCompleted,
      required this.child,
      required this.duration,
      required this.animCurve,
      required this.backgroundColor})
      : super(key: key);

  @override
  _CircularRevealSplashScreenState createState() =>
      _CircularRevealSplashScreenState();
}

class _CircularRevealSplashScreenState extends State<CircularRevealSplashScreen>
    with TickerProviderStateMixin {
  late Animation scaleAnim, radiusAnim;
  late AnimationController scaleAnimController, radiusAnimController;

  // final animDuration = Duration(milliseconds: 150);
  bool initialCase = true;
  MaterialType materialType = MaterialType.circle;
  double? _height, _width;

  @override
  void initState() {
    super.initState();
    scaleAnimController = AnimationController(
        vsync: this,
        duration: Duration(seconds: 5),
        debugLabel: 'SplashScreen-CircleAnim');
    scaleAnim = Tween(begin: 0.1, end: 1.0).animate(
        CurvedAnimation(parent: scaleAnimController, curve: widget.animCurve));

    radiusAnimController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 10),
        debugLabel: 'SplashScreen-CircleAnim');
    radiusAnim = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: radiusAnimController, curve: widget.animCurve));

    // Future.delayed(Duration(seconds: 2)).whenComplete(() {
    scaleAnimController.forward();
    // });

    scaleAnimController.addListener(circularAnimationListener);
  }

  @override
  void dispose() {
    scaleAnim.removeListener(circularAnimationListener);
    super.dispose();
  }

  circularAnimationListener() {
    print(scaleAnim.value);
    if (scaleAnim.value > 0.9 && _height == _width) {
      setState(() {
        _height = MediaQuery.of(context).size.height;
      });
      radiusAnimController.forward();
    }
    if (scaleAnimController.status == AnimationStatus.completed) {
      // widget.onAnimationCompleted();
    }
    // if (scaleAnim.status == AnimationStatus.completed)
  }

  @override
  Widget build(BuildContext context) {
    return _circularRevealAnimatedLogo();
  }

  Widget _circularRevealAnimatedLogo() => Stack(
        children: <Widget>[
          AnimatedBuilder(
            animation: scaleAnim,
            builder: (context, child) {
              return Center(
                child: Container(
                  width: _width! * scaleAnim.value,
                  height: _height! * scaleAnim.value,
                  decoration: BoxDecoration(
                    color: widget.backgroundColor,
                    borderRadius:
                        BorderRadius.circular(_width! * radiusAnim.value),
                  ),
                ),
              );
            },
          ),
          Center(child: widget.child),
        ],
      );
}
