import 'package:carpool/helper/CurrentLocation.dart';
import 'package:carpool/screens/SearchResult.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class CommuterDashBoard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CommuterDashboardState();
}

class CommuterDashboardState extends State<CommuterDashBoard> {
  GoogleMapController mapController;

  LatLng _center = LatLng(18.603090, 73.770450);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    getCurrentLocation();
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          child: TextField(
            onSubmitted: (value) {
              getTextFieldData(value, context);
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
        ),
        Container(
          height: 400,
          padding: EdgeInsets.all(20),
          child: GoogleMap(
            mapType: MapType.hybrid,
            trafficEnabled: true,
            scrollGesturesEnabled: true,
            zoomGesturesEnabled: true,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              tilt: 20.0,
              zoom: 20.0,
              target: _center,
            ),
          ),
        )
      ],
    );
  }

  void getCurrentLocation() async {
    LocationData data = await CurrentLocation().getCurrentLocation();
    setState(() {
      _center = LatLng(data.latitude, data.longitude);
    });
  }

  void getTextFieldData(String value, BuildContext context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => searchResult(value)));
  }
}
