import 'package:carpool/constant/Config.dart';
import 'package:http/http.dart' as http;
class CustomFuture
{
  Future<String> signup(String email,String password, String role)async
  {
    print(Config.gSignUpUrl);
    var result =await http.post(Config.gSignUpUrl,body: {
      "email":email,
      "password":password,
      "token":"token",
      "role":role
    });
    return result.body;
  }
}