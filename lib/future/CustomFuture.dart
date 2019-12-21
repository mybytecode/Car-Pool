import 'dart:convert';
import 'dart:math';

import 'package:carpool/constant/Config.dart';
import 'package:carpool/helper/SharedPreferences.dart';
import 'package:http/http.dart' as http;

import '../Model.dart';

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
    String mail = await SharedPreferencesHelper().getEmail();

    var response = await http.post(Config.gPostRideUrl, body: {
      "start_location": startLocation,
      "drop_location": dropLocation,
      "mail": mail,
      "numberofseats": numOfSeats,
      "date": date
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
}
