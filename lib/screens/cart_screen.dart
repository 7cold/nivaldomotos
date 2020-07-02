import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nivaldomotos/constants/colors.dart';
import 'package:nivaldomotos/constants/contants.dart';
import 'package:nivaldomotos/constants/fonts.dart';
import 'package:nivaldomotos/models/cart_model.dart';
import 'package:nivaldomotos/widgets/cart_price.dart';
import 'package:nivaldomotos/widgets/discount_card.dart';
import 'package:nivaldomotos/widgets/notification.dart';
import 'package:nivaldomotos/widgets/product_cart_screen.dart';
import 'package:scoped_model/scoped_model.dart';
import 'order_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();
  String data = "Nenhuma notificação";

  String typeShipping;
  void initState() {
    super.initState();
    typeShipping = "retirar_loja";
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) {
        print('on message $message');

        setState(() {
          data = message.toString();
        });
      },
      onResume: (Map<String, dynamic> message) {
        print('on resume $message');

        setState(() {
          data = message.toString();
        });
      },
      onLaunch: (Map<String, dynamic> message) {
        print('on launch $message');

        setState(() {
          data = message.toString();
        });
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
  }

  void _carregando() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActivityIndicator();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Sacola".toUpperCase(),
          style: TextStyle(
              fontFamily: fontExtraBold,
              fontSize: 24,
              color: Color(accentColor)),
        ),
        centerTitle: true,
        backgroundColor: Color(backgroundColorDark),
        actions: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(right: 15),
            child: ScopedModelDescendant<CartModel>(
              builder: (context, child, model) {
                int p = model.products.length;
                return Text(
                  "${p ?? 0} ${p == 1 ? "item" : "itens"}",
                  style: TextStyle(fontFamily: fontSemiBold),
                );
              },
            ),
          )
        ],
      ),
      body: ScopedModelDescendant<CartModel>(
        builder: (context, child, model) {
          if (model.products == null || model.products.length == 0) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Não há Produtos,\nvolte para continuar!",
                  style: TextStyle(
                      fontFamily: fontBold,
                      color: Color(backgroundColorDark),
                      fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                Center(
                  child: Image.asset(
                    "assets/images/no_data.png",
                    scale: 8,
                  ),
                ),
              ],
            );
          } else {
            return ListView(
              physics: BouncingScrollPhysics(),
              children: <Widget>[
                Column(
                  children: model.products.map((product) {
                    return ProductCartScreen(product);
                  }).toList(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Material(
                    elevation: 3,
                    shadowColor: Colors.white,
                    borderRadius: borderAll,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: borderAll, color: Colors.white),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding:
                                EdgeInsets.only(left: 20, bottom: 10, top: 10),
                            child: Text(
                              "Tipo de Envio",
                              style: cartSubTitleStyle,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      typeShipping = "retirar_loja";
                                      CartModel.of(context)
                                          .setShipping(typeShipping);
                                      CartModel.of(context)
                                          .setShippingPrice(0.0);
                                      print(typeShipping);
                                    });
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 70,
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    decoration: BoxDecoration(
                                      borderRadius: borderAll,
                                      color:
                                          Color(accentColor).withOpacity(0.2),
                                      border: Border.all(
                                        color: Color(
                                            typeShipping == "retirar_loja"
                                                ? primaryColor
                                                : backgroundColor),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "Retirar na loja",
                                          style: ordersubTitleStyle,
                                        ),
                                        SizedBox(height: 5),
                                        Image.asset(
                                          "assets/icons/shop.png",
                                          scale: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      typeShipping = "entrega_motoboy";
                                      CartModel.of(context)
                                          .setShipping(typeShipping);
                                      CartModel.of(context)
                                          .setShippingPrice(6.99);
                                      print(typeShipping);
                                    });
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 70,
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    decoration: BoxDecoration(
                                      borderRadius: borderAll,
                                      color:
                                          Color(accentColor).withOpacity(0.2),
                                      border: Border.all(
                                        color: Color(
                                            typeShipping == "entrega_motoboy"
                                                ? primaryColor
                                                : backgroundColor),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "Via Motoboy",
                                          style: ordersubTitleStyle,
                                        ),
                                        SizedBox(height: 5),
                                        Image.asset(
                                          "assets/icons/truck.png",
                                          scale: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                DiscountCard(),
                CartPrice(() async {
                  _carregando();
                  await model.preferenceGetMP();
                  String orderId = await model.finishOrder();
                  if (orderId != null) {
                    enviarNotificacao();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) =>
                            OrderScreen(orderId, typeShipping),
                      ),
                    );
                  }
                }),
              ],
            );
          }
        },
      ),
    );
  }
}
