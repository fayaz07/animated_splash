## Animated Splash Screen

### Using the package

[Get the library](https://pub.dev/packages/animated_splash)

```yaml
environment:
  sdk: ">=2.1.0 <3.0.0"
```

> Add dependency in **pubspec.yaml**
```yaml
dependencies:
  animated_splash: ^1.0.1
```
### Things to do
<ol>
<li> Get a logo for your app</li>
<li> Prepare what to execute while the splash screen is shown (initializing your db, shared preferences, firebase...etc) </li>
<li> Screen to be shown after splash screen and background process </li>
<li> Duration of Splash Screen  </li>
</ol>

Import the package
```dart
import 'package:animated_splash/animated_splash.dart';
```

## Show splash screen for some duration
```dart
  type: AnimatedSplashType.StaticDuration
```

Inside your **main** function, use *home* as **SplashScreen(_)**, the parameters are as follows:
> imagePath: Path to your app-logo/image
> home: Screen to be shown after splash
> duration: duration of splash screen in milliseconds
> type
```dart
runApp(MaterialApp(
  home: AnimatedSplash(
              imagePath: 'assets/flutter_icon.png',
              home: Home(),
              duration: 2500,
              type: AnimatedSplashType.StaticDuration,
            ),
));
```

## Execute a function in background and based on the value from that function navigate to different screen

```dart
  type: AnimatedSplashType.BackgroundProcess
```
> Create an object of  **Function** that gets executed while splash screen is shown
```dart
Function duringSplash = () {
  //Write your code here
  ...
  return value;
};
```

> Create routes according to your function return value
```dart
  //setup the return value correctly for proper navigation
  Map<dynamic, Widget> returnValueAndHomeScreen = {1: Home(), 2: HomeSt()};

```


Inside your **main** function, use *home* as **SplashScreen(_)**, the parameters are as follows:
> imagePath: Path to your app-logo/image
> home: Screen to be shown after splash
> customFunction: the function you have written above
> duration: duration of splash screen in milliseconds
> type
> output value of customFunction and home screen to navigate(Map function)

```dart
runApp(MaterialApp(
  home: AnimatedSplash(
              imagePath: 'assets/flutter_icon.png',
              home: Home(),
              customFunction: duringSplash,
              duration: 2500,
              type: AnimatedSplashType.BackgroundProcess,
              outputAndHome: op,
            ),
));
```
### Demo
<img src="https://raw.githubusercontent.com/fayaz07/splash_screen/master/splash_demo.gif" width="230" height="440" alt="ProgressDialog Demo" />
