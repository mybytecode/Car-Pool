import 'package:location/location.dart';

class CurrentLocation
{
  var location = new Location();

  Future<LocationData> getCurrentLocation()
  {
    return location.getLocation();
  }
}