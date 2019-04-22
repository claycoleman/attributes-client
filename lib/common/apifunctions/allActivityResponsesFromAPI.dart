import 'dart:io';
import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:attributes_client/common/functions/getToken.dart';
import 'package:attributes_client/model/json/activityResponseModel.dart';

Future<List<ActivityResponseModel>> allActivityResponsesFromAPI() async {
  final url = "http://localhost:4000/api/v1/activity_responses";

  final token = await getToken();

  final response = await http.get(
    url,
    headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
  );

  if (response.statusCode == 200) {
    final responseJson = json.decode(response.body);

    final List<ActivityResponseModel> activityResponseModels = new List();
    for (var activityResponseJson in responseJson["data"]) {
      activityResponseModels
          .add(ActivityResponseModel.fromJson(activityResponseJson));
    }
    return activityResponseModels;
  } else {
    return new List();
  }
}
