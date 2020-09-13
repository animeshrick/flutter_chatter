import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatter/ChatScrren.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginPage extends StatefulWidget {
  static const String id = 'Login Page';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  String _email, _password;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Hero(
                tag: "Hero",
                child: Container(
                  child: Image.asset('assets/flash.png'),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  _email = value;
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Enter Mail-Id'),
              ),
              SizedBox(
                height: 25,
              ),
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  _password = value;
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Enter Password'),
              ),
              FlatButton(
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    final user = await _auth.signInWithEmailAndPassword(
                        email: _email, password: _password);
                    if (user != null) {
                      Navigator.pushNamed(context, ChatScreen.id);
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  } catch (e) {
                    print(e);
                    Fluttertoast.showToast(
                      msg: "Error in Login" + e.toString(),
                    );
                  }
                },
                child: Text("Login"),
                color: Colors.blue,
              )
            ],
          ),
        ),
      ),
    );
  }
}
