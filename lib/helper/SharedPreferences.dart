
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper
{
  signInUser(String email) async
  {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("email",email);
    preferences.setBool("isUserSignedIn", true);
  }

  Future<bool>isUserSignedIn() async
  {
    SharedPreferences preferences = await SharedPreferences.getInstance();
     return preferences.getBool("isUserSignedIn");
  }
  Future< String > getEmail()async
  {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.get("email");
  }
}