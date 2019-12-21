/*
 * Copyright 2019 mybytecode
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carpool/constant/Config.dart';
import 'package:carpool/future/CustomFuture.dart';
import 'package:carpool/helper/SharedPreferences.dart';
import 'package:carpool/screens/UserDashBoard.dart';
import 'package:carpool/utils/Dialog.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class SignUpPage extends StatefulWidget {
  static final String path = "lib/src/pages/login/auth3.dart";

  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  bool formVisible;
  int _formsIndex;

  SignUpPageState() {
    SharedPreferencesHelper().isUserSignedIn().then((value) {
      if (value) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => UserDashboard()));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    formVisible = false;
    _formsIndex = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: CachedNetworkImageProvider(Config.gBackgroundUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            color: Colors.black54,
            child: Column(
              children: <Widget>[
                const SizedBox(height: kToolbarHeight + 40),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Welcome",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 30.0,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        "Welcome to RideAlong. \n Please Login or Sign Up to use this app",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 18.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: <Widget>[
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: RaisedButton(
                        color: Colors.red,
                        textColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Text("Login"),
                        onPressed: () {
                          setState(() {
                            formVisible = true;
                            _formsIndex = 1;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: RaisedButton(
                        color: Colors.grey.shade700,
                        textColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Text("Signup"),
                        onPressed: () {
                          setState(() {
                            formVisible = true;
                            _formsIndex = 2;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 10.0),
                  ],
                ),
                const SizedBox(height: 40.0),
                /*OutlineButton.icon(
                      borderSide: BorderSide(color: Colors.red),
                      color: Colors.red,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      icon: Icon(FontAwesomeIcons.google),
                      label: Text("Continue with Google"),
                      onPressed: () {},
                    ),*/
                const SizedBox(height: 20.0),
              ],
            ),
          ),
          AnimatedSwitcher(
            duration: Duration(milliseconds: 200),
            child: (!formVisible)
                ? null
                : Container(
                    color: Colors.black54,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RaisedButton(
                              textColor: _formsIndex == 1
                                  ? Colors.white
                                  : Colors.black,
                              color:
                                  _formsIndex == 1 ? Colors.red : Colors.white,
                              child: Text("Login"),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              onPressed: () {
                                setState(() {
                                  _formsIndex = 1;
                                });
                              },
                            ),
                            const SizedBox(width: 10.0),
                            RaisedButton(
                              textColor: _formsIndex == 2
                                  ? Colors.white
                                  : Colors.black,
                              color:
                                  _formsIndex == 2 ? Colors.red : Colors.white,
                              child: Text("Signup"),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              onPressed: () {
                                setState(() {
                                  _formsIndex = 2;
                                });
                              },
                            ),
                            const SizedBox(width: 10.0),
                            IconButton(
                              color: Colors.white,
                              icon: Icon(Icons.clear),
                              onPressed: () {
                                setState(() {
                                  formVisible = false;
                                });
                              },
                            )
                          ],
                        ),
                        Container(
                          child: AnimatedSwitcher(
                            duration: Duration(milliseconds: 300),
                            child:
                                _formsIndex == 1 ? LoginForm() : SignUpForm(),
                          ),
                        )
                      ],
                    ),
                  ),
          )
        ],
      ),
    ));
  }
}

class LoginForm extends StatelessWidget {
  String mEmail, mPassword;

  LoginForm({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          TextField(
            onChanged: (value) {
              getLoginData(value, "email");
            },
            decoration: InputDecoration(
              hintText: "Enter email",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10.0),
          TextField(
            onChanged: (value) {
              getLoginData(value, "password");
            },
            obscureText: true,
            decoration: InputDecoration(
              hintText: "Enter password",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10.0),
          RaisedButton(
            color: Colors.red,
            textColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Text("Login"),
            onPressed: () {
              checkSignIn(context);
            },
          ),
        ],
      ),
    );
  }

  void getLoginData(String value, String type) {
    switch (type) {
      case "email":
        mEmail = value;
        break;
      case "password":
        mPassword = value;
        break;
    }
  }

  void checkSignIn(BuildContext context) async {
    String response = await CustomFuture().signIn(mEmail, mPassword);
    print(response);
    if (response == "found") {
      await SharedPreferencesHelper().signInUser(mEmail);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => UserDashboard()));
    } else if (response == "not") {
      Toast.show("Email and password dose not match", context);
      DialogUtil().dialogMessage(context, "Email not registered");
    }
  }
}

class SignUpForm extends StatelessWidget {
  String mEmail, mPassword, mConfirmPassword;
  String response;

  SignUpForm({
    Key key,
  }) : super(key: key) {}

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          TextField(
            onChanged: (value) {
              getInPutText("email", value);
            },
            decoration: InputDecoration(
              hintText: "Enter email",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10.0),
          TextField(
            onChanged: (value) {
              getInPutText("password", value);
            },
            obscureText: true,
            decoration: InputDecoration(
              hintText: "Enter password",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10.0),
          TextField(
            onChanged: (value) {
              getInPutText("confirmPassword", value);
            },
            obscureText: true,
            decoration: InputDecoration(
              hintText: "Confirm password",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10.0),
          RaisedButton(
            color: Colors.red,
            textColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Text("Signup"),
            onPressed: () {
              signUp(context);
            },
          ),
        ],
      ),
    );
  }

  getInPutText(String inputType, String value) {
    switch (inputType) {
      case "email":
        mEmail = value;
        break;
      case "password":
        mPassword = value;
        break;
      case "confirmPassword":
        mConfirmPassword = value;
    }
  }

  void signUp(BuildContext context) async {
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(mEmail)) {
      DialogUtil().dialogMessage(context, "Please Enter valid Email");
    } else if (mPassword != mConfirmPassword) {
      DialogUtil().dialogMessage(context, "Password should be same..");
    } else if (mPassword.length < 6) {
      DialogUtil().dialogMessage(
          context, "Password should be greater than 6 charactors");
    } else {
      String response = await CustomFuture().signup(mEmail, mPassword);
      print(response);

      if (response == "SuccessSignup") {
        await SharedPreferencesHelper().signInUser(mEmail);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => UserDashboard()));
      } else if (response == "exist") {
        DialogUtil().dialogMessage(context, "Email Already Registered");
      }
    }
  }
}
