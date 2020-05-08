import 'package:flutter/material.dart';

class UserIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 26,
      child: Image.asset("assets/icons/user.png"),
    );
  }
}

class UserIconWhite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25,
      child: Image.asset("assets/icons/user_white.png"),
    );
  }
}
