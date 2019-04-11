## Splash Screen

### Using the package

```yaml
environment:
  sdk: ">=2.1.0 <3.0.0"
```

> Add dependency in **pubspec.yaml**
```yaml
dependencies:
  animated_splash: ^0.0.1
```
### Things to do
<ol>
<li> Get a logo for your app</li>
<li> Prepare what to execute while the splash screen is shown (initializing your db, shared preferences, firebase...etc) </li>
<li> Screen to be shown after splash screen  </li>
<li> Duration of Splash Screen  </li>
</ol>

 Import the package
```dart
import 'package:splash_screen/splash_screen.dart';
```
Create an object of  **Function** that gets executed while splash screen is shown
```dart
Function duringSplash = () {
  //Write your code here
  ...
};
```
Inside your **main** function, use *home* as **SplashScreen(_)**, the parameters are as follows:
> imagePath: Path to your app-logo/image
> home: Screen to be shown after splash
> duringSplash: the function you have written above
> duration: duration of splash screen in milliseconds
```dart
runApp(MaterialApp(
  home: SplashScreen(
      imagePath: 'your_logo_path',
      home: YourHomeScreen(),
      duringSplash: duringSplash,
      duration: 2500),
));
```
### Demo
<img src="https://raw.githubusercontent.com/fayaz07/splash_screen/master/splash_demo.gif" width="230" height="440" alt="ProgressDialog Demo" />
