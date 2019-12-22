import 'package:carpool/Theme/theme.dart';
import 'package:carpool/screens/RideInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Model/Model.dart';

class ShowRides extends StatefulWidget {
  List<Ride> ride;

  ShowRides(this.ride);

  @override
  State<StatefulWidget> createState() => ShowRidesState(ride);
}

class ShowRidesState extends State<ShowRides> {
  List<Ride> rideData;

  ShowRidesState(this.rideData);

  @override
  Widget build(BuildContext context) {
    print(rideData);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: CustomTheme().colorCustom),
      home: Scaffold(
        appBar: AppBar(
          title: Text("My Rides"),
        ),
        body: ListView.builder(
            itemCount: rideData.length,
            itemBuilder: (BuildContext context, int index) {
              return rideItem(context, index);
            }),
      ),
    );
  }

  Widget rideItem(BuildContext context, int index) {
    return Card(
      elevation: 4,
      child: InkWell(
        borderRadius: BorderRadius.circular(4.0),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => RideInfo(
                      rideData[index].id,
                      rideData[index].datetime,
                      rideData[index].start_location,
                      rideData[index].drop_location)));
        },
        child: Row(
          children: <Widget>[
            Image.asset(
              'assets/images/bike.jpg',
              width: 120,
              height: 80,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            rideData[index].start_location,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14.0),
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5.0),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: parseDate(rideData[index].datetime),
                          ),
                        ],
                      ),
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                    const SizedBox(height: 5.0),
                    Row(
                      children: <Widget>[
                        Text("Condition"),
                        const SizedBox(width: 10.0),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String parseDate(String date) {
    DateTime d = DateTime.parse(date);
    return d.day.toString() +
        "-" +
        d.month.toString() +
        "-" +
        d.year.toString();
  }
}
