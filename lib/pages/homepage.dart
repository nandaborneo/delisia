import 'package:delisia/pages/loginpage.dart';
import 'package:delisia/models/loginmodel.dart';
import 'package:delisia/helper/session.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _userId;
  String _userNama;
  String _staffId;

  @override
  void initState() {
    super.initState();
    _setLoginInfo();
  }

  _setLoginInfo() async {
    String tempUserId = await Session.getUserId();
    String tempUserNama = await Session.getUserNama();
    String tempStaffId = await Session.getStaffId();
    setState(() {
      _userId = tempUserId;
      _userNama = tempUserNama;
      _staffId = tempStaffId;
    });
  }

  _logout(context) async {
    await Session.setAccessToken(null);
    await Session.setStaffId(null);
    await Session.setUserNama(null);
    await Session.setUserId(null);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  _buildDrawer(context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.black,
              child: Text("AVA"),
            ),
            accountName: Text(_userNama),
            accountEmail: Text(_userId),
          ),
          ListTile(
            title: Text("Master Label"),
            leading: Icon(Icons.list),
          ),
          ListTile(
            title: Text("Logout"),
            onTap: () => _logout(context),
            leading: Icon(Icons.exit_to_app),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      drawer: _buildDrawer(context),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text("Selamat Datang, $_userNama"),
            ),
          ],
        ),
      ),
    );
  }
}
