import 'package:flutter/material.dart';
import 'package:nivaldomotos/models/user_model.dart';
import 'package:nivaldomotos/screens/home_screen.dart';
import 'package:nivaldomotos/screens/login_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class IndexScreen extends StatefulWidget {
  @override
  _IndexScreenState createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(builder: (context, child, model) {
      return model.isLoggedIn() == true ? HomeScreen() : LoginScreen();
    });
  }
}
