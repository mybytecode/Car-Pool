import 'dart:math';

import 'package:carpool/data.dart';
import 'package:carpool/future/CustomFuture.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:toast/toast.dart';

class RideInfo extends StatefulWidget {
  String id, to, from, date;

  RideInfo(this.id, this.date, this.from, this.to);

  @override
  State<StatefulWidget> createState() => RideInfoState(id, date, from, to);
}

class RideInfoState extends State<RideInfo> {
  String id, date, from, to;

  RideInfoState(this.id, this.date, this.from, this.to);

  @override
  Widget build(BuildContext context) {
    final Set<Marker> _markers = {};
    final Set<Polyline> _polyline = {};
    GoogleMapController mapController;

    LatLng _center = LatLng(18.603090, 73.770450);
    LatLng _lastMapPosition = _center;
    List<LatLng> latlng = List();

    LatLng _new = LatLng(33.738045, 73.084488);
    LatLng _news = LatLng(33.567997728, 72.635997456);

    latlng.add(_new);
    latlng.add(_news);

    RideInfo() {
      setState(() {
        _markers.add(Marker(
          // This marker id can be anything that uniquely identifies each marker.
          markerId: MarkerId(_lastMapPosition.toString()),
          //_lastMapPosition is any coordinate which should be your default
          //position when map opens up
          position: _lastMapPosition,
          infoWindow: InfoWindow(
            title: 'Really cool place',
            snippet: '5 Star Rating',
          ),
          icon: BitmapDescriptor.defaultMarker,
        ));
        _polyline.add(Polyline(
          polylineId: PolylineId(_lastMapPosition.toString()),
          visible: true,
          //latlng is List<LatLng>
          points: latlng,
          color: Colors.blue,
        ));
      });
    }

    void _onMapCreated(GoogleMapController controller) {
      mapController = controller;
    }

    int index = Random().nextInt(3);
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text("$from to $to"),
        ),
        body: Container(
          padding: EdgeInsets.all(14),
          child: Column(
            children: <Widget>[
              FutureBuilder(
                  future: CustomFuture().getRideRequest(),
                  builder: (BuildContext bcontext, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return Container(
                        child: Center(
                          child: Image.asset('assets/images/load.gif'),
                        ),
                      );
                    } else {
                      return Column(
                        children: <Widget>[
                          Container(
                              child: ListTile(
                            onTap: () {},
                            leading: Icon(Icons.face),
                            title: Text(Users().user_name[index]),
                            trailing: RaisedButton(
                              onPressed: () {
                                showModal();
                              },
                              child: Text("Action"),
                            ),
                          )),
                          Container(
                            height: 500,
                            child: GoogleMap(
                              polylines: _polyline,
                              markers: _markers,
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
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget showModal() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext buildC) {
          return ListView(
            padding: EdgeInsets.all(10),
            children: <Widget>[
              RaisedButton(
                color: Colors.greenAccent,
                onPressed: () {
                  Toast.show("Approved", context);
                  Navigator.pop(context);
                },
                child: Text("Approve"),
              ),
              RaisedButton(
                color: Colors.redAccent,
                onPressed: () {
                  Toast.show("Canceled", context);
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
              ),
            ],
          );
        });
  }
}
