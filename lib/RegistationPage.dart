import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatter/ChatScrren.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistationPage extends StatefulWidget {
  static const String id = 'Registation Page';

  @override
  _RegistationPageState createState() => _RegistationPageState();
}

class _RegistationPageState extends State<RegistationPage> {
  String _email, _password;
  bool showSpinner = false;
  bool isLodding = false;
  User loggedInUser;
  var _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        body: isLodding
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Form(
                  key: _formkey,
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
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.emailAddress,
                        validator: (item) {
                          return item.contains("@")
                              ? null
                              : "Enter valid email";
                        },
                        onChanged: (item) {
                          // value == item
                          setState(() {
                            _email = item;
                          });
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter Mail-Id',
                            labelText: "Email Id"),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        textAlign: TextAlign.center,
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        onChanged: (item) {
                          setState(() {
                            _password = item;
                          });
                        },
                        validator: (item) {
                          return item.length > 6
                              ? null
                              : "Password must be 6 characters";
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter Password'),
                      ),
                      FlatButton(
                        onPressed: () async {
                          //signUp();
                          setState(() {
                            showSpinner = true;
                          });
                          try {
                            final newUser =
                                await _auth.createUserWithEmailAndPassword(
                                    email: _email, password: _password);
                            if (newUser != null) {
                              Navigator.pushNamed(context, ChatScreen.id);
                            }
                            setState(() {
                              showSpinner = false;
                            });
                          } catch (e) {
                            //print(e);
                            Fluttertoast.showToast(
                                msg: "error " + e.toString());
                          }
                        },
                        child: Text('Register'),
                        color: Colors.blue,
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }

//  void signUp() {
//    if (_formkey.currentState.validate()) {
//      setState(() {
//        isLodding = true;
//      });
//      FirebaseAuth.instance
//          .createUserWithEmailAndPassword(email: _email, password: _password)
//          .then((user) {
//        setState(() {
//          isLodding = false;
//        });
//
//        Navigator.pushAndRemoveUntil(
//            context,
//            MaterialPageRoute(builder: (context) => ChatScreen()),
//            (Route<dynamic> route) => false);
//      }).catchError((onError) {
//        setState(() {
//          isLodding = false;
//        });
//        Fluttertoast.showToast(msg: "error " + onError.toString());
//      });
//    }
//  }
}
