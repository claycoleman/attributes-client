import 'dart:io';
import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:attributes_client/common/functions/getToken.dart';

Future<bool> pingAPIToDetectLogin() async {
  final url = "http://localhost:4000/api/v1/my_user";

  final token = await getToken();
  if (token == null || token == "") {
    return false;
  }

  final response = await http.get(
    url,
    headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
  );

  return response.statusCode == 200;
}
