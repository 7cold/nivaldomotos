import 'package:flutter/material.dart';
import 'package:mercado_pago_mobile_checkout/mercado_pago_mobile_checkout.dart';
import 'package:nivaldomotos/constants/colors.dart';
import 'package:nivaldomotos/constants/fonts.dart';
import 'package:nivaldomotos/models/cart_model.dart';
import 'package:scoped_model/scoped_model.dart';

// const publicKey = "APP_USR-5803d3ed-5ee3-44f8-beaa-747e22ae13ac";
const publicKey = "TEST-5ae70d6a-06a2-4d4d-a67a-c2e33d66d198";

class PagamentoMPScreen extends StatelessWidget {
  final refIdMP;
  final docId;

  const PagamentoMPScreen({Key key, this.refIdMP, this.docId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(refIdMP);
    return ScopedModelDescendant<CartModel>(
      builder: (context, child, model) {
        return Scaffold(
          backgroundColor: Color(mpColor),
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  "assets/images/mercado-pago.png",
                  scale: 4,
                ),
                SizedBox(height: 20),
                OutlineButton(
                  focusColor: Colors.white,
                  highlightedBorderColor: Colors.white,
                  highlightColor: Color(mobileColor),
                  borderSide: BorderSide(color: Colors.white),
                  child: Text(
                    "AVANÇAR",
                    style: buttonStyle,
                  ),
                  onPressed: () async {
                    var result = await MercadoPagoMobileCheckout.startCheckout(
                      publicKey,
                      refIdMP,
                    );
                    print(result);
                    await model.createPayInfo(docId, result);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
