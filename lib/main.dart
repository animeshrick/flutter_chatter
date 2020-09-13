import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'ChatScrren.dart';
import 'HomePage.dart';
import 'Login Page.dart';
import 'RegistationPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Flutter-Chatter",
        initialRoute: HomePage.id,
        routes: {
          HomePage.id: (context) => HomePage(),
          LoginPage.id: (context) => LoginPage(),
          RegistationPage.id: (context) => RegistationPage(),
          ChatScreen.id: (context) => ChatScreen(),
        });
  }
}
