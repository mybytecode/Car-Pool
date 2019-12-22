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
                    onPressed: () {
                      showProfile();
                    },
                  ),
                  title: Text("RideAlong"),
                ),
                body: TabBarView(
                  children: <Widget>[RiderDashBoard(), CommuterDashBoard()],
                )),
          ),
          length: 2,
        ));
  }

  Widget showProfile() {
    showModalBottomSheet(
      elevation: 5,
        isScrollControlled: true,
        useRootNavigator: true,
        context: context,
        builder: (BuildContext buildC) {
          return ListView(
            padding: EdgeInsets.all(10),
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 50),
                child: Center(
                  child: Image.network(
                      "https://gifimage.net/wp-content/uploads/2018/11/user-gif-4.gif"),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                child: Center(
                  child: Text(
                    "Akshay Galande",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                child: Center(
                  child: Text(
                    "mybytecode@gmail.com",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                child: Center(
                  child: Text(
                    "Vechicle No:- MH 42 AL 8714",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                child: Center(
                  child: Text(
                    "Age : 21",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                child: Center(
                  child: Text(
                    "Gender : Male",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54),
                  ),
                ),
              ),
            ],
          );
        });
  }
}
