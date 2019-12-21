

import 'package:carpool/helper/CurrentLocation.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class CommuterDashBoard extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() =>CommuterDashboardState();

}
class CommuterDashboardState extends State< CommuterDashBoard>
{
  GoogleMapController mapController;

  LatLng _center = LatLng(18.603090, 73.770450);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    getCurrentLocation();
    return  Container(child: GoogleMap(
      mapType: MapType.satellite,
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
    ),);
  }

  void getCurrentLocation()async {
    LocationData data= await CurrentLocation().getCurrentLocation();
    setState(() {
      _center =LatLng( data.latitude,data.longitude);
    });
  }
}