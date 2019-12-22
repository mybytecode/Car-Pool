class Base {
  final List<Result> result;

  Base({this.result});

  factory Base.fromJson(Map<String, dynamic> parsedJson) {
    return Base(
        result: (parsedJson['results'] as List).map((map) => map).toList());
  }
}

class Result {
  final Geometry geometry;

  Result({this.geometry});

  factory Result.fromJson(Map<String, dynamic> parsedJson) {
    return Result(
      geometry: Geometry.fromJson(parsedJson['geometry'])
    );
  }
}

class Geometry {
  final Location location;

  Geometry({this.location});

  factory Geometry.fromJson(Map<String,dynamic>json){
    return Geometry(
      location: Location.fromJson(json['location'])
    );
  }
}

class Location {
  final double lat, lng;

  Location({this.lat, this.lng});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(lat: json['lat'] as double, lng: json['lng'] as double);
  }
}
