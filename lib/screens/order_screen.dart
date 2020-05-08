import 'package:flutter/material.dart';
import 'package:nivaldomotos/constants/colors.dart';
import 'package:nivaldomotos/constants/fonts.dart';
import 'package:nivaldomotos/widgets/button.dart';

import 'my_orders.dart';

class OrderScreen extends StatelessWidget {
  final String orderId;
  OrderScreen(this.orderId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "PEDIDO REALIZADO",
          style: TextStyle(
              fontFamily: fontExtraBold,
              fontSize: 24,
              color: Color(accentColor)),
        ),
        centerTitle: true,
        backgroundColor: Color(backgroundColorDark),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/images/checkout.png",
              scale: 8,
            ),
            Text(
              "Pedido realizado com sucesso!",
              style: titleHomeStyle,
            ),
            SizedBox(height: 20),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'Código do pedido: ',
                style: userStyle,
                children: <TextSpan>[
                  TextSpan(text: '$orderId', style: userStyle),
                ],
              ),
            ),
            SizedBox(height: 20),
            ButtonFunction(
                function: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => MyOrders()));
                },
                text: "meus pedidos"),
          ],
        ),
      ),
    );
  }
}
