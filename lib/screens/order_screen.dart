import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';
import 'package:nivaldomotos/constants/colors.dart';
import 'package:nivaldomotos/constants/contants.dart';
import 'package:nivaldomotos/constants/fonts.dart';
import 'package:nivaldomotos/widgets/button.dart';
import 'my_orders.dart';
import 'package:flare_flutter/flare_actor.dart';

class OrderScreen extends StatelessWidget {
  final String orderId;
  final String typeShipping;
  OrderScreen(this.orderId, this.typeShipping);

  final FlareControls _controls = FlareControls();

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
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.all(16.0),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 200,
                child: FlareActor(
                  "assets/animators/success_not_repeat.flr",
                  animation: "Untitled",
                  fit: BoxFit.contain,
                  controller: _controls,
                ),
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
                    TextSpan(text: '$orderId', style: orderSuccessStyle),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Material(
                elevation: 5,
                shadowColor: Colors.white,
                borderRadius: borderAll,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: borderAll,
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: typeShipping == "retirar_loja"
                        ? Column(
                            children: <Widget>[
                              Text(
                                "Você selecionou a retirada na loja",
                                style: orderTitle2Style,
                              ),
                              SizedBox(height: 12),
                              Text(
                                "Dentro de 30 min seu pedido será separado para retirada. Para mais informações acesse 'Meus Pedidos' ou entre em contato pelo chat.",
                                style: orderText2Style,
                              )
                            ],
                          )
                        : Column(
                            children: <Widget>[
                              Text(
                                "Você selecionou o envio pelo Motoboy",
                                style: orderTitle2Style,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 12),
                              Text(
                                "Até o fim do dia seu pedido será entregue. Para mais informações acesse 'Meus Pedidos' ou entre em contato pelo chat.",
                                style: orderText2Style,
                                textAlign: TextAlign.justify,
                              )
                            ],
                          ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              ButtonFunction(
                  function: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => MyOrders()));
                  },
                  text: "meus pedidos"),
            ],
          ),
        ),
      ),
    );
  }
}
