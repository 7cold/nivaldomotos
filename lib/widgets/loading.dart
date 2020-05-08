import 'package:flutter/material.dart';
import 'package:nivaldomotos/constants/colors.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(accentColor: Color(primaryColor)),
      child: new CircularProgressIndicator(
        strokeWidth: 2,
      ),
    );
  }
}
