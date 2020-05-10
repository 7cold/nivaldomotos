import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:nivaldomotos/constants/colors.dart';
import 'package:nivaldomotos/screens/index_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => IndexScreen(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(backgroundColor),
      body: Stack(
        children: <Widget>[
          FlareActor(
            "assets/animators/splash.flr",
            animation: "Untitled",
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
