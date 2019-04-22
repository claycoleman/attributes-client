import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:attributes_client/common/platform/platformScaffold.dart';
import 'package:attributes_client/common/apifunctions/pingAPIToDetectLogin.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final int splashDuration = 2;
  bool loggedIn = false;
  int advancingState = 0;
  final int readyToAdvance = 2;

  startTime() async {
    return Timer(Duration(seconds: splashDuration), incrementAdvancingState);
  }

  checkLogin() async {
    loggedIn = await pingAPIToDetectLogin();
    incrementAdvancingState();
  }

  incrementAdvancingState() {
    advancingState += 1;
    if (advancingState == readyToAdvance) {
      advanceToNextScreen();
    }
  }

  advanceToNextScreen() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');

    if (loggedIn) {
      Navigator.of(context).pushReplacementNamed('/HomeScreen');
    } else {
      Navigator.of(context).pushReplacementNamed('/LoginScreen');
    }
  }

  @override
  void initState() {
    super.initState();
    // wait 2 seconds and check login state
    startTime();
    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    var drawer = Drawer();

    // TODO fix these styles lol
    return PlatformScaffold(
        drawer: drawer,
        body: Container(
            // decoration: BoxDecoration(color: Colors.white),
            child: Column(
          children: <Widget>[
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.network(
                    'https://media.ldscdn.org/images/media-library/bible-images-the-life-of-jesus-christ/teachings/pictures-of-jesus-smiling-1138511-gallery.jpg',
                    width: MediaQuery.of(context).size.width,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Christlike Attributes",
                  style: TextStyle(
                    fontSize: 36.0,
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
              child: Text(
                "© Sandman 2019",
                style: TextStyle(
                  fontSize: 16.0,
                  // color: Colors.black,
                ),
              ),
            ),
          ],
        )));
  }
}
