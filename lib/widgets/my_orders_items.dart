import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:nivaldomotos/constants/colors.dart';
import 'package:nivaldomotos/constants/contants.dart';
import 'package:nivaldomotos/constants/fonts.dart';
import 'package:nivaldomotos/models/cart_model.dart';
import 'package:nivaldomotos/widgets/loading.dart';
import 'package:date_format/date_format.dart';
import 'package:scoped_model/scoped_model.dart';

class MyOrdersItems extends StatelessWidget {
  final String orderId;

  MyOrdersItems(this.orderId);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<CartModel>(
      builder: (context, child, model) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Material(
            color: Colors.white,
            borderRadius: borderAll,
            elevation: 7,
            shadowColor: Colors.white,
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: borderAll, color: Colors.white),
              margin: EdgeInsets.all(10),
              child: StreamBuilder<DocumentSnapshot>(
                  stream: Firestore.instance
                      .collection("orders")
                      .document(orderId)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return Center(
                        child: LoadingWidget(),
                      );
                    else {
                      int status = snapshot.data["status"];

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          RichText(
                            text: TextSpan(
                              text: 'Cod. Pedido: ',
                              style: ordersubTitleStyle,
                              children: <TextSpan>[
                                TextSpan(
                                    text: '${snapshot.data.documentID}',
                                    style: orderTitleStyle),
                              ],
                            ),
                          ),
                          SizedBox(height: 6.0),
                          RichText(
                            text: TextSpan(
                              text: 'Data: ',
                              style: ordersubTitleStyle,
                              children: <TextSpan>[
                                TextSpan(
                                    text:
                                        '${formatDate(snapshot.data['date'].toDate(), [
                                      dd,
                                      '/',
                                      mm,
                                      '/',
                                      yyyy,
                                      ' - ',
                                      HH,
                                      ':',
                                      nn
                                    ])}',
                                    style: orderTitleStyle),
                              ],
                            ),
                          ),
                          SizedBox(height: 6.0),
                          Text(
                            _buildProductsText(snapshot.data),
                            style: ordersubTitleStyle,
                          ),
                          SizedBox(
                            height: 6.0,
                          ),
                          Text(
                            "Status do Pedido:",
                            style: orderTitleStyle,
                          ),
                          SizedBox(
                            height: 4.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              _buildCircle("1", "Preparação", status, 1),
                              Container(
                                height: 1.0,
                                width: 40.0,
                                color: Colors.grey[500],
                              ),
                              _buildCircle("2", "Transporte", status, 2),
                              Container(
                                height: 1.0,
                                width: 40.0,
                                color: Colors.grey[500],
                              ),
                              _buildCircle("3", "Entrega", status, 3),
                            ],
                          ),
                          SizedBox(height: 4.0),
                          OutlineButton(
                            color: Color(primaryColor),
                            highlightColor: Color(accentColor).withOpacity(0.8),
                            highlightedBorderColor: Color(primaryColor),
                            onPressed: status == 1
                                ? () {
                                    FlutterOpenWhatsapp.sendSingleMessage(
                                      "5535997371366",
                                      "Olá, gostaria de cancelar meu pedido: *${snapshot.data.documentID}*",
                                    );
                                    model.pararPedido(
                                        '${snapshot.data.documentID}');
                                  }
                                : null,
                            child: Text("Cancelar"),
                          )
                        ],
                      );
                    }
                  }),
            ),
          ),
        );
      },
    );
  }

  String _buildProductsText(DocumentSnapshot snapshot) {
    String text = "Descrição:\n";
    for (LinkedHashMap p in snapshot.data["products"]) {
      text +=
          "${p["quantity"]} x ${p["product"]["title"]} (R\$ ${p["product"]["price"].toStringAsFixed(2)})\n";
    }
    text += "Total: R\$ ${snapshot.data["totalPrice"].toStringAsFixed(2)}";
    return text;
  }

  Widget _buildCircle(
      String title, String subtitle, int status, int thisStatus) {
    Color backColor;
    Widget child;

    if (status < thisStatus) {
      backColor = Color(backgroundColorDark);
      child = Text(
        title,
        style: orderNumberCircleStyle,
      );
    } else if (status == thisStatus) {
      backColor = Color(primaryColor);
      child = Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Text(
            title,
            style: orderNumberCircleStyle,
          ),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          )
        ],
      );
    } else {
      backColor = Colors.green;
      child = Icon(
        Icons.check,
        color: Colors.white,
      );
    }

    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 20.0,
          backgroundColor: backColor,
          child: child,
        ),
        Text(
          subtitle,
          style: orderTextStyle,
        )
      ],
    );
  }
}
