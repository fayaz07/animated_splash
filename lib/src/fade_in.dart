import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FadeInSplashScreen extends StatefulWidget {
  final VoidCallback onAnimationCompleted;
  final Widget child;
  final Duration duration;
  final Curve animCurve;

  const FadeInSplashScreen(
      {Key? key,
      required this.onAnimationCompleted,
      required this.child,
      required this.duration,
      required this.animCurve})
      : super(key: key);

  @override
  _FadeInSplashScreenState createState() => _FadeInSplashScreenState();
}

class _FadeInSplashScreenState extends State<FadeInSplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;

  @override
  void initState() {
    super.initState();
    _animationController =
        new AnimationController(vsync: this, duration: widget.duration);
    _animation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _animationController, curve: widget.animCurve));

    _animationController.forward();
    _animation.addStatusListener(defaultAnimationsStatusListener);
  }

  defaultAnimationsStatusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) widget.onAnimationCompleted();
  }

  @override
  void dispose() {
    _animation.removeStatusListener(defaultAnimationsStatusListener);
    _animationController.reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FadeTransition(
        opacity: _animation as Animation<double>,
        child: widget.child,
      ),
    );
  }
}
