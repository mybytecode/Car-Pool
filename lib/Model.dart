class getRide {
  final List<Ride> rideList;

  getRide({this.rideList});
  static List<Ride> parseImages(imagesJson) {
    var list = imagesJson['images'] as List;
    List<Ride> ride =
    list.map((data) => Ride.fromJson(data)).toList();
    return ride;
  }
}

class Ride {
  final String id;
  final String mail, start_location, drop_location, numofseats, datetime;

  Ride(
      {this.id,
      this.mail,
      this.start_location,
      this.drop_location,
      this.numofseats,
      this.datetime});

  factory Ride.fromJson(Map<String, dynamic> parsedJson) {
    return Ride(
        id: parsedJson['id'] as String,
        mail: parsedJson['mail'] as String,
        start_location: parsedJson['start_location'] as String,
        drop_location: parsedJson['drop_location'] as String,
        numofseats: parsedJson['numofseats'] as String,
        datetime: parsedJson['datetime'] as String);
  }
}
