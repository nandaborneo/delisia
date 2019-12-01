import 'package:delisia/rootpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stetho/flutter_stetho.dart';
import 'helper/utils.dart';

void main() {
  Stetho.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delisia',
      theme: ThemeData(
          primarySwatch: MaterialColor(0xFF492500, Utils.color),
          primaryColor: MaterialColor(0xFF492500, Utils.color),
          accentColor: MaterialColor(0xFFf55753, Utils.color),
          buttonColor:  MaterialColor(0xFF492500, Utils.color)),
      home: RootPage(),
    );
  }
}
