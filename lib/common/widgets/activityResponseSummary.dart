import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:attributes_client/common/apifunctions/requestLogoutAPI.dart';
import 'package:attributes_client/model/json/activityResponseModel.dart';

class ActivityResponseSummary extends StatelessWidget {
  ActivityResponseSummary({this.activityResponseModel});

  final ActivityResponseModel activityResponseModel;

  @override
  Widget build(BuildContext context) {
    final highestAttr = activityResponseModel.getHighestAttribute();
    final lowestAttr = activityResponseModel.getLowestAttribute();
    return Container(
      padding: new EdgeInsets.all(32.0),
      child: Center(
        child: Column(
          children: <Widget>[
            Text(
                "Highest Attribute: " + highestAttr.item1,
                style: TextStyle(
                    // color: Colors.black,
                    fontSize: 20.0),
              ),
            Text(
                "Average Rating: " + highestAttr.item2.toStringAsFixed(1),
                style: TextStyle(
                    // color: Colors.black,
                    fontSize: 20.0),
              ),
            Text(
                "Lowest Attribute: " + lowestAttr.item1,
                style: TextStyle(
                    // color: Colors.black,
                    fontSize: 20.0),
              ),
            Text(
                "Average Rating: " + lowestAttr.item2.toStringAsFixed(1),
                style: TextStyle(
                    // color: Colors.black,
                    fontSize: 20.0),
              ),
          ],
        ),
      ),
    );
  }
}
