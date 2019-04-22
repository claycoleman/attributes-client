import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:attributes_client/common/apifunctions/allActivityResponsesFromAPI.dart';
import 'package:attributes_client/common/platform/platformScaffold.dart';
import 'package:attributes_client/common/widgets/activityResponseSummary.dart';
import 'package:attributes_client/common/widgets/basicDrawer.dart';
import 'package:attributes_client/model/json/activityResponseModel.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ActivityResponseModel> activityResponses;

  @override
  void initState() {
    super.initState();
    getActivityResponses();
  }

  getActivityResponses() async {
    final newActivityResponses = await allActivityResponsesFromAPI();
    setState(() {
      activityResponses = newActivityResponses;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activityResponseSection;
    if (activityResponses != null) {
      if (activityResponses.length > 0) {
        activityResponseSection = Center(
          child: Column(
            children: List.from(activityResponses.map((currentResponseModel) {
              return ActivityResponseSummary(
                  activityResponseModel: currentResponseModel);
            })),
          ),
        );
      } else {
        activityResponseSection = Text(
            "You haven't completed any attributes activities! Press the + button above to get started.");
      }
    } else {
      activityResponseSection = Text("Loading...");
    }
    return PlatformScaffold(
      appBar: AppBar(
        title: Text(
          "Home",
          style: TextStyle(),
        ),
        elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 6.0,
      ),
      drawer: BasicDrawer(),
      body: Container(
        padding: EdgeInsets.all(32.0),
        child: Center(
          child: Column(
            children: <Widget>[
              activityResponseSection,
            ],
          ),
        ),
      ),
    );
  }
}
