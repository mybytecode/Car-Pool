import 'dart:math';

import 'package:carpool/constant/Config.dart';
import 'package:http/http.dart' as http;
class CustomFuture
{
  Future<String> signup(String email,String password)async
  {
    int token = Random().nextInt(1000000);
    print(token);

    print(Config.gSignUpUrl);
    var result =await http.post(Config.gSignUpUrl,body: {
      "email":email,
      "password":password,
      "token":token.toString()
    });
    return result.body;
  }

  Future< String > signIn(String email,String password)async
  {
    var response = await http.post(Config.gSignInUrl,body: {
      "email":email,
      "password":password
    });

    return response.body;
  }
}