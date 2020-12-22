import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StillSplashScreen extends StatelessWidget {
  final Widget child;

  const StillSplashScreen({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [child, SizedBox(height: 16.0), CircularProgressIndicator()],
      ),
    );
  }
}
