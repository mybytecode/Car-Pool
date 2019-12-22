import 'dart:convert';
import 'dart:math';

import 'package:carpool/Model/MapResultModel.dart';
import 'package:carpool/constant/Config.dart';
import 'package:carpool/data.dart';
import 'package:carpool/helper/SharedPreferences.dart';
import 'package:http/http.dart' as http;

import '../Model/Model.dart';

class CustomFuture {
  Future<String> signup(String email, String password) async {
    int token = Random().nextInt(1000000);
    print(token);

    print(Config.gSignUpUrl);
    var result = await http.post(Config.gSignUpUrl, body: {
      "email": email,
      "password": password,
      "token": token.toString()
    });
    return result.body;
  }

  Future<String> signIn(String email, String password) async {
    var response = await http
        .post(Config.gSignInUrl, body: {"email": email, "password": password});

    return response.body;
  }

  Future<String> postRide(String startLocation, String dropLocation,
      String numOfSeats, String date) async {
    int index1 = Random().nextInt(9);
    int index2 = Random().nextInt(9);
    String mail = await SharedPreferencesHelper().getEmail();

    var response = await http.post(Config.gPostRideUrl, body: {
      "start_location": startLocation,
      "drop_location": dropLocation,
      "mail": mail,
      "numberofseats": numOfSeats,
      "date": date,
      "start_location_lat": location().lat[index1].toString(),
      "start_location_long": location().long[index1].toString(),
      "drop_location_lat": location().lat[index2].toString(),
      "drop_location_long": location().long[index2].toString()
    });

    return response.body;
  }

  Future<List<Ride>> getRidesOfUser() async {
    String mail = await SharedPreferencesHelper().getEmail();

    var response =
        await http.post(Config.gGetRideOfUser, body: {"email": mail});

    List<Ride> parseRide(String responseBody) {
      final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
      return parsed.map<Ride>((json) => Ride.fromJson(json)).toList();
    }

    List<Ride> rideList = parseRide(response.body);

    return rideList;
  }

  Future<List<Base>> getMapSearchResult(String query) async {
    String url = Config.gGoogleMapUrl + "$query&key=" + Config.googleMapApiKey;

    var response = await http.get(url);
    List<Base> data = json.decode(response.body);
    return data;
  }

  Future<List<Ride>> getsearchOfUser(String query) async {
    var response = await http.post(Config.gSearch, body: {"query": query});

    List<Ride> parseRide(String responseBody) {
      final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
      return parsed.map<Ride>((json) => Ride.fromJson(json)).toList();
    }

    List<Ride> rideList = parseRide(response.body);

    return rideList;
  }

  Future<String> postRequestRide(String id) async {
    String mail = await SharedPreferencesHelper().getEmail();
    var response =
        await http.post(Config.gPostRequest, body: {"mail": mail, "id": id});
    return response.body;
  }

  Future<List<Request>> getRideRequest() async {
    String mail = await SharedPreferencesHelper().getEmail();
    var response =
        await http.post(Config.gGetRideRequest, body: {"mail": mail});

    List<Request> parseRide(String responseBody) {
      final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
      return parsed.map<Request>((json) => Request.fromJson(json)).toList();
    }
    List<Request> requestList = parseRide(response.body);

    return requestList;
  }
}
