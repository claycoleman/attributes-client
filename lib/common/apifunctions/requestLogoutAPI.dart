import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:attributes_client/common/functions/saveLogout.dart';
import 'package:attributes_client/model/json/loginModel.dart';

Future<LoginModel> requestLogoutAPI(BuildContext context) async {
  // don't really need a log out API request because we just delete tokens
  saveLogout();
}
