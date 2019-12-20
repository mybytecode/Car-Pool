import 'package:flutter/material.dart';

import 'screens/SignUpPage.dart';

void main() => runApp(CheckConfig());

class CheckConfig extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CheckConfigState();
}

class CheckConfigState extends State<CheckConfig> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
     home: SignUpPage(),
    );
  }
}
