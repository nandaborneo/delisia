import 'dart:convert';

import 'package:delisia/pages/homepage.dart';
import 'package:delisia/models/loginmodel.dart';
import 'package:delisia/helper/session.dart';
import 'package:flutter/material.dart';
import 'package:delisia/helper/api.dart';
import 'package:delisia/helper/utils.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _userNameController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _isLoading = false;
  }

  _submit() {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      String userName = _userNameController.text;
      String password = _passwordController.text;

      Map<String, dynamic> data = {"username": userName, "password": password};
      String linkSukses = 'http://www.mocky.io/v2/5dce6c0d3000004a00931991';
      String linkGagal = 'http://www.mocky.io/v2/5dce6c703000005b00931997';
      Api.httpPost(linkSukses, data).then((value) {
        print(value);
        var responseBody = json.decode(value);
        if (responseBody['success'] == true) {
          _scaffoldKey.currentState.removeCurrentSnackBar();
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text(responseBody['message']),
          ));
          LoginModel loginModel = LoginModel.fromJson(responseBody['data']);
          Session.setUserId(loginModel.userid);
          Session.setUserNama(loginModel.usernama);
          Session.setStaffId(loginModel.staffid);
          Session.setAccessToken(responseBody['token']);
          Future.delayed(Duration(seconds: 1), () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          });
        } else {
          _scaffoldKey.currentState.removeCurrentSnackBar();
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text(responseBody['message']),
          ));
        }
      }).whenComplete(() {
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/login.jpg"),
                  fit: BoxFit.cover)),
          child: Container(
              margin: EdgeInsets.only(top: 25, bottom: 25, left: 25, right: 25),
              child: Form(
                key: _formKey,
                child: new Stack(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: RadialGradient(
                                center: Alignment(0, 0),
                                radius: 0.7,
                                colors: [
                                  Color(0xFF836953),
                                  Color(0xFF5B3F2B),
                                ],
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  16.0, 64.0, 16.0, 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  TextFormField(
                                    style: TextStyle(color: Colors.white),
                                    controller: _userNameController,
                                    decoration: InputDecoration(
                                        hintStyle:
                                            TextStyle(color: Colors.white),
                                        labelStyle:
                                            TextStyle(color: Colors.white),
                                        labelText: "Username",
                                        hintText: "Masukkan Username"),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "Username Harus Di Isi";
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  TextFormField(
                                    controller: _passwordController,
                                    obscureText: true,
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                        hintStyle:TextStyle(color: Colors.white),
                                        labelStyle:TextStyle(color: Colors.white),
                                        labelText: "Password"),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "Password Harus Di Isi";
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  _isLoading
                                      ? Container(
                                          child: Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        )
                                      : MaterialButton(
                                          onPressed: _submit,
                                          color: MaterialColor(
                                              0xFFF48C1D, Utils.color),
                                          child: Text(
                                            "Login",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      top: 190,
                      left: 110,
                      child: new Container(
                        child: new Image.asset(
                          "assets/images/logo.jpg",
                          height: 80.0,
                          width: 200.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ));
  }
}
