import 'package:carpool/helper/SharedPreferences.dart';
import 'package:carpool/screens/UserDashBoard.dart';
import 'package:flutter/material.dart';

import 'screens/SignUpPage.dart';

void main() => runApp(CheckConfig());

class CheckConfig extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CheckConfigState();
}

class CheckConfigState extends State<CheckConfig> {
  //check user is already login in or not
  bool mIsUserSignedIn = false;

  CheckConfigState() {
    SharedPreferencesHelper().getEmail().then((value){
      print(value);
    });

    SharedPreferencesHelper().isUserSignedIn().then((value) {
      mIsUserSignedIn = value;
      print(mIsUserSignedIn);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: mIsUserSignedIn ? UserDashboard() : SignUpPage(),
    );
  }
}
