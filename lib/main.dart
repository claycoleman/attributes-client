import 'package:flutter/material.dart';

import 'package:attributes_client/ui/homeScreen.dart';
import 'package:attributes_client/ui/loginScreen.dart';
import 'package:attributes_client/ui/registerScreen.dart';
// import 'package:attributes_client/ui/newActivityResponseScreen.dart';
import 'package:attributes_client/ui/splashScreen.dart';

void main() => runApp(new MyApp());

class FadeRoute<T> extends MaterialPageRoute<T> {
  FadeRoute({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (settings.isInitialRoute) return child;
    // Fades between routes. (If you don't want any animation,
    // just return child.)
    return new FadeTransition(opacity: animation, child: child);
  }
}

class NoAnimationRoute<T> extends MaterialPageRoute<T> {
  NoAnimationRoute({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (settings.isInitialRoute) return child;
    return child;
  }
}

class MyApp extends StatelessWidget {
  var _splashShown = false;

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Christlike Attributes",
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/':
            return new FadeRoute(
              builder: (_) => new SplashScreen(),
              settings: settings,
            );
          case '/HomeScreen':
            return new MaterialPageRoute(
              builder: (_) => new HomeScreen(),
              settings: settings,
            );
          case '/LoginScreen':
            return new NoAnimationRoute(
              builder: (_) => new LoginScreen(),
              settings: settings,
            );
          case '/RegisterScreen':
            return new NoAnimationRoute(
              builder: (_) => new RegisterScreen(),
              settings: settings,
            );
        }
        assert(false);
      },
      // routes: <String, WidgetBuilder>{
      //   "/HomeScreen": (BuildContext context) => HomeScreen(),
      //   "/LoginScreen": (BuildContext context) => LoginScreen(),
      //   "/RegisterScreen": (BuildContext context) => RegisterScreen(),
      //   // "/NewActivityResponseScreen": (BuildContext context) => NewActivityResponseScreen(),
      // },
      theme: ThemeData(
        // Define the default Brightness and Colors
        brightness: Brightness.dark,
        // primaryColor: Colors.lightBlue[800],
        primaryColor: Color(0xff803660),
        accentColor: Colors.cyan[600],

        // Define the default Font Family
        fontFamily: 'Montserrat',

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          title: TextStyle(fontSize: 28.0, fontStyle: FontStyle.italic),
          body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
        
      ),
      home: SplashScreen(),
    );
  }
}
