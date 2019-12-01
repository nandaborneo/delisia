import 'package:delisia/pages/homepage.dart';
import 'package:delisia/pages/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:delisia/helper/session.dart';

class RootPage extends StatefulWidget {
  RootPage({Key key}) : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  _checkLogin() async {
    final String accessToken = await Session.getAccessToken();
    Future.delayed(Duration(seconds: 2), () {
      if (accessToken == null || accessToken == "") {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return LoginPage();
        }));
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return HomePage();
        }));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
