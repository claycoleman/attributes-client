import 'package:shared_preferences/shared_preferences.dart';
import 'package:attributes_client/model/json/loginModel.dart';

import 'dart:developer';

saveCurrentLogin(String username, Map responseJson) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();

  var token = (responseJson != null && responseJson.isNotEmpty)
      ? LoginModel.fromJson(responseJson).jwt
      : "";

  await preferences.setString('LastUsername', username);
  await preferences.setString(
      'LastToken', (token != null && token.length > 0) ? token : "");
}
