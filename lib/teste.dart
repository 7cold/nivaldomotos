import 'package:flutter/material.dart';
import 'package:mercado_pago_mobile_checkout/mercado_pago_mobile_checkout.dart';
import 'package:mercadopago_sdk/mercadopago_sdk.dart';

const publicKey = "TEST-5ae70d6a-06a2-4d4d-a67a-c2e33d66d198";
const preferenceId = "38201203-42c77a7c-c857-43c9-be47-803c9de2e213";
var result;

class Teste extends StatefulWidget {
  @override
  _TesteState createState() => _TesteState();
}

Future<Map<String, dynamic>> preferenceGet() async {
  var mp = MP("4618697567453611", "7Vb1745xBCAbFfD6CmMFpDnkkTkZSZqs");

  var preference = {
    "items": [
      {"title": "Test", "quantity": 1, "currency_id": "BRL", "unit_price": 10.4}
    ]
  };

  result = await mp.createPreference(preference);

  return result;
}

class _TesteState extends State<Teste> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            child: Text("nova compra"),
            onPressed: () async {
              var result = await MercadoPagoMobileCheckout.startCheckout(
                publicKey,
                preferenceId,
              );
              print(result);
            },
          ),
          RaisedButton(
            child: Text("teste preference"),
            onPressed: () async {
              await preferenceGet();
              print(result['response']['id']);
            },
          ),
        ],
      ),
    ));
  }
}
