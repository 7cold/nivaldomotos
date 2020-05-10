import 'package:flutter/material.dart';
import 'package:nivaldomotos/models/user_model.dart';
import 'package:nivaldomotos/screens/splash_screen.dart';
import 'package:scoped_model/scoped_model.dart';
import 'constants/colors.dart';
import 'models/cart_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: ScopedModelDescendant<UserModel>(builder: (context, child, model) {
        return ScopedModel<CartModel>(
          model: CartModel(model),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: coral,
            ),
            home: SplashScreen(),
          ),
        );
      }),
    );
  }
}
