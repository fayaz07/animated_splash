import 'dart:async';

import 'package:animated_splash/src/circular_reveal.dart';
import 'package:animated_splash/src/fade_in.dart';
import 'package:animated_splash/src/scale.dart';
import 'package:animated_splash/src/still.dart';
import 'package:animated_splash/utils/constants.dart';
import 'package:animated_splash/utils/types.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

final StreamController<SplashStatus> _statusController =
    StreamController<SplashStatus>.broadcast();
final Stream<SplashStatus> _statusStream = _statusController.stream;
final Sink<SplashStatus> _statusSink = _statusController.sink;
List<SplashStatus> _splashStatusList = [];

class AnimatedSplash extends StatelessWidget {
  final AnimationStyle style;
  final String imagePath;
  final Color backgroundColor;
  final VoidCallback onAnimationCompleted;
  final Future<dynamic> doInBackground;
  final VoidCallback onReadyToGoNextScreen;
  final Size logoSize;
  final Duration animDuration;
  final Curve curve;
  final Color circularRevealColor;

  const AnimatedSplash({
    Key key,
    this.imagePath,
    this.onAnimationCompleted,
    this.style = defaultAnimationStyle,
    this.backgroundColor = defaultBackgroundColor,
    this.logoSize = defaultLogoSize,
    this.animDuration = defaultAnimDuration,
    this.curve = defaultAnimationCurve,
    this.doInBackground,
    this.onReadyToGoNextScreen,
    this.circularRevealColor = defaultCircularRevealColor,
  })  : assert(imagePath != null),
        assert(onAnimationCompleted != null),
        super(key: key);

  Widget _body() {
    Widget _child = SizedBox();

    _child = Image.asset(
      imagePath,
      height: logoSize.height,
      width: logoSize.width,
    );

    switch (style) {
      case AnimationStyle.CircularReveal:
        _child = CircularRevealSplashScreen(
          animCurve: curve,
          duration: animDuration,
          backgroundColor: circularRevealColor,
          onAnimationCompleted: _onAnimationFinished,
          child: _child,
        );
        break;
      case AnimationStyle.FadeIn:
        _child = FadeInSplashScreen(
          animCurve: curve,
          duration: animDuration,
          onAnimationCompleted: _onAnimationFinished,
          child: _child,
        );
        break;
      case AnimationStyle.Still:
        _addStatusEvent(SplashStatus.Animated);
        _child = StillSplashScreen(
          child: _child,
        );
        break;
      case AnimationStyle.Scale:
        _child = ScaleSplashScreen(
          animCurve: curve,
          duration: animDuration,
          onAnimationCompleted: _onAnimationFinished,
          child: _child,
        );
        break;
    }

    return Scaffold(
      // backgroundColor: backgroundColor,
      body: _child,
    );
  }

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance
    //     .addPostFrameCallback((Duration d) => _initBackgroundWork());
    _initBackgroundWork();
    return _body();
  }

  /*
   *  This will initiate the background work
   */
  void _initBackgroundWork() {
    _cleanUpList();
    _addStatusEvent(SplashStatus.Init);
    _finishUserAssignedBGWork();
    _listenToStream();
  }

  void _cleanUpList() {
    _splashStatusList = [SplashStatus.Init];
  }

  /*
   *  This will listen to the stream and collects the events
   *  Once all the events are caught, there we go,
   *  the purpose of this package is served
   */
  void _listenToStream() {
    _statusStream.listen((event) {
      _splashStatusList.add(event);
      if (_splashStatusList.contains(SplashStatus.Init) &&
          _splashStatusList.contains(SplashStatus.Animated) &&
          _splashStatusList.contains(SplashStatus.BGCallbackDone)) {
        _onReadyToGoNextScreen();
      }
    });
  }

  /*
   *  This will take up the responsibility of final cleanings
   *  after the task is done
   */
  void _onReadyToGoNextScreen() {
    debugPrint("[Animated Splash] ready to go to next screen");
    _disposeStream();
    Future.delayed(Duration(milliseconds: 50))
        .then((value) => onReadyToGoNextScreen());
  }

  /*
   *  This will add up animation finished event as well as triggering
   *  user called function
   */
  void _onAnimationFinished() {
    _addStatusEvent(SplashStatus.Animated);
    debugPrint("Animation finished");
    onAnimationCompleted();
  }

  /*
   *  This will execute, user's background task and adds the
   *  event to the stream
   */
  void _finishUserAssignedBGWork() async {
    await doInBackground;
    debugPrint("BG task finished");
    _addStatusEvent(SplashStatus.BGCallbackDone);
  }

  /*
   *  This will just add the given events to the sink
   */
  void _addStatusEvent(SplashStatus status) {
    _statusSink.add(status);
    debugPrint("Adding status: ${status.toString()}");
  }

  /*
   *  This will cleanup stream and sink
   */
  void _disposeStream() {
    if (kDebugMode) {
      debugPrint("[Animated Splash] Skipping dispose of stream");
      return;
    }
    _statusSink.close();
    _statusController.close();
  }
}
