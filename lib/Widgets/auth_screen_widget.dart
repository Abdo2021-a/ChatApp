import 'package:chatapp/Service/auth_login_signup.dart';
import 'package:flutter/material.dart';

class AuthScreenWidget extends StatefulWidget {
  @override
  _AuthScreenWidgetState createState() => _AuthScreenWidgetState();
}

class _AuthScreenWidgetState extends State<AuthScreenWidget> {
  final _formkey = GlobalKey<FormState>();
  bool _islogin = true;
  String _email = "";
  String _username = "";
  String _password = "";
  bool isloading = false;
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
                TextFormField(
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
                    onSaved: (value) {
                      print("user name $value");
                      setState(() {
                        _username = value;
                      });
                    },
                    validator: (value) {
                      if (value.isEmpty || value.length < 7) {
                        return "please enter more";
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: "User Name"),
                    keyboardType: TextInputType.emailAddress,
                  ),
                TextFormField(
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
                      if (_formkey.currentState.validate()) {
                        _formkey.currentState.save();
                        setState(() {
                          isloading = true;
                        });
                        try {
                          await Auth.authLoginSignup(
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
