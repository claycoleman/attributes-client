import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:attributes_client/common/apifunctions/requestLogoutAPI.dart';

class BasicDrawer extends StatefulWidget {
  @override
  _BasicDrawerState createState() => _BasicDrawerState();
}

class _BasicDrawerState extends State<BasicDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: new EdgeInsets.all(32.0),
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text(
                "Logout",
                style: TextStyle(
                    // color: Colors.black,
                    fontSize: 20.0),
              ),
              onTap: () {
                requestLogoutAPI(context);
                Navigator.of(context).pushReplacementNamed('/LoginScreen');
              },
            ),
          ],
        ),
      ),
    );
  }
}
