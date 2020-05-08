import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:nivaldomotos/constants/fonts.dart';
import 'package:nivaldomotos/models/cart_model.dart';
import 'package:nivaldomotos/widgets/button.dart';

import 'package:scoped_model/scoped_model.dart';

class CartPrice extends StatelessWidget {
  final VoidCallback buy;

  CartPrice(this.buy);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: ScopedModelDescendant<CartModel>(
          builder: (context, child, model) {
            double price = model.getProductsPrice();
            double discount = model.getDiscount();
            double ship = model.getShipPrice();

            double total = (price + ship - discount);

            var subTotalMask =
                new MoneyMaskedTextController(leftSymbol: 'R\$ ');
            subTotalMask.updateValue(price);

            var descontoMask =
                new MoneyMaskedTextController(leftSymbol: 'R\$ ');
            descontoMask.updateValue(discount);

            var entregaMask = new MoneyMaskedTextController(leftSymbol: 'R\$ ');
            entregaMask.updateValue(ship);

            var totalMask = new MoneyMaskedTextController(leftSymbol: 'R\$ ');
            totalMask.updateValue(total);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  "Resumo do Pedido".toUpperCase(),
                  textAlign: TextAlign.start,
                  style: cartTitleStyle,
                ),
                SizedBox(
                  height: 12.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Subtotal", style: cartSubTitleStyle),
                    Text(subTotalMask.text, style: cartSubTitleStyle)
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Desconto", style: cartSubTitleStyle),
                    Text(descontoMask.text, style: cartSubTitleStyle)
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Entrega", style: cartSubTitleStyle),
                    Text(entregaMask.text, style: cartSubTitleStyle)
                  ],
                ),
                Divider(),
                SizedBox(
                  height: 12.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Total",
                      style: cartTitleStyle,
                    ),
                    Text(
                      totalMask.text,
                      style: cartTitleStyle,
                    )
                  ],
                ),
                SizedBox(height: 30),
                ButtonFunction(function: buy, text: "Finalizar Pedido"),
              ],
            );
          },
        ),
      ),
    );
  }
}
