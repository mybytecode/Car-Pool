import 'package:carpool/future/CustomFuture.dart';
import 'package:carpool/helper/SharedPreferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Model.dart';

class RiderDashBoard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RiderDashboardState();
}

class RiderDashboardState extends State<RiderDashBoard> {
  DateTime mDateTime = DateTime.now();
  String mStartLocation, mDropLocation,mNumOfSeatsAvailable;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      padding: EdgeInsets.all(10),
      child: Center(
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 10.0),
            TextField(
              onChanged: (value) {
                getTextFieldData(value, "start_location");
              },
              decoration: InputDecoration(
                hintText: "Start location",
                prefixIcon: Icon(
                  FontAwesomeIcons.search,
                  color: Colors.black54,
                ),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10.0),
            const SizedBox(height: 10.0),
            Container(
              child: TextField(
                onChanged: (value) {
                  getTextFieldData(value, "drop_location");
                },
                decoration: InputDecoration(
                  hintText: "Drop location",
                  prefixIcon: Icon(
                    FontAwesomeIcons.search,
                    color: Colors.black54,
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            TextField(
              onChanged: (value) {
                getTextFieldData(value, "num_of_seats");
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Number of Seats Available",
                prefixIcon: Icon(
                  Icons.people,
                  color: Colors.black54,
                ),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10.0),
            RaisedButton(
              padding: EdgeInsets.all(10),
              onPressed: () {
                DatePicker.showDateTimePicker(context,
                    theme: DatePickerTheme(containerHeight: 200.0),
                    showTitleActions: true,
                    currentTime: mDateTime, onConfirm: (date) {
                  print(date.difference(mDateTime).inMilliseconds);
                  if (date.difference(mDateTime).inMilliseconds < 0) {
                    setState(() {
                      mDateTime = DateTime.now();
                    });
                  } else {
                    setState(() {
                      mDateTime = date;
                    });
                  }
//                  print(dateTime);
                });
              },
              child: Row(
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.solidCalendarAlt,
                    color: Colors.black54,
                  ),
                  Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(mDateTime.day.toString() +
                          "-" +
                          mDateTime.month.toString() +
                          "-" +
                          mDateTime.year.toString() +
                          "  " +
                          mDateTime.hour.toString() +
                          ":" +
                          mDateTime.minute.toString()))
                ],
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3)),
              elevation: 4,
            ),
            const SizedBox(height: 20),
            RaisedButton(
                onPressed: () {
                  postRide();
                },
                color: Colors.pink,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 4,
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Center(
                    child: Text(
                      "Post a Ride..",
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  getTextFieldData(String value, String type) {
    switch (type) {
      case "start_location":
        mStartLocation = value;
        break;
      case "drop_location":
        mDropLocation = value;
        break;
      case "num_of_seats":
        mNumOfSeatsAvailable = value;
        break;
    }
  }

  postRide() async {

    String response = await CustomFuture().postRide(mStartLocation,
        mDropLocation, mNumOfSeatsAvailable, mDateTime.toString());
    print(response);

    if( response == "success" )
      {
        List<Ride> response = await CustomFuture().getRidesOfUser();
        print(response);
      }
  }
}
