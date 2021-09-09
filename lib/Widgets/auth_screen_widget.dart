import 'dart:io';

import 'package:chatapp/Service/auth_login_signup.dart';
import 'package:chatapp/View/AuthScreen/auth_screen_viewmodel.dart';
import 'package:chatapp/Widgets/upload_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthScreenWidget extends StatefulWidget {
  @override
  _AuthScreenWidgetState createState() => _AuthScreenWidgetState();
}

class _AuthScreenWidgetState extends State<AuthScreenWidget> {
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passcontroller = TextEditingController();

  TextEditingController _usernamecontroller = TextEditingController();

  final _formkey = GlobalKey<FormState>();
  bool _islogin = true;
  String _email = "";
  String _username = "";
  String _password = "";
  bool isloading = false;
  File imageuser;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 10,
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                if (!_islogin) UploadImage(),
                TextFormField(
                  controller: _emailcontroller,
                  onSaved: (value) {
                    print("email $value");
                    _email = value;
                  },
                  validator: (value) {
                    if (value.isEmpty || !value.contains("@")) {
                      return "please Enter A valid Email Adress";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Email Adress",
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                if (_islogin == false)
                  TextFormField(
                    controller: _usernamecontroller,
                    onSaved: (value) {
                      print("user name $value");
                      setState(() {
                        _username = value;
                      });
                    },
                    validator: (value) {
                      if (value.isEmpty || value.length > 11) {
                        return "user name too long ";
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: "User Name"),
                    keyboardType: TextInputType.emailAddress,
                  ),
                TextFormField(
                  controller: _passcontroller,
                  onSaved: (value) {
                    print("pass $value");
                    _password = value;
                  },
                  validator: (value) {
                    if (value.isEmpty || value.length < 8) {
                      return "please Enter at least 8 caracter , strong password";
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: "Password"),
                  keyboardType: TextInputType.emailAddress,
                  obscureText: true,
                ),
                SizedBox(
                  height: 20,
                ),
                if (isloading) CircularProgressIndicator(),
                if (!isloading)
                  RaisedButton(
                    onPressed: () async {
                      FocusScope.of(context).unfocus();

                      if (!_islogin) {
                        imageuser = Provider.of<AuthDataProvider>(context,
                                listen: false)
                            .pickedimage;

                        print(imageuser);
                      }

                      if (_formkey.currentState.validate()) {
                        if (imageuser == null && _islogin == false) {
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text("please choose image"),
                            backgroundColor: Colors.black26,
                          ));
                          return;
                        }
                        _formkey.currentState.save();
                        setState(() {
                          isloading = true;
                        });
                        try {
                          await Auth.authLoginSignup(
                            userimage: imageuser,
                            ctx: context,
                            email: _email,
                            password: _password,
                            username: _username,
                            islogin: _islogin,
                          );
                        } catch (e) {
                          setState(() {
                            isloading = false;
                          });
                        }
                      }
                    },
                    child: _islogin ? Text("login") : Text("sign up"),
                  ),
                FlatButton(
                  textColor: Theme.of(context).primaryColor,
                  onPressed: () {
                    _emailcontroller.clear();
                    _passcontroller.clear();
                    _usernamecontroller.clear();
                    setState(() {
                      _islogin = !_islogin;
                    });
                  },
                  child: _islogin
                      ? Text("create an account")
                      : Text("i already have an account"),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
