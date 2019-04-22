import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:attributes_client/common/functions/saveCurrentLogin.dart';
import 'package:attributes_client/common/functions/showDialogSingleButton.dart';
import 'dart:convert';

import 'package:attributes_client/model/json/loginModel.dart';

Future<LoginModel> requestLoginAPI(
    BuildContext context, String username, String password) async {
  final url = "http://localhost:4000/api/v1/sign_in";

  Map<String, String> body = {
    'username': username,
    'password': password,
  };

  final response = await http.post(
    url,
    body: body,
  );

  if (response.statusCode == 200) {
    final responseJson = json.decode(response.body);
    var user = new LoginModel.fromJson(responseJson);

    saveCurrentLogin(username, responseJson);
    Navigator.of(context).pushReplacementNamed('/HomeScreen');

    return LoginModel.fromJson(responseJson);
  } else {
    final responseJson = json.decode(response.body);

    saveCurrentLogin(username, responseJson);
    showDialogSingleButton(
        context,
        "Unable to Login",
        "You may have supplied an invalid credentials. Please try again.",
        "Okay");
    return null;
  }
}
