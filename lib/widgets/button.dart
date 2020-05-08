import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nivaldomotos/constants/colors.dart';
import 'package:nivaldomotos/constants/fonts.dart';

class ButtonFunction extends StatelessWidget {
  final Function function;
  final String text;

  ButtonFunction({
    @required this.function,
    @required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.33,
      child: CupertinoButton(
        color: Color(primaryColor),
        onPressed: function,
        child: Text(text.toUpperCase(), style: buttonStyle),
      ),
    );
  }
}

class ButtonSecondFunction extends StatelessWidget {
  final Function function;
  final String text;

  ButtonSecondFunction({
    @required this.function,
    @required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: CupertinoButton(
        onPressed: function,
        child: Text(text.toUpperCase(), style: buttonSecondStyle),
      ),
    );
  }
}
