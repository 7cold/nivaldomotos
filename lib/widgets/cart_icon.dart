import 'package:flutter/material.dart';
import 'package:nivaldomotos/constants/colors.dart';
import 'package:nivaldomotos/constants/fonts.dart';
import 'package:nivaldomotos/models/cart_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<CartModel>(
      builder: (context, child, model) {
        return Container(
          height: 50,
          width: 55,
          //color: Colors.red,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                left: 2,
                child: SizedBox(
                  height: 27,
                  child: Image.asset("assets/icons/cart.png"),
                ),
              ),
              Positioned(
                right: 2,
                top: 2,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(primaryColor),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(7.5),
                    child: Text(
                      model.products.length.toString(),
                      style: circleProductsLenghtStyle,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CartIconWhite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<CartModel>(
      builder: (context, child, model) {
        return Container(
          height: 50,
          width: 55,
          //color: Colors.amber,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                left: 2,
                child: SizedBox(
                  height: 25,
                  child: Image.asset("assets/icons/cart_white.png"),
                ),
              ),
              Positioned(
                right: 2,
                top: 2,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(primaryColor),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(7.5),
                    child: Text(
                      model.products.length.toString(),
                      style: circleProductsLenghtStyle,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
