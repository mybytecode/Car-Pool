import 'package:carpool/helper/CurrentLocation.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class RiderDashBoard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RiderDashboardState();
}

class RiderDashboardState extends State<RiderDashBoard> {
  GoogleMapController mapController;

   LatLng _center = LatLng(18.603090, 73.770450);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    getCurrentLocation();
    return  GoogleMap(
          mapType: MapType.hybrid,
          trafficEnabled: true,
          scrollGesturesEnabled: true,
          zoomGesturesEnabled: true,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            tilt: 20.0,
            zoom: 30.0,
            target: _center,
          ),
        );
  }

  void getCurrentLocation()async {
    LocationData data= await CurrentLocation().getCurrentLocation();
    setState(() {
      _center =LatLng( data.latitude,data.longitude);
    });
  }
}
