import 'package:carpool/Theme/theme.dart';
import 'package:carpool/screens/CommuterDashboard.dart';
import 'package:carpool/screens/RiderDashboard.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserDashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => UserDashboardState();
}

class UserDashboardState extends State<UserDashboard> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: CustomTheme().colorCustom),
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          child: Material(
            child: Scaffold(
              appBar: AppBar(
                elevation: 2,
                bottom: TabBar(
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black12),
                  tabs: <Widget>[
                    Tab(
                      //icon: Icon(FontAwesomeIcons.carAlt),
                      text: "Rider",
                    ),
                    Tab(
                      //icon: Icon(FontAwesomeIcons.userAlt),
                      text: "Commuter",
                    )
                  ],
                ),
                leading: IconButton(
                  icon: Icon(FontAwesomeIcons.bars),
                  onPressed: () {},
                ),
                title: Text("RideAlong"),
              ),
              body: TabBarView(children: <Widget>[
                RiderDashBoard(),
                CommuterDashBoard()
              ],)
            ),
          ),
          length: 2,

        ));
  }
}
