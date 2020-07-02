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

class ButtonMyOrders extends StatelessWidget {
  final String title;
  final double height;
  final double width;
  final Function function;

  const ButtonMyOrders(
      {@required this.title,
      @required this.height,
      @required this.width,
      @required this.function});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        borderRadius: BorderRadius.circular(4),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Color(primaryColor),
          ),
          child: Material(
            type: MaterialType.transparency,
            color: Colors.transparent,
            child: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Color(backgroundColor).withOpacity(0.4),
              borderRadius: BorderRadius.circular(4),
              onTap: function,
              child: Container(
                  child: Center(
                      child: Text(
                title,
                style: buttonStyle,
              ))),
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonMyOrdersSec extends StatelessWidget {
  final String title;
  final double height;
  final double width;
  final Function function;

  const ButtonMyOrdersSec(
      {@required this.title,
      @required this.height,
      @required this.width,
      @required this.function});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        borderRadius: BorderRadius.circular(4),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Color(backgroundColorDark),
          ),
          child: Material(
            type: MaterialType.transparency,
            color: Colors.transparent,
            child: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Color(backgroundColor).withOpacity(0.4),
              borderRadius: BorderRadius.circular(4),
              onTap: function,
              child: Container(
                  child: Center(
                      child: Text(
                title,
                style: buttonStyle,
              ))),
            ),
          ),
        ),
      ),
    );
  }
}
