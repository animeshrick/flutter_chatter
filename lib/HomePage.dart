import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import 'Login Page.dart';
import 'RegistationPage.dart';

class HomePage extends StatefulWidget {
  static const id = 'Home Page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    controller.forward();

    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);

    // animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);

//    animation.addStatusListener((status) {
//      if (status == AnimationStatus.completed) {
//        controller.reverse(from: 1.0);
//      } else if (status == AnimationStatus.dismissed) {
//        controller.forward();
//      }
//    });

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            //  mainAxisAlignment: MainAxisAlignment.center,
            //  crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Hero(
                tag: "Hero",
                child: Container(
                  height: 100, //animation.value * 100,
                  //height: MediaQuery.of(context).size.height,
                  //width: MediaQuery.of(context).size.width,
                  child: Image.asset('assets/flash.png'),
                ),
              ),
              TypewriterAnimatedTextKit(
                repeatForever: true,
                speed: Duration(seconds: 2),
                text: ["Chatter"],
                textStyle: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          FlatButton(
            child: Text('LOGIN'),
            color: Colors.blue,
            onPressed: () {
              Navigator.pushNamed(context, LoginPage.id);
            },
          ),
          FlatButton(
            child: Text('Register'),
            color: Colors.blue,
            onPressed: () {
              Navigator.pushNamed(context, RegistationPage.id);
            },
          ),
        ],
      ),
    );
  }
}
