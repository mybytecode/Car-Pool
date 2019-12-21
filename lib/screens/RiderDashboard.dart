import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RiderDashBoard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RiderDashboardState();
}

class RiderDashboardState extends State<RiderDashBoard> {
  DateTime dateTime = DateTime.now();

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
              onChanged: (value) {},
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
                onChanged: (value) {},
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
            RaisedButton(
              padding: EdgeInsets.all(10),
              onPressed: () {
                DatePicker.showDateTimePicker(context,
                    theme: DatePickerTheme(containerHeight: 200.0),
                    showTitleActions: true,
                    currentTime: dateTime, onConfirm: (date) {
                  if (date.difference(dateTime).inMilliseconds < 0) {
                    setState(() {
                      dateTime = DateTime.now();
                    });
                    print(dateTime);
                  } else {
                    dateTime = DateTime.now();
                  }
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
                      child: Text(dateTime.day.toString() +
                          "-" +
                          dateTime.month.toString() +
                          "-" +
                          dateTime.year.toString() +
                          "  " +
                          dateTime.hour.toString() +
                          ":" +
                          dateTime.minute.toString()))
                ],
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3)),
              elevation: 4,
            ),
            const SizedBox(height: 20),
            RaisedButton(
                onPressed: () {},
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
}
