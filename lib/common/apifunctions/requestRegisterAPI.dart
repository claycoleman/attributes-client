import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:attributes_client/common/functions/saveCurrentLogin.dart';
import 'package:attributes_client/common/functions/showDialogSingleButton.dart';
import 'dart:convert';

import 'package:attributes_client/model/json/loginModel.dart';

Future<LoginModel> requestRegisterAPI(BuildContext context, String username,
    String password, String confirmPassword) async {
  final url = "http://localhost:4000/api/v1/sign_up";

  final body = {
    'user': {
      'username': username,
      'password': password,
      'password_confirmation': confirmPassword,
    },
  };

  final response = await http.post(url,
      body: jsonEncode(body), headers: {"Content-Type": 'application/json'});

  if (response.statusCode == 200) {
    final responseJson = json.decode(response.body);
    saveCurrentLogin(username, responseJson);
    Navigator.of(context).pushReplacementNamed('/HomeScreen');

    return LoginModel.fromJson(responseJson);
  } else {
    final responseJson = json.decode(response.body);
    // TODO we will need to return a different response if there is a user already with that username

    saveCurrentLogin(username, responseJson);
    showDialogSingleButton(context, "Unable to Register",
        "Please fill in all fields and try again.", "Okay");
    return null;
  }
}
