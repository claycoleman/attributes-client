import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:attributes_client/common/apifunctions/requestLoginAPI.dart';
import 'package:attributes_client/common/functions/showDialogSingleButton.dart';
import 'package:attributes_client/common/platform/platformScaffold.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;

const URL = "http://localhost:4000/api/v1/sign_in";

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _usernameNode = FocusNode();
  final FocusNode _passwordNode = FocusNode();

  String _errorMessage = "";

  @override
  void initState() {
    super.initState();
    _saveCurrentRoute("/LoginScreen");
  }

  _saveCurrentRoute(String lastRoute) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('LastScreenRoute', lastRoute);
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, String> args = ModalRoute.of(context).settings.arguments;
    if (args != null) {
      if (_userNameController.text == "") {
        _userNameController.text =
            args.containsKey("username") ? args["username"] : "";
      }
      if (_passwordController.text == "") {
        _passwordController.text =
            args.containsKey("password") ? args["password"] : "";
      }
    }

    return WillPopScope(
      onWillPop: () {
        if (Navigator.canPop(context)) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/HomeScreen', (Route<dynamic> route) => false);
        } else {
          Navigator.of(context).pushReplacementNamed('/HomeScreen');
        }
      },
      child: PlatformScaffold(
        appBar: AppBar(
          title: Text(
            "Christlike Attributes",
            style: TextStyle(
              fontSize: 24.0,
              // color: Colors.black,
            ),
          ),
          centerTitle: true,
          // backgroundColor: Colors.white,
          // iconTheme: IconThemeData(color: Colors.black),
        ),
        // backgroundColor: Colors.white,
        body: Container(
          child: Padding(
            padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0.0, 24.0, 0.0, 8.0),
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          fontSize: 20.0,
                          // color: Colors.black
                        ),
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 24.0),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text:
                              'Sign in here to complete attribute activities and save them to your account.',
                          style: new TextStyle(
                            fontSize: 16.0,
                            // color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  "Username",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
                  child: TextField(
                      controller: _userNameController,
                      textCapitalization: TextCapitalization.none,
                      autocorrect: false,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: "",
                      ),
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                      focusNode: _usernameNode,
                      onSubmitted: (term) {
                        _usernameNode.unfocus();
                        FocusScope.of(context).requestFocus(_passwordNode);
                      }),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 35.0, 0.0, 0.0),
                  child: Text(
                    "Password",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0.0),
                  child: TextField(
                    controller: _passwordController,
                    textCapitalization: TextCapitalization.none,
                    autocorrect: false,
                    decoration: InputDecoration(
                      hintText: '',
                    ),
                    focusNode: _passwordNode,
                    obscureText: true,
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
                _errorMessage != ''
                    ? Container(
                        child: Text(
                          _errorMessage,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent,
                          ),
                        ),
                        margin: EdgeInsets.fromLTRB(0, 28, 0, 0),
                      )
                    : Container(),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 28.0, 0.0, 0.0),
                  child: Container(
                    height: 48.0,
                    child: RaisedButton(
                      onPressed: () {
                        if (_userNameController.text == '' ||
                            _passwordController.text == '') {
                          setState(() {
                            _errorMessage =
                                "Please fill out all fields, and try again.";
                          });
                          return;
                        }
                        setState(() {
                          _errorMessage = "";
                        });
                        SystemChannels.textInput.invokeMethod('TextInput.hide');
                        requestLoginAPI(context, _userNameController.text,
                            _passwordController.text);
                      },
                      child: Text("Sign In",
                          style: TextStyle(
                              // color: Colors.white,
                              fontSize: 18.0)),
                      // color: Colors.blue,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(0xff, 0x64, 0x64, 0x64),
                  ),
                  height: 2,
                  margin: EdgeInsets.fromLTRB(0, 28, 0, 28),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 28.0),
                  child: Container(
                    height: 48.0,
                    child: RaisedButton(
                      onPressed: () {
                        SystemChannels.textInput.invokeMethod('TextInput.hide');
                        Navigator.of(context).pushReplacementNamed(
                            "/RegisterScreen",
                            arguments: {
                              "username": _userNameController.text,
                              "password": _passwordController.text
                            });
                      },
                      child: Text("Don't have an account?",
                          style: TextStyle(fontSize: 18.0)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
